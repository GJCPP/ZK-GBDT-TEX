# ZK-GBDT Technical Overview

最后更新：2026-04-03

## 1. 文档目标

本文档不是论文正文，而是供后续修改论文时使用的技术指导。其目标是统一回答以下三个问题：

1. 我们究竟要证明什么；
2. 每个子问题对应哪些原语；
3. 每个原语的正式关系、作用边界、以及在整套协议中的位置是什么。

全文默认延续当前主稿的叙事方向：

- 论文目标是一个面向安全系统论文风格的 ZK-GBDT 架构；
- 训练证明的核心难点不是“把所有训练步骤编译成一个巨大的 generic circuit”，而是将 split search 重写为一组结构化的张量关系；
- `domain lifting batch / replication / interleaving batch` 与 `histogram / aggregation` 应并列视为本文两条核心贡献线；
- 其中前者提供统一的代数 batching / shape-alignment layer，后者负责把 split search 重写成可证明的统计关系；
- lookup、KZG、softmax 非线性证明、max-selection gadget 等应尽量以 imported subroutine 的身份出现，而不是被误写成本文的主贡献。

## 2. 全局记号

### 2.1 域与多项式编码

我们工作在有限域 $\mathbb{F}$ 上。固定整数 $L \ge 1$，并固定一个 primitive $2^L$-th root of unity $\omega \in \mathbb{F}$。对任意 $n \mid 2^L$，定义
$$
\omega_n := \omega^{2^L/n},
\qquad
\mathbb{H}_n := \langle \omega_n \rangle,
\qquad
\nu_n(X) := X^n - 1.
$$

因此 $\mathbb{H}_n$ 是大小为 $n$ 的乘法子群，$\nu_n$ 是其 vanishing polynomial。若 $n,m,nm$ 均为 $2$ 的幂且整除 $2^L$，则
$$
\omega_{nm}^m = \omega_n.
$$

这条兼容性是后续所有 shape lifting / replication / interleaving 的代数基础。

对向量 $\mathbf{v}=(v_0,\dots,v_{n-1}) \in \mathbb{F}^n$，其在 $\mathbb{H}_n$ 上的拉格朗日编码为
$$
v(X) := \sum_{i \in [n]} v_i \lambda_n^{(i)}(X),
$$
其中 $\lambda_n^{(i)}(X)$ 为 $\mathbb{H}_n$ 上的第 $i$ 个 Lagrange basis polynomial。

所有矩阵、张量默认按 row-major 顺序 flatten 成向量后再承诺。故“承诺一个张量”等价于“承诺其 flatten 后的编码多项式”。

### 2.2 数据、模型与训练参数

令

- $M$：训练样本数；
- $d$：特征维度；
- $B$：每个特征的量化 bin 数；
- $K$：类别数；
- $T$：boosting rounds；
- $\mu \in \mathbb{F}$：公开学习率。

量化训练集记为
$$
\mathbf{D} \in [B]^{M \times d},
$$
one-hot 标签记为
$$
\mathbf{Y} \in \{0,1\}^{M \times K}.
$$

第 $t$ 轮的累计分数矩阵、pseudo-residual 矩阵分别记为
$$
\mathbf{S}^{(t)} \in \mathbb{F}^{M \times K},
\qquad
\mathbf{G}^{(t)} \in \mathbb{F}^{M \times K}.
$$

其中：

- $\mathbf{S}^{(t)}[r,k]$ 表示在第 $t$ 轮开始训练下一批树之前，当前 ensemble 对样本 $r$、类别 $k$ 给出的累计 score；
- $\mathbf{G}^{(t)}[r,k]$ 表示第 $t$ 轮用于训练类别 $k$ 对应回归树的 pseudo-residual。

对每轮训练得到的叶值，我们记
$$
\mathbf{W}^{(t)} \in \mathbb{F}^{N_{\mathrm{ext}} \times K},
$$
其中 $\mathbf{W}^{(t)}[u,k]$ 表示第 $t$ 轮中、类别 $k$ 对应树的叶子 $u$ 上存储的输出值。若实现上需要与全局节点空间对齐，也可使用其 padded 版本
$$
\widetilde{\mathbf{W}}^{(t)} \in \mathbb{F}^{N_{\mathrm{tot}} \times K},
$$
其中内部节点位置填零。

在某些讨论中，我们也可把所有轮次的 score / residual 堆叠成三维张量
$$
\mathcal{S}\in\mathbb{F}^{T \times K \times M},
\qquad
\mathcal{G}\in\mathbb{F}^{T \times K \times M},
$$
满足
$$
\mathcal{S}[t,k,r] := \mathbf{S}^{(t)}[r,k],
\qquad
\mathcal{G}[t,k,r] := \mathbf{G}^{(t)}[r,k].
$$
在这个视角下，softmax 的归一化轴就是类别轴 $K$。

每轮为每个类别训练一棵回归树，因此总树数为 $TK$。

### 2.3 索引与 Reshape 约定

为避免后文在节点编号、叶子编号与张量乘法上产生歧义，我们固定以下约定。

首先，所有树共享同一个全局节点编号空间：
$$
[N_{\mathrm{tot}}] = [N_{\mathrm{int}}] \ \sqcup\ \{N_{\mathrm{int}},\dots,N_{\mathrm{tot}}-1\},
$$
其中前一部分是内部节点，后一部分是叶子。因此，若
$$
\boldsymbol{\ell}^{(t,k)}[r]
$$
表示样本 $r$ 在第 $t$ 轮、类别 $k$ 对应树中到达的叶子，我们默认它取值于
$$
\{N_{\mathrm{int}},\dots,N_{\mathrm{tot}}-1\}.
$$

其次，对任意张量
$$
\mathbf{A}\in\mathbb{F}^{N_{\mathrm{tot}} \times d \times B},
$$
记
$$
\operatorname{Flat}(\mathbf{A}) \in \mathbb{F}^{N_{\mathrm{tot}} \times dB}
$$
为将最后两个轴按 row-major 顺序拼接后的矩阵。以后凡是出现
$$
\mathbf{L} \cdot \mathbf{A}
\qquad\text{或}\qquad
\mathbf{R} \cdot \mathbf{A},
$$
若 $\mathbf{A}$ 本身是三维张量，默认都应理解为
$$
\mathbf{L} \cdot \operatorname{Flat}(\mathbf{A})
\qquad\text{或}\qquad
\mathbf{R} \cdot \operatorname{Flat}(\mathbf{A}),
$$
再在语义上 reshape 回对应张量形状。

最后，若某对象既有“只保留叶子行”的紧凑版本，也有“嵌回全局节点空间、在内部节点位置补零”的 padded 版本，则分别用
$$
\mathbf{W}^{(t)}
\qquad\text{和}\qquad
\widetilde{\mathbf{W}}^{(t)}
$$
表示。

### 2.4 森林编码

记总节点数、内部节点数、叶子数分别为
$$
N_{\mathrm{tot}},\qquad
N_{\mathrm{int}},\qquad
N_{\mathrm{ext}}.
$$

本文采用 hyperbox-style forest encoding。承诺对象至少包括：

- routing matrices
  $$
  \mathbf{L},\mathbf{R}\in\{0,1\}^{N_{\mathrm{tot}} \times N_{\mathrm{tot}}};
  $$
  它们是 row-sparse 的 elementary routing matrices。对每个内部节点 $u$，恰有一个位置满足
  $$
  \mathbf{L}[u,v]=1 \iff v=\operatorname{left}(u),
  \qquad
  \mathbf{R}[u,v]=1 \iff v=\operatorname{right}(u),
  $$
  而叶子对应的行全为零。它们的用途有两个：
  1. 作为树结构的一部分，指明左右子节点；
  2. 作为线性传播算子，把叶子或子节点上的张量向父节点方向聚合，例如
     $$
     \mathbf{L} \cdot \mathbf{C} + \mathbf{R} \cdot \mathbf{C}.
     $$
- 节点 hyperbox 下界与上界
  $$
  \mathbf{N}^{\leftarrow},\mathbf{N}^{\rightarrow} \in [B+1]^{N_{\mathrm{tot}} \times d};
  $$
  其第 $u$ 行编码节点 $u$ 的半开区间盒
  $$
  \prod_{j=0}^{d-1}
  \left[
  \mathbf{N}^{\leftarrow}[u,j],
  \mathbf{N}^{\rightarrow}[u,j]
  \right).
  $$
  样本 $\mathbf{x}\in[B]^d$ 落入该节点当且仅当
  $$
  \mathbf{N}^{\leftarrow}[u,j] \le x_j < \mathbf{N}^{\rightarrow}[u,j],
  \qquad \forall j\in[d].
  $$
- split feature selection matrix
  $$
  \mathbf{E}\in\{0,1\}^{N_{\mathrm{tot}} \times d};
  $$
  其第 $u$ 行是一个 one-hot selector：若节点 $u$ 为内部节点，则
  $$
  \mathbf{E}[u,j]=1
  $$
  表示该节点按第 $j$ 个特征分裂；若 $u$ 为叶子，则该行应为零。它的用途是：
  1. 在 well-formedness 中指明哪一维的区间被切开；
  2. 在 optimal split proof 中把 committed split feature 与 argmax 结果绑定。
- threshold selection tensor
  $$
  \boldsymbol{\Theta}\in\{0,1\}^{N_{\mathrm{tot}} \times d \times B};
  $$
  其中
  $$
  \boldsymbol{\Theta}[u,j,b]=1
  $$
  表示节点 $u$ 选择在特征 $j$ 的第 $b$ 个 bin 处切分。对每个内部节点 $u$，它应与 $\mathbf{E}[u,\cdot]$ 一致：只有被选中的特征对应的 bin 轴上允许出现一个 one-hot 选择。它的用途是：
  1. 更新子节点的 hyperbox；
  2. 将 candidate split score tensor 上的 argmax 与 committed threshold 绑定。
- tree index vector 与 root matrix
  $$
  \mathbf{tree}\in[TK]^{N_{\mathrm{tot}}},
  \qquad
  \mathbf{Root}\in\{0,1\}^{TK \times N_{\mathrm{tot}}};
  $$
  其中 $\mathbf{tree}[u]$ 给出节点 $u$ 所属树的编号。$\mathbf{Root}$ 的第 $(tK+k)$ 行是一个 row selector，选出“第 $t$ 轮、类别 $k$ 的那棵树”的根节点。它们的用途是：
  1. 检查每棵树有且仅有一个根；
  2. 在 inference/fetch 中按 tree id 取回对应叶子行。
- leaf score vector
  $$
  \mathbf{score}\in\mathbb{F}^{N_{\mathrm{tot}}}.
  $$
  其叶子位置存储推理时应返回的标量分数，内部节点位置通常为零或 padding。它在 batched inference 中先被逐树逐样本取回，再沿 tree / round 维度聚合成最终类别分数。

## 3. 论文的核心问题

整套系统可被分解为以下问题族。

### P-Compat. 异构 Domain 与 Shape 的统一 Batching

在进入具体的 inference 与 training 关系之前，首先存在一个更基础的问题：协议中的中间对象并不天然 living on the same domain，也不天然具有相同 layout。

具体而言，不同子步骤会同时产生：

- 定义在不同子群 $\mathbb{H}_{n_1},\dots,\mathbb{H}_{n_s}$ 上的多项式关系；
- 长度不同但语义同型的 witness bundles；
- 需要按点验证的非线性关系族。

因此第一个核心问题是：

如何在不引入大规模 generic circuit 的前提下，将这些异构对象统一到同一个 algebraic batching interface 上？

对应的工具正是：

- domain lifting batch；
- replication；
- interleaving batch。

### P0. 森林表示正确性

需要证明 committed forest 的图结构、树编号、hyperbox 继承关系、split feature 与 threshold 选择是一致的。

形式上，这要求一组 well-formedness constraints。例如：

$$
\mathbf{Root} \cdot \mathbf{N}^{\leftarrow} = \mathbf{0},
\qquad
\mathbf{Root} \cdot \mathbf{N}^{\rightarrow} = (B+1)\mathbf{1},
$$

$$
\mathbf{Root} \cdot \mathbf{tree} = (0,1,\dots,TK-1),
$$

$$
\mathbf{L} \cdot \mathbf{tree} =
\mathbf{R} \cdot \mathbf{tree} =
\mathbf{tree}_{\mathrm{int}}.
$$

此外还需约束：被选中的 split coordinate 上，左右子节点的区间在 threshold 处切开；未被选中的 coordinate 上，父子区间保持不变。

### P1. Batched forest inference

对输入批次
$$
\mathbf{X}\in[B]^{b \times d},
$$
需要证明每个样本在每棵树中被唯一一个叶子接受，并且聚合后的类别分数正确。

这可形式化为两层关系：

1. 从森林表中取回与每个 tree-sample pair 对应的叶子 metadata；
2. 证明取回的 hyperbox 确实包含对应输入。

在训练场景中，我们还会得到 leaf-assignment vector
$$
\boldsymbol{\ell}^{(t,k)} \in \{N_{\mathrm{int}},\dots,N_{\mathrm{tot}}-1\}^{M},
$$
其第 $r$ 项表示样本 $r$ 在第 $t$ 轮、类别 $k$ 对应树中到达的全局叶子编号。

### P2. Boosting score accumulation 与 pseudo-residual

第 $t$ 轮训练需要证明：

1. 上一轮叶值确实被正确加回 score matrix；
2. pseudo-residual 的 softmax 公式正确。

形式上，score update 应满足

$$
\mathbf{S}^{(t)}[r,k] = \mathbf{S}^{(t-1)}[r,k] + \mu \cdot \widetilde{\mathbf{W}}^{(t-1)}[\boldsymbol{\ell}^{(t-1,k)}[r],k],
$$

其中：

- $\boldsymbol{\ell}^{(t-1,k)}[r]$ 表示样本 $r$ 在上一轮对应树中落到的叶子；
- $\widetilde{\mathbf{W}}^{(t-1)}[\cdot,k]$ 是第 $t-1$ 轮、类别 $k$ 的 padded leaf-value column；
- 整个更新把“按 leaf index 取回叶值”与“将其加回累计分数矩阵”这两步绑定在一起。

pseudo-residual 应满足

$$
\mathbf{G}^{(t)}[r,k] = \mathbf{Y}[r,k] -
\frac{\exp(\mathbf{S}^{(t)}[r,k])}
{\sum_{c=0}^{K-1}\exp(\mathbf{S}^{(t)}[r,c])}.
$$

若改用堆叠张量视角，则可写成
$$
\mathcal{P}[t,k,r] := \exp(\mathcal{S}[t,k,r]),
\qquad
\mathcal{Z}[t,r] := \sum_{c=0}^{K-1}\mathcal{P}[t,c,r],
$$
$$
\mathcal{G}[t,k,r] = \mathbf{Y}[r,k] - \frac{\mathcal{P}[t,k,r]}{\mathcal{Z}[t,r]}.
$$

这个写法也说明 softmax 可以自然看成一个“按类别轴归一化”的三维张量关系。若写成协议参数，其最自然的轴识别是
$$
\texttt{outer\_count}=T,\qquad
\texttt{middle\_count}=K,\qquad
\texttt{inner\_count}=M.
$$

### P3. Leaf-level histogram construction

这是训练证明的核心问题。对每轮 $t$、类别 $k$、节点 $u$、特征 $j$、bin $b$，需要构造：
$$
\mathbf{C}^{(t,k)}[u,j,b] :=
\#\{r : \boldsymbol{\ell}^{(t,k)}[r]=u \land \mathbf{D}[r,j]=b\},
$$
$$
\mathbf{H}^{(t,k)}[u,j,b] :=
\sum_{r:\ \boldsymbol{\ell}^{(t,k)}[r]=u,\ \mathbf{D}[r,j]=b}
\mathbf{G}^{(t)}[r,k].
$$

这里 $\mathbf{C}^{(t,k)}$ 是 count histogram，$\mathbf{H}^{(t,k)}$ 是 weighted histogram。

### P4. Internal-node histogram propagation

leaf histograms 只覆盖叶子。对 internal nodes，必须证明其 histogram 等于左右子节点 histogram 之和：

$$
\operatorname{Flat}\!\bigl(\mathbf{C}^{(t,k)}_{\mathrm{int}}\bigr) = \mathbf{L} \cdot \operatorname{Flat}\!\bigl(\mathbf{C}^{(t,k)}\bigr) + \mathbf{R} \cdot \operatorname{Flat}\!\bigl(\mathbf{C}^{(t,k)}\bigr),
$$

$$
\operatorname{Flat}\!\bigl(\mathbf{H}^{(t,k)}_{\mathrm{int}}\bigr) = \mathbf{L} \cdot \operatorname{Flat}\!\bigl(\mathbf{H}^{(t,k)}\bigr) + \mathbf{R} \cdot \operatorname{Flat}\!\bigl(\mathbf{H}^{(t,k)}\bigr).
$$

### P5. 从 histogram 到 split score

对固定 $(u,j)$，需要通过 bin 方向的 prefix sums 得到左子树统计量：
$$
\mathbf{C}^{(t,k)}_{\leq}[u,j,b] :=
\sum_{q=0}^{b}\mathbf{C}^{(t,k)}[u,j,q],
$$

$$
\mathbf{H}^{(t,k)}_{\leq}[u,j,b] := \sum_{q=0}^{b}\mathbf{H}^{(t,k)}[u,j,q].
$$

右子树统计量由总量减去前缀得到：

$$
\mathbf{C}^{(t,k)}_{>}[u,j,b] = \mathbf{C}^{(t,k)}_{\Sigma}[u,j] - \mathbf{C}^{(t,k)}_{\leq}[u,j,b],
$$

$$
\mathbf{H}^{(t,k)}_{>}[u,j,b] = \mathbf{H}^{(t,k)}_{\Sigma}[u,j] - \mathbf{H}^{(t,k)}_{\leq}[u,j,b].
$$

如果使用 RSS 的等价 gain 形式，则 candidate split score 满足

$$
\Gamma^{(t,k)}[u,j,b] = \frac{\big(\mathbf{H}^{(t,k)}_{\leq}[u,j,b]\big)^2}{\mathbf{C}^{(t,k)}_{\leq}[u,j,b]} + \frac{\big(\mathbf{H}^{(t,k)}_{>}[u,j,b]\big)^2}{\mathbf{C}^{(t,k)}_{>}[u,j,b]},
$$

但必须处理分母为零的情形。

### P6. 证明 committed split 是最优 split

对每个 internal node，必须证明 $\mathbf{E}$ 和 $\boldsymbol{\Theta}$ 选出的 feature-threshold pair 确实达到最大 score。

形式上可写为 feature-wise max 与 node-wise max：
$$
\mathbf{R}^{(t,k)}[u,j] := \max_{b \in [B]} \Gamma^{(t,k)}[u,j,b],
$$
$$
\mathbf{M}^{(t,k)}[u] := \max_{j \in [d]} \mathbf{R}^{(t,k)}[u,j].
$$

被选中的 $(j,b)$ 必须满足
$$
\Gamma^{(t,k)}[u,j,b] = \mathbf{R}^{(t,k)}[u,j] = \mathbf{M}^{(t,k)}[u].
$$

### P7. 叶值与下一轮更新

每轮训练结束后，需要证明每个叶子的 residual average 正确：

$$
\mathbf{n}^{(t,k)}[u] := \#\{r : \boldsymbol{\ell}^{(t,k)}[r]=u\},
$$

$$
\mathbf{a}^{(t,k)}[u] := \sum_{r:\ \boldsymbol{\ell}^{(t,k)}[r]=u}\mathbf{G}^{(t)}[r,k],
$$

$$
\mathbf{W}^{(t)}[u,k] = \frac{\mathbf{a}^{(t,k)}[u]}
{\mathbf{n}^{(t,k)}[u]}.
$$

然后再回到 P2 的 score accumulation。

## 4. 原语目录

这里将原语分成四类：

1. imported primitives；
2. 核心 batching / alignment primitives；
3. 核心 GBDT-specific primitives；
4. 已在代码中显式实现的 supporting composite protocols。

后续写论文时，应始终显式区分这四类。

### 4.1 Imported primitives

#### I1. KZG polynomial commitment

给定多项式 $f(X)$，其承诺记为 $[f(\tau)]_1$。我们只依赖其标准性质：

- succinct opening；
- additive homomorphism；
- random evaluation soundness。

KZG 本身不是本文贡献。

#### I2. Lookup / matrix lookup

基本 lookup relation：
$$
\mathbf{f} \subseteq \mathbf{t} \iff
\forall i \in [n],\ \exists j \in [N],\ f_i = t_j.
$$

matrix lookup relation：
$$
\mathbf{F} \subseteq \mathbf{T} \iff
\forall i \in [n],\ \exists r \in [N],\ \forall j \in [m],\ F_{i,j}=T_{r,j}.
$$

它用于：

- batched inference 中从叶子表取回 metadata；
- score update 中按 leaf index 取 leaf value；
- 任何“已承诺表上的行提取”。

lookup 本身不是本文贡献；本文最多可在 appendix / implementation note 中讨论其具体 instantiation。

#### I3. Basic nonlinear checks

非线性部件如
$$
\exp(\cdot),\qquad (\cdot)^{-1},\qquad \text{sign / range / selector checks}
$$
可以由标准 lookup-based gadget 或已有 zkML subroutine 提供。

这些基础非线性 check 不是本文主贡献；但它们可以被组合成更高层的 softmax protocol。

#### I4. Max-selection gadget

对于
$$
\max_{i} a_i
$$
或 argmax correctness 的证明，可视为标准 gadget。其功能是证明：

- 每个候选值都不超过 maximum；
- 某个被选索引处达到 maximum；
- 被选索引满足 one-hot / selection consistency。

max-selection 不是本文主贡献；本文贡献在于“要比较的对象 $\Gamma^{(t,k)}$ 是如何由 histogram 产生的”。

### 4.2 Core batching / alignment primitives

#### C1. Domain lifting

当若干 identity 分别定义在不同 domain $\mathbb{H}_{n_i}$ 上时，不能直接 batched zero-check。此时应将它们提升到共同大域 $\mathbb{H}_N$，其中
$$
N := \max_i n_i.
$$

若原命题为
$$
F_i(X) = Q_i(X)\nu_{n_i}(X),
$$
定义 lifted residual
$$
\widehat{F}_i(X) :=
F_i(X)\frac{\nu_N(X)}{\nu_{n_i}(X)}.
$$

则
$$
F_i(X)\equiv 0 \pmod{\nu_{n_i}(X)} \iff \widehat{F}_i(X)\equiv 0 \pmod{\nu_N(X)}.
$$

因此可进行统一 batch：

$$
\sum_{i=1}^{m}\eta^{i-1}\widehat{F}_i(X) = Q(X)\nu_N(X).
$$

作用：

- 合并不同长度对象上的线性 identity；
- 让 histogram / prefix / propagation / padding-induced checks 可以共用一个 ambient zero-check 模板。

这是本文第一条核心贡献线的一部分，而不是仅仅一个次要兼容层技巧。

#### C2. Replication

最关键的是 row replication。

给定向量 $\mathbf{v}\in\mathbb{F}^{m}$，构造
$$
\mathbf{V}\in\mathbb{F}^{r \times m},
\qquad
\mathbf{V}[i,j]=\mathbf{v}[j].
$$

若 $v(X)$ 是 $\mathbf{v}$ 在 $\mathbb{H}_m$ 上的编码，则 $\mathbf{V}$ 在 $\mathbb{H}_{rm}$ 上的编码满足
$$
V(X)=v(X^r).
$$

作用：

- 将同一批输入复制到所有树上做 batched inference；
- 将较短对象 lift 到较长 layout；
- 配合 interleaving 使多个 bundle 形状对齐。

replication 不应只被理解为一个说明性 lemma；更好的理解是：它是一类 shape-transport primitive。列复制、mask replication、table extension 都可视为这一思想的变体。

#### C3. Interleaving

对同长度向量
$$
\mathbf{a}^{(0)},\dots,\mathbf{a}^{(k-1)}\in\mathbb{F}^n,
$$
定义 interleaving
$$
\operatorname{Int}(\mathbf{a}^{(0)},\dots,\mathbf{a}^{(k-1)})\in\mathbb{F}^{kn}
$$
为
$$
\operatorname{Int}(\mathbf{a}^{(0)},\dots,\mathbf{a}^{(k-1)})[ik+t] :=
\mathbf{a}^{(t)}[i].
$$

它的作用不是“改变语义”，而是把多个 pointwise nonlinear relations 合并为同型大关系。

典型例子：若有两组检查
$$
h_1[i](\gamma-f_1[i])=c_1[i],\qquad i\in[n_1],
$$
$$
h_2[j](\gamma-f_2[j])=c_2[j],\qquad j\in[n_2],
$$
则可先将短的一组通过 replication / domain lifting 对齐到长度 $n_2$，再构造统一的 interleaved relation。

作用：

- 合并 lookup-style nonlinear checks；
- 降低 quotient witness / opening 数量；
- 避免每一类局部非线性约束都单独开一个 batch。

更抽象地说，interleaving batch 应被写成一个真正的 batching theorem：先把小 bundle 对齐到大域，再把多个同型 pointwise relation 合并成一个更大的 relation，而不只是把它当作一个服务于记号整理的小技巧。

### 4.3 Core GBDT-specific primitives

#### G1. Aggregation relation

aggregation 是本文第二条核心贡献线的起点。它描述“按照地址把若干样本贡献聚合到桶中”的关系。

给定

$$
\mathbf{ind}\in[N]^m, \qquad \mathbf{v}\in\mathbb{F}^m, \qquad \mathbf{h}\in\mathbb{F}^N,
$$

aggregation relation 定义为

$$
\forall u\in[N],\qquad \mathbf{h}[u] = \sum_{t:\ \mathbf{ind}[t]=u}\mathbf{v}[t].
$$

等价地，

$$
\mathbf{h}[u] = \sum_{t=0}^{m-1}\mathbf{v}[t]\cdot \mathbf{1}[\mathbf{ind}[t]=u].
$$

它可通过随机挑战 $\rho$ 的 generating-function check 来验证：

$$
\sum_{u=0}^{N-1}\mathbf{h}[u]\rho^u = \sum_{t=0}^{m-1}\mathbf{v}[t]\rho^{\mathbf{ind}[t]}.
$$

从协议结构上看，aggregation check 的自然输入正是 `(indices, values, histogram)` 三个承诺对象，而验证方式则可通过 challenge-power 映射与 lookup/sum-check 组合来完成。

作用：

- histogram 构造的底层机制；
- 叶值求和、计数、bin 聚合；
- 几乎所有“scatter-add”型逻辑的统一表达。

#### G2. Histogram relation

histogram relation 是 aggregation 在 ZK-GBDT 中的结构化实例化。

对固定 $(t,k)$，定义 address tensor
$$
\mathbf{addr}^{(t,k)}[r,j] :=
(\boldsymbol{\ell}^{(t,k)}[r]d + j)B + \mathbf{D}[r,j].
$$

该地址将样本 $r$ 在特征 $j$ 上的贡献送入三元桶 $(u,j,b)$，其中
$$
u=\boldsymbol{\ell}^{(t,k)}[r],\qquad b=\mathbf{D}[r,j].
$$

然后用 aggregation 同时构造：

- count histogram：令输入值恒为 $1$；
- weighted histogram：令输入值为 $\mathbf{G}^{(t)}[r,k]$。

也即：

$$
\mathbf{C}^{(t,k)}[u,j,b] =
\sum_{r=0}^{M-1}\mathbf{1}\!\left[
\boldsymbol{\ell}^{(t,k)}[r]=u \land \mathbf{D}[r,j]=b
\right],
$$

$$
\mathbf{H}^{(t,k)}[u,j,b] =
\sum_{r=0}^{M-1}
\mathbf{G}^{(t)}[r,k]
\cdot
\mathbf{1}\!\left[
\boldsymbol{\ell}^{(t,k)}[r]=u \land \mathbf{D}[r,j]=b
\right].
$$

这正是本文将“sorting proof”替换成“histogram proof”的核心桥梁。

#### G3. Prefix-sum relation

给定张量 $\mathbf{A}[u,j,b]$，prefix-sum relation 要求

$$
\mathbf{P}[u,j,b] =
\sum_{q=0}^{b}\mathbf{A}[u,j,q].
$$

在本文中主要用于：

- 从 histogram 得到 threshold 左侧统计量；
- 再由总和减去 prefix 得到右侧统计量。

prefix-sum 本身也可被看成 aggregation 的线性变体，但在论文表述上最好单独命名，因为它直接对应 split search 的 threshold scan。

#### G4. Zero-safe division

split score 与 leaf value 都需要 division，但分母可能为零。故需要显式引入 validity mask。

对 split score，可定义

$$
\boldsymbol{\chi}^{(t,k)}[u,j,b] = 1 \iff
\mathbf{C}^{(t,k)}_{\leq}[u,j,b] > 0 \ \land\ \mathbf{C}^{(t,k)}_{>}[u,j,b] > 0.
$$

然后令

$$
\Gamma^{(t,k)}[u,j,b] =
\boldsymbol{\chi}^{(t,k)}[u,j,b] \left(
\frac{\big(\mathbf{H}^{(t,k)}_{\leq}[u,j,b]\big)^2}{\mathbf{C}^{(t,k)}_{\leq}[u,j,b]+1-\boldsymbol{\chi}^{(t,k)}[u,j,b]} + \frac{\big(\mathbf{H}^{(t,k)}_{>}[u,j,b]\big)^2}{\mathbf{C}^{(t,k)}_{>}[u,j,b]+1-\boldsymbol{\chi}^{(t,k)}[u,j,b]}
\right).
$$

当 $\boldsymbol{\chi}^{(t,k)}[u,j,b]=1$ 时，上式退化成真实 split score；当其为 $0$ 时，上式被强制为 $0$ 且分母不为零。

同理，leaf value

$$
\mathbf{W}^{(t)}[u,k] =
\frac{\mathbf{a}^{(t,k)}[u]}
{\mathbf{n}^{(t,k)}[u]}
$$
也应使用类似 mask 机制处理 padding leaves 或空叶子。这里的 $\mathbf{W}^{(t)}$ 默认表示紧凑叶子空间上的对象；若要与全局叶子编号向量 $\boldsymbol{\ell}^{(t,k)}$ 直接组合，则应改用其 padded 版本 $\widetilde{\mathbf{W}}^{(t)}$。

#### G5. Concatenated matrix lookup（可选扩展）

一个自然会出现的问题是：当多个表
$$
\mathbf{T}_0,\dots,\mathbf{T}_{s-1}
$$
宽度不同，但语义上描述同一个对象的不同属性时，如何只做一次 lookup 来同时取回它们。

目标关系为
$$
\mathbf{F}_0\|\mathbf{F}_1\|\cdots\|\mathbf{F}_{s-1}
\subseteq
\mathbf{T}_0\|\mathbf{T}_1\|\cdots\|\mathbf{T}_{s-1}.
$$

一种可行思路是：把各表按
$$
m := \operatorname{lcm}(m_0,\dots,m_{s-1})
$$
扩展到共同宽度，并用 mask polynomial 约束 extension integrity。

即使这部分不进入正文主线，它仍然具有技术价值，因为 inference 中往往要同时取回：

- tree index；
- lower bounds；
- upper bounds；
- leaf score；
- 可能还包括 leaf index。

未来若正文需要补强 lookup 层，这一 primitive 可以重新激活；否则正文可将其抽象为“one-shot row fetch over separately committed metadata tables”。

### 4.4 Supporting composite protocols

#### S1. Forest row fetch

一个自然的上层组合协议是 `forest row fetch`。它证明：
$$
\mathbf{tree}\ \|\ \mathbf{U}^{\leftarrow}\ \|\ \mathbf{U}^{\rightarrow}\ \|\ \mathbf{s}
\subseteq
\mathbf{tree}_{\mathrm{ext}}\ \|\ \mathbf{F}^{\leftarrow}\ \|\ \mathbf{F}^{\rightarrow}\ \|\ \mathbf{score},
$$
并可选地再拼接一个 leaf index 列。它的意义在于把 inference 层的“行提取”固定成一个可复用的 schema-aware subroutine。

#### S2. Forest inference

另一个自然的上层组合协议是 `forest inference`。它在 `forest row fetch` 之上再增加半开区间盒检查，形式上即
$$
\mathbf{U}^{\leftarrow} \le \mathbf{X}^{\mathrm{rep}} < \mathbf{U}^{\rightarrow}.
$$
该模块有意停在“逐树逐样本取回叶子并证明输入落盒”这一步，而将 score reshaping / aggregation 留给上层。

#### S3. Explicit softmax protocol

softmax 也应被组织成一个明确的组合协议，而不应停留在占位描述。其逻辑可写成：
$$
\mathcal{P}[t,k,r] := \exp(\mathcal{S}[t,k,r]),
$$
$$
\mathcal{Z}[t,r] := \sum_{c=0}^{K-1}\mathcal{P}[t,c,r],
$$
$$
\widetilde{\mathcal{Z}}[t,k,r] := \mathcal{Z}[t,r]
\quad \text{沿类别轴复制},
$$
$$
\operatorname{Softmax}[t,k,r] :=
\frac{\mathcal{P}[t,k,r]}{\widetilde{\mathcal{Z}}[t,k,r]}.
$$

一个自然的实现分解是：

- `exp_check`：证明指数值；
- `cube_sum`：沿 middle axis 求和；
- `cube_middle_replication`：把 denominator 复制回整个 cube；
- `cube_middle_argmax`：可选地证明 row-max shifts；
- `signed_range_check` 等：支持 signed fixed-point 与 shifted / stabilized softmax。

因此，后续论文中不宜再把 softmax 写成“这里暂时略过”的空白区域；更好的写法是：它应被当作一个已有明确结构的 supporting composite protocol，而非本文最核心贡献。

## 5. 问题到解决方法的映射

本节回答“每个问题究竟靠什么解决”。

### 5.0 P-Compat 异构 Domain 与 Shape 的统一 Batching

解决方法分三层：

1. 用 domain lifting batch 把不同 $\mathbb{H}_{n_i}$ 上的 divisibility claims 提升到共同大域；
2. 用 replication 在不同 layout 之间搬运 witness，使语义相同的对象获得相同 shape；
3. 用 interleaving batch 将多个 pointwise nonlinear bundles 合并成统一的大 bundle。

所用原语：

- domain lifting batch；
- replication；
- interleaving batch；
- batched zero-check。

这不是单纯的“工程整理”，而是本文第一条核心贡献线本身。

### 5.1 P0 森林表示正确性

解决方法：

- 使用 hyperbox encoding；
- 使用线性代数约束检查 root box、tree consistency、parent-child box inheritance；
- 使用 one-hot / booleanity gadget 约束 $\mathbf{E}$ 与 $\boldsymbol{\Theta}$。

这里几乎不需要 histogram；也不应把这一部分写成本文唯一亮点。其作用是为后续 inference 与 training 提供统一的 committed state。

### 5.2 P1 Batched inference

解决方法分三步：

1. 对输入 $\mathbf{X}$ 做 replication，得到所有树共享的 query batch；
2. 使用 matrix lookup 或 concatenated matrix lookup，从叶子表中取回
   $$
   (\mathbf{ind},\mathbf{U}^{\leftarrow},\mathbf{U}^{\rightarrow},\mathbf{s});
   $$
3. 做 range relation
   $$
   \mathbf{U}^{\leftarrow} \le \mathbf{X}^{\mathrm{rep}} < \mathbf{U}^{\rightarrow},
   $$
   再按 tree 维度聚合 scores。

所用原语：

- replication；
- lookup；
- aggregation / tensor sum。

### 5.3 P2 Score accumulation 与 pseudo-residual

解决方法：

- 用全局 leaf index lookup 取 padded leaf value；
- 用线性关系证明 score update；
- 将 softmax 写成明确的 `exp -> cube sum -> middle replication -> division` 管线；
- 若采用数值稳定化版本，则再加上 explicit shift 或 row-max shift；
- 对按 class 的求和部分使用 cube-sum / aggregation。

所用原语：

- lookup；
- `exp_check` / inverse / range gadget；
- cube-middle replication；
- cube-sum；
- supporting softmax protocol。

注意：这一部分应被写成“已有明确构造的 supporting component”，而不是纯 imported black box。

### 5.4 P3 Leaf histogram construction

解决方法：

1. 从 inference 得到 leaf index vector $\boldsymbol{\ell}^{(t,k)}$；
2. 构造地址
   $$
   \mathbf{addr}^{(t,k)}[r,j]
   :=
   (\boldsymbol{\ell}^{(t,k)}[r]d+j)B+\mathbf{D}[r,j];
   $$
3. 对输入值 $1$ 做 aggregation，得到 count histogram；
4. 对输入值 $\mathbf{G}^{(t)}[r,k]$ 做 aggregation，得到 weighted histogram。

这是本文第二条核心贡献线的第一核心技术点。

需要始终强调：

- 我们不是去证明“排序过程”；
- 我们是直接证明“对 split search 足够的 histogram statistics”。

### 5.5 P4 Internal-node propagation

解决方法：

- 使用 routing matrices $\mathbf{L},\mathbf{R}$；
- 将 leaf histograms 通过线性关系向上传播到内部节点；
- 若不同对象因 padding 位于不同 domain，则先做 domain lifting，再统一 batch。

所用原语：

- domain lifting batch；
- batched zero-check；
- 线性张量关系。

### 5.6 P5 从 histogram 到 candidate split scores

解决方法：

1. 对 bin 维度做 prefix-sum，得到左侧统计量；
2. 用总和减去前缀得到右侧统计量；
3. 使用 zero-safe division 构造
   $$
   \Gamma^{(t,k)}[u,j,b].
   $$

这一步给出了 split search 的代数化表达。它是 histogram / aggregation 贡献线的直接收益。

所用原语：

- prefix sum；
- aggregation / total sum；
- zero-safe division。

### 5.7 P6 最优 split 选择

解决方法：

1. 先做 threshold 方向的 max；
2. 再做 feature 方向的 max；
3. 用 $\mathbf{E}$ 与 $\boldsymbol{\Theta}$ 将 committed split 与 argmax 结果绑定。

所用原语：

- max-selection gadget；
- one-hot selection constraints；
- 线性一致性检查。

注意论文写法：

- 这里的 novelty 不在 max gadget 本身；
- novelty 在于“被 max 的对象 $\Gamma$ 是通过 histogram pipeline 构造出来的”。

### 5.8 P7 叶值与 boosting update

解决方法：

- 用 aggregation 以全局 leaf index 为地址计算
  $$
  \mathbf{n}^{(t,k)},\ \mathbf{a}^{(t,k)};
  $$
- 再用 zero-safe division 得到
  $$
  \mathbf{W}^{(t)}[u,k].
  $$

若后续公式需要与全局节点编号直接组合，则再将其嵌回 padded 版本 $\widetilde{\mathbf{W}}^{(t)}$。

这一步与 histogram 构造在数学结构上非常相似，只是地址从 $(u,j,b)$ 缩减成 $u$。

## 6. 写论文时必须坚持的技术主线

### 6.1 主贡献的正确表述

后续改论文时，应优先坚持下面这套贡献边界：

1. 我们把 GBDT training proof 组织成一组结构化关系，而不是单体 generic circuit；
2. `domain lifting batch / replication / interleaving batch` 构成统一的 algebraic batching and shape-alignment layer；
3. `histogram / aggregation` 构成 split search 的统计桥梁，并将 sorting-style reasoning 替换为 histogram-style reasoning；
4. forest inference 与 training proof 被统一进同一套 committed-state + lookup + aggregation 架构。

### 6.2 不应误写成主贡献的内容

以下内容很重要，但不应抢走论文主线：

- KZG 本身；
- lookup 本身；
- softmax / exp / inverse 的一般性 gadget 本身；
- max-selection gadget 本身；
- 单纯的 hyperbox forest encoding。

这些内容在论文里应被表述为 imported component、prior technique、或 supporting machinery。

### 6.3 对旧稿内容的使用原则

`DraftForZKGBDT/` 中仍然有三类内容值得复用：

1. replication / concatenated lookup 的更细代数论证；
2. forest commitment 与 inference 的早期展开；
3. 某些“为什么需要该 primitive”的动机性说明。

但旧稿整体结构不应直接继承，因为它更像“原语清单 + 构造堆叠”，与当前系统安全论文风格不完全一致。

## 7. 推荐的后续写作顺序

如果未来要继续完善主稿，推荐按照以下顺序推进：

1. 先固定本文件中的符号系统与问题分解；
2. 再将 `Technical Overview` 写成“两条主线并列”：
   - batching / alignment 主线；
   - histogram / split-search 主线；
3. 然后在 `Construction` 中分模块实现：
   - batching / alignment layer；
   - forest encoding；
   - batched inference；
   - training proof；
   - soundness composition；
4. 最后再决定哪些旧稿中的 primitive proof 需要进正文，哪些只放 appendix。

## 8. 一句话总纲

整个 ZK-GBDT 系统应被理解为以下复合关系：
$$
\textsf{Batching / Alignment}
\;+\;
\textsf{Inference}
\;+\;
\textsf{Residual Update}
\;+\;
\textsf{Histogram Construction}
\;+\;
\textsf{Prefix / Division / Max}
\;+\;
\textsf{Leaf Update},
$$
其中真正区分 GBDT 与普通树推理证明的核心，是
$$
\bigl(
\textsf{Domain Lifting Batch}
\;+\;
\textsf{Replication}
\;+\;
\textsf{Interleaving Batch}
\bigr)
\;+\;
\bigl(\textsf{Histogram Construction} \Longrightarrow \textsf{Algebraization of Split Search}\bigr).
$$

这应当始终作为全文最稳定的技术中心。
