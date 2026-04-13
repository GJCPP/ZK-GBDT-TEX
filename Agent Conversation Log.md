# task/25/ZKGBDT 对话记录

最后更新：2026-04-03 17:50:00 +08:00

## 文档用途

本文件用于记录当前 ZK GBDT 论文与 LaTeX 项目的关键对话、决策和演化过程，
方便后续 AI agent 或人工协作者快速恢复上下文。

## 对话摘要

### 1. 初始项目搭建

- 用户首先要求为 ZK GBDT 论文搭建一个初始 TeX 项目框架。
- 已创建基础 LaTeX 项目结构，包括：
  - `main.tex`
  - 分章节文件
  - `figures/`、`tables/`
  - `.bib`
  - `.gitignore`
  - `README.md`
- 项目已经成功编译。

### 2. 阅读旧材料

- 用户要求先不要修改文件，而是阅读：
  - `DraftForZKDF/`
  - `task___25___ZK Decision Tree.md`
  - `task___25___ZKGBDT___AI Prompt.md`
- 随后报告了一个初步计划：
  - 将旧稿视为素材库，而不是固定结构；
  - 论文主线按 `Preliminary -> Technical Overview -> Construction` 组织；
  - 聚焦真正服务于 ZK GBDT 的贡献，而不是罗列过多原语。

### 3. 第一轮实质写作

- 用户指出 `histogram / aggregation` 必须作为本文贡献之一。
- 随后起草了若干章节：
  - Introduction
  - Background / preliminaries
  - Problem statement
  - Protocol / construction
- `histogram` 和 `aggregation` 被提升为显式贡献点。

### 4. 形式化改写

- 用户进一步要求按更正式的投稿草稿风格改写，包括：
  - 更严格的符号系统；
  - 明确的子群定义；
  - 使用 `\nu_n(X)=X^n-1` 表示 vanishing polynomial；
  - 更正式的 domain lifting；
  - soundness 分析。
- 已完成较强形式化改写：
  - `\mathbb{H}_n` 从共同的大根导出；
  - domain lifting、replication、interleaving、aggregation、histogram
    都被写成更严格的数学对象；
  - 文档编译通过。

### 5. 转向 CCS / SP / USENIX 风格

- 用户说明目标投稿方向是安全会议，而非纯密码方向会议。
- 用户提出的主要要求包括：
  - 降低过强的“密码学论文口吻”；
  - 改成更像 CCS 风格的技术叙述；
  - 让 training proof 更以数学公式为主；
  - 区分已有原语和本文新贡献；
  - 打磨术语；
  - 联网核验真实引用文献。

### 6. 引用核验与清理

- 已联网核验并清洗参考文献。
- 当前 `.bib` 中保留并使用了真实论文，包括：
  - KZG
  - Aurora
  - CQ / CQ++24
  - Baloo
  - Sparrow
  - ZKDT
  - zkCNN
  - Zero-Knowledge Proofs of Training for Deep Neural Networks
  - ZKBoost
  - Friedman 2001
  - XGBoost 2016
- 原先不稳或占位的引用已被删除或替换。

### 7. 第 2、3 节的大结构调整

- 用户指出第 2、3 节“密码味太重”，并建议参考 `zkPOT_CNN.pdf`。
- 根据这一反馈，论文结构做了明显调整：
  - 第 2 节改成读者导向的 preliminaries：
    符号、polynomial encoding、KZG 背景、plaintext GBDT training；
  - 在进入技术重写前，先解释 GBDT 训练流程；
  - 早期只保留最朴素的 RSS 定义；
  - 第 3 节改成 `Technical Overview`，而不再是正式 relation catalog。

### 8. 当前论文结构

- 当前结构为：
  - Introduction
  - Preliminaries
  - Technical Overview
  - Construction
  - Evaluation
  - Related Work
  - Conclusion
- 第 4 节目前包含：
  - compatibility layer
  - domain lifting
  - row replication
  - interleaving
  - forest representation
  - batched inference
  - 以公式驱动的 training proof
  - soundness composition

### 9. 最近一轮可读性改进

- 用户指出以下问题：
  - `sorting` 这个词出现得太突兀；
  - interleaving 写得太抽象，需要更具体解释和伪代码；
  - 需要整体检查是否还有突兀术语或缺少上下文的论证。
- 对应修改如下：
  - 在 preliminaries 中补充了明文 split search 里
    “按特征排序并扫描 threshold”的背景；
  - 在 technical overview 中明确把 plaintext sorting 与 histogram 视角联系起来；
  - 将 interleaving 小节扩展为：
    - 为什么需要它；
    - 一个基于 lookup / reversal check 的例子；
    - 一个 greedy interleaving scheduler 的伪代码。

## 当前状态

- LaTeX 项目目前可通过 `latexmk -pdf main.tex` 成功编译。
- 论文整体已经比早期版本更接近安全系统论文的写法，而不是密码学论文写法。
- 当前仍有进一步提升空间，主要在：
  - 可读性；
  - novelty 边界表达；
  - evaluation 设计；
  - overview 图表与 running example。

## 建议的下一步

- 继续打磨第 4 节，使其更像系统论文中的 protocol section。
- 增加训练证明流程总览图。
- 增加符号总结表。
- 增加一个 histogram-to-split-score 的小型 running example。
- 强化 evaluation 章节与 baseline 对比逻辑。

## 后续更新规则

未来的 AI agent 在每一轮有意义的交互之后，都应当向本文件追加一个带日期的小节，
用于记录新的进展，而不是覆盖旧内容。每次追加应至少包含：

- 用户这轮的请求；
- 本轮修改、决定或调查了什么；
- 新引入的术语、假设或结构变化；
- 当前编译 / 验证状态；
- 建议的下一步。

## 2026-04-03 19:31:09 +0800

### 用户本轮请求

- 阅读项目根目录下的 `.md` 文件以及 `DraftForZKGBDT/` 文件夹，了解项目目前情况。

### 本轮调查与结论

- 已阅读根目录说明文档：
  - `README.md`
  - `Agent Prompt.md`
  - `Agent Conversation Log.md`
  - `task___25___ZKGBDT___AI Prompt.md`
  - `task___25___ZK Decision Tree.md`
- 已阅读 `DraftForZKGBDT/` 中的主要论文文件：
  - `main.tex`
  - `draft/preliminary.tex`
  - `draft/overview.tex`
  - `draft/construction.tex`
  - `draft/implement primitives.tex`
  - `draft/draft.tex`
- 同时核对了当前根目录的主稿：
  - `main.tex`
  - `sections/01_introduction.tex` 到 `sections/07_conclusion.tex`
  - `bibliography/references.bib`
- 当前项目状态已经比较明确：
  - 根目录是一份较新的“系统安全论文风格”主稿，结构为 Introduction / Preliminaries / Technical Overview / Construction / Evaluation / Related Work / Conclusion；
  - `DraftForZKGBDT/` 是一份更早、更长、也更偏“研究草稿 / 原语堆叠”的旧稿，保留了很多原始推导、primitive 设计和 forest / lookup / replication / concatenated lookup 的早期写法；
  - 根目录 `.md` 文档记录了从旧稿到新稿的重构方向：弱化过强的密码学写法，突出 histogram / aggregation 作为核心贡献，并将 domain lifting、replication、interleaving 作为兼容层工具；
  - README 已经过时，只描述了最小 LaTeX scaffold，未反映当前论文已经发展到较完整草稿这一事实。

### 重要术语与结构判断

- 当前真正的主线贡献已经收敛到：
  - histogram / aggregation；
  - domain lifting；
  - replication；
  - interleaving；
  - batched inference 与 training proof 的结构化组织。
- 旧稿中的许多内容仍有参考价值，但不宜直接当成现行结构继续写，因为其章节组织仍然是：
  - Notation / Primitive intro / Overview / Construction / Implement primitives；
  - 叙事上也更偏“先讲原语，再讲系统”，与当前目标的 CCS / S&P / USENIX 风格不完全一致。
- 新主稿已经把论文叙事改成：
  - 先解释 GBDT 和 split-search 难点；
  - 再用 Technical Overview 解释 histogram 视角；
  - 最后在 Construction 中集中放兼容层、forest encoding、inference、training proof、soundness composition。

### 当前编译 / 验证状态

- 根目录主稿存在 `main.pdf`、`main.aux`、`main.bbl`、`main.log` 等产物。
- 从 `main.log` 末尾看，根目录主稿最近一次编译成功，输出为 3 页 PDF，未见明显致命错误。
- `DraftForZKGBDT/` 目录中也保留了 `main.pdf`，说明旧稿也曾成功编译。
- Git 状态显示：
  - `DraftForZKGBDT/` 当前是未跟踪目录；
  - `.codex` 也是未跟踪文件；
  - 说明旧稿更像“本地参考材料”而不是当前已正式纳入版本控制的主稿内容。

### 建议的下一步

- 如果后续继续写论文，应默认以根目录 `main.tex + sections/` 为主稿继续推进。
- 若要复用旧材料，建议只从 `DraftForZKGBDT/` 中抽取：
  - 更细的 primitive 论证；
  - forest commitment / inference 的早期表述；
  - 某些尚未迁移到新稿的技术细节。
- 一个很值得尽快处理的小维护项是更新 `README.md`，让它反映当前项目已不是“最小脚手架”，而是已有完整主稿、旧稿素材库与协作日志的论文仓库。

## 2026-04-03 19:36:11 +0800

### 用户本轮请求

- 基于项目现有全部材料，详细整理一份 `OVERVIEW`，系统列出原语、问题与解决方法，并使用较 formal 的数学符号表达，作为后续修改论文时的技术指导文档。

### 本轮修改与决定

- 新建了根目录文件 `OVERVIEW.md`。
- 文档明确采用“统一记号 -> 核心问题 -> 原语目录 -> 问题到解决方法映射 -> 写作主线约束”的组织方式。
- 文档内容综合了：
  - 根目录当前主稿 `main.tex + sections/` 的现行结构；
  - `DraftForZKGBDT/` 中保留的旧稿技术细节；
  - `task___25___ZK Decision Tree.md` 与 `task___25___ZKGBDT___AI Prompt.md` 中的原始研究动机与 primitive 设计方向。

### 新引入或固化的技术边界

- 在 `OVERVIEW.md` 中明确区分了三类组件：
  - imported primitives：KZG、lookup、generic nonlinear zkML gadget、max-selection gadget；
  - compatibility-layer primitives：domain lifting、replication、interleaving；
  - GBDT-specific primitives：aggregation、histogram、prefix sum、zero-safe division、可选的 concatenated matrix lookup。
- 明确固化了当前论文主线：
  - 训练证明的核心难点是 histogram construction 与 split-search algebraization；
  - `histogram / aggregation` 是核心贡献；
  - `domain lifting / replication / interleaving` 是兼容层工具；
  - softmax、lookup、max gadget 不应被误写成本文主贡献。
- 文档同时将整个系统分解为 P0--P7 七类问题：
  - forest well-formedness；
  - batched inference；
  - score accumulation / pseudo-residual；
  - leaf histogram construction；
  - internal-node propagation；
  - candidate split scores；
  - optimal split selection；

## 2026-04-03 20:05:00 +0800

### 用户本轮请求

- 阅读项目下的 `OVERVIEW.md`、其他 `md` 文件、历史对话记录、代码与草稿目录，以及当前 `tex` 主稿；
- 只聚焦技术部分，评估下一步应如何改进其呈现、叙事、结构与内容。

### 本轮调查与判断

- 已重新核对根目录主稿的技术相关文件：
  - `main.tex`
  - `sections/02_background.tex`
  - `sections/03_problem_statement.tex`
  - `sections/04_protocol.tex`
- 已复核上下文文档：
  - `OVERVIEW.md`
  - `Agent Prompt.md`
  - `Agent Conversation Log.md`
  - `task___25___ZKGBDT___AI Prompt.md`
  - `task___25___ZK Decision Tree.md`
- 已抽查旧稿 `DraftForZKGBDT/` 中与技术叙事最相关的文件：
  - `draft/overview.tex`
  - `draft/construction.tex`
  - `draft/preliminary.tex`
  - `draft/implement primitives.tex`
- 已阅读代码仓库 `ZK-GBDT/` 的说明与若干关键实现，特别是：
  - `GBDT_PRIMITIVE_GAPS.md`
  - `include/src` 中的 `hist_agg`、`interleaved_batching`、`forest_row_fetch`、`forest_inference` 等模块。

### 关键结论

- `OVERVIEW.md` 中的技术主线已经相当清楚，尤其是两条贡献线：
  - `domain lifting / replication / interleaving` 作为 batching / alignment layer；
  - `histogram / aggregation` 作为 split-search algebraization layer。
- 当前主稿的 `Technical Overview` 与 `Construction` 已包含这些内容，但“显影”还不够彻底：
  - 第 3 节目前更像“forest + inference + training 的流程摘要”，还没有把“两条贡献线并列”明确立起来；
  - 第 4 节一上来就进入 lemma / definition，技术上正确，但对系统安全论文读者来说仍然略偏“原语目录化”。
- 主稿中存在几处需要优先统一的技术表达问题：
  - `\boldsymbol{\ell}^{(t,k)}` 在主稿中写成紧凑叶子索引，但在 `OVERVIEW.md` 中固定为全局叶子编号；
  - `\mathbf{W}^{(t)}` 与 `\widetilde{\mathbf{W}}^{(t)}` 的 compact / padded 区分还没有正式迁移到主稿；
  - internal-node propagation 的公式语义还不够显式，容易让读者疑惑“左边是 internal 部分，右边为何仍写全张量”；
  - softmax 虽已有公式，但仍缺一个清晰的 supporting protocol 视角；
  - histogram 目前缺少一个能把 `leaf assignment -> address -> aggregation -> histogram -> prefix -> split score` 串起来的 running example。
- 代码仓库里的模块化实现其实已经给了论文很好的呈现素材：
  - `hist_agg`
  - `interleaved_batching`
  - `forest_row_fetch`
  - `forest_inference`
  - `cube_softmax`
  这些都说明正文完全可以把若干部分写成“supporting composite protocol”，而不是抽象占位。

### 当前编译 / 验证状态

- 本轮未修改论文正文，也未重新编译 `main.tex`。
- 仅进行了材料阅读、结构比对与技术叙事诊断。

### 建议的下一步

- 优先重写 `Technical Overview`，把“两条核心贡献线 + 一条 proof pipeline”明确写出来。
- 然后统一记号体系，尤其是：
  - leaf index 的全局 / 紧凑约定；
  - `W` 的 compact / padded 版本；
  - histogram 张量的 leaf-only / padded 语义。
- 再补三个最值钱的呈现层素材：
  - 一张 end-to-end proof pipeline 图；
  - 一个 histogram-to-split-score 的 running example；
  - 一个 problem-to-primitive mapping 表。

## 2026-04-03 20:22:00 +0800

### 用户本轮请求

- 按当前判断直接开始修改 `tex`，改善技术部分的呈现。

### 本轮修改与决定

- 已直接修改主稿中的技术相关章节：
  - `sections/02_background.tex`
  - `sections/03_problem_statement.tex`
  - `sections/04_protocol.tex`
- 第 3 节 `Technical Overview` 已重组为更清晰的系统论文叙事：
  - 先明确“两条技术主线”：
    - batching / alignment；
    - histogram / split-search；
  - 增加一张小型 overview 表，概括各层角色；
  - 将 forest/inference 与 training pipeline 分开叙述；
  - 新增一个 `histogram -> prefix -> gain` 的 running example；
  - 将结尾改为“为什么这种分解有意义”的总结，而不只是重复 histogram 的重要性。
- 第 4 节 `Construction` 已做叙事层改写：
  - 将 `Compatibility Layer` 明确改写成 `Batching and Alignment Layer`；
  - 在 domain lifting / replication / interleaving 前后增加“为什么需要它、后文如何使用它”的过渡；
  - 将 inference 明确描述为“schema-aware row fetch + box containment”；
  - 将 pseudo-residual / softmax 进一步表述为 supporting protocol，而不是树特定贡献。

### 关键技术统一

- 已把 leaf assignment 统一为“全局叶子编号”语义：
  - `\boldsymbol{\ell}^{(t,k)} \in \{N_int,\dots,N_tot-1\}^M`。
- 已在 preliminaries 中补充：
  - 全局节点编号约定；
  - `\operatorname{Flat}(\cdot)` 记号；
  - compact / padded object 的区分说明。
- 已将 score update 与 leaf-value 相关记号向 padded 版本统一：
  - 在构造部分显式使用 `\widetilde{\mathbf{W}}^{(t)}`；
  - 避免此前 `\ell` 与 `W` 所在索引空间不完全一致的问题。
- histogram 相关关系也做了语义澄清：
  - 先引入 leaf-supported tensors；
  - 再用 routing relation 生成 all-node histograms；
  - internal propagation 公式因此变得更自洽。

### 当前编译 / 验证状态

- 已运行 `latexmk -pdf main.tex`，编译成功，输出 `main.pdf`。
- 当前新改内容未引入致命 LaTeX 错误。
- 仍存在若干旧有 citation warning，主要是 `.bib` / 引用键问题，不是本轮新改内容引入的问题。

### 建议的下一步

- 下一轮最值得继续补强的是两类“可视化呈现”：
  - 一张 round-level proof pipeline 图；
  - 一张 problem-to-primitive mapping 表或表格化摘要。
- 若继续打磨正文，建议优先补第 4 节中：
  - histogram relation 的正式 aggregation instantiation；
  - softmax supporting protocol 的更显式分解；
  - soundness composition 与两条主线之间的呼应。

## 2026-04-03 20:34:00 +0800

### 用户本轮请求

- 明确要求不要按 `layer` 的方式来写论文，因为那更像代码结构，而不是论文叙事；
- 要求据此重新规划写作路线，并修改论文。

### 本轮修改与决定

- 已根据这一要求重新调整技术部分的写作路线：
  - 从“batching layer / histogram layer / supporting layer”式组织，
    改为“要证明的问题 + proof pipeline + recurring proof tools”式组织。
- `sections/03_problem_statement.tex` 已被再次重写：
  - 删除了之前新增的分层表格；
  - 删除了 `Two Technical Threads` 中容易让读者联想到架构分层的表述；
  - 改成以下顺序：
    - 中心问题与两类 recurring obstacle；
    - committed forest 与 batched inference；
    - training as a proof pipeline；
    - why histogram replaces sorting；
    - recurring proof tools；
    - why this organization helps。
- `sections/04_protocol.tex` 也做了同步调整：
  - 小节标题从 `Batching and Alignment Layer` 改为 `Recurring Proof Tools`；
  - 开头不再把 domain lifting / replication / interleaving 描写成架构层，而是明确写成“后文反复调用的 proof tools”；
  - training proof 开头删除了 “two-thread view / layer” 的衔接语，改成更自然的 pipeline 式过渡。

### 当前采用的论文叙事路线

- 论文现在更明确地按下面这条路线展开技术部分：
  - 先说明 GBDT 训练证明到底卡在哪里；
  - 再说明 inference 和 training proof 的整体流程；
  - 接着说明 histogram 为什么能替代 sorting-style proof；
  - 最后再引出 domain lifting / replication / interleaving 这些在多处反复使用的组合工具。
- 这使得这些工具看起来更像“为证明流程服务的 recurring techniques”，而不是论文主体结构本身。

### 当前编译 / 验证状态

- 已重新运行 `latexmk -pdf main.tex`。
- 编译成功，`main.pdf` 已更新。
- 技术章节中已无 `layer / layers / thread / threads` 等组织性措辞残留。

### 建议的下一步

- 如果继续打磨技术部分，最自然的下一步是：
  - 把 `Recurring Proof Tools` 小节再压缩一点，使其更像“construction 前的短工具箱”；
  - 然后补一张真正服务于论文叙事的 training-proof 流程图，而不是模块图；
  - 再把 histogram relation 与 aggregation relation 的正式连接写得更显式一些。

## 2026-04-03 21:03:00 +0800

### 用户本轮请求

- 从整体上重新回顾论文；
- 按更 formal 的要求重写技术部分；
- 具体包括：
  - 第 3 节中去掉随意标题与 example 式写法；
  - 用正式表达说明“最小化 RSS 等价于最大化本文目标函数”；
  - 将 batching 写成 `domain lifting batch` 与 `interleaving batch` 两套工具，而不是零散三件事；
  - 第 4 节改名，并考虑把 GBDT 实例化单独拆成新 section；
  - 将 `Flat` 改成 `\mathsf` 风格；
  - 增加正式伪代码，并放入附录。

### 本轮修改与决定

- 已重新组织主稿 section 结构：
  - 第 4 节现在是 `Batched Proof Tools`；
  - 新增第 5 节 `ZK-GBDT Protocol`；
  - evaluation / related work / conclusion 顺延；
  - 新增 appendix section `Protocol Pseudocode`。
- `sections/03_problem_statement.tex` 已重写为更 formal 的技术总览：
  - `3.3` 改成 `Objective Rewriting for Split Search`；
  - 用正式等式推导说明
    - $\operatorname{RSS}(u,j,b)$
    - 与 $\Phi(u,j,b)$ 的最优化等价；
  - 删除此前的小例子式写法；
  - `3.4` 改成 `Domain-Lifted and Interleaved Batching`；
  - 将 replication 降为 interleaving 对齐时使用的 helper，而不再作为 overview 中并列的顶层叙事对象；
  - `3.5` 改成简短正式的后续章节说明。
- `sections/04_protocol.tex` 已完全重写：
  - 只保留两个正式工具：
    - `Domain-lifted batch` theorem；
    - `Interleaving batch` theorem；
  - `Row replication` 作为 second theorem 前的引理保留；
  - 在 interleaving theorem 后加入更具体的应用说明：
    - 多个 lookup-style table-difference checks；
    - 多个同型 rounding relations。
- 新建 `sections/05_zkgbdt.tex`：
  - 将 forest representation、batched inference、training protocol、soundness composition 全部迁移到这一节；
  - 使第 4 节和第 5 节形成“工具 -> 实例化”的清晰关系。
- 新建 `sections/08_appendix_protocol.tex`：
  - 给出 quantized GBDT training trace 的正式伪代码；
  - 给出 ZK proof generation skeleton 的正式伪代码；
  - 正文中已引用该 appendix 作为 protocol skeleton。

### 记号与排版改动

- 在 `main.tex` 中新增
  - `algorithm`
  - `algpseudocode`
  依赖，用于伪代码。
- 新增宏
  - `\Flat := \mathsf{Flat}`；
  - 并将正文中相应位置改为 `\Flat(\cdot)`。
- 为 algorithm/hyperref 增加了唯一锚点设置，避免 appendix 伪代码产生重复目标警告。

### 当前编译 / 验证状态

- 已多次运行 `latexmk -pdf main.tex`。
- 当前编译成功，`main.pdf` 已更新。
- 本轮新增结构、section、公式、appendix 与伪代码均可正常编译。

### 当前仍值得继续改进的点

- 目前技术部分的大结构已经比前一轮更 formal，但仍可以继续打磨：
  - 第 5 节中 training protocol 的局部过渡还可以更紧；
  - 如果要投稿，最好再补一张 proof-pipeline figure；
  - appendix 中还可以继续补“树训练 / 证明生成”更细的 per-node 伪代码。

## 2026-04-03 21:15:00 +0800

### 用户本轮请求

- 同意继续按当前方向打磨论文。

### 本轮修改与决定

- 继续重点打磨了 `sections/05_zkgbdt.tex` 的训练部分行文：
  - 将原来的 `Training Protocol` 改为 `Round-Level Training Proof`；
  - 将若干编号 paragraph 改写为更正式、语义更清晰的阶段标题：
    - `Residual update`
    - `Leaf-level histogram construction`
    - `Propagation and split-score derivation`
    - `Optimal split certification`
    - `Leaf values and round closure`
  - 在训练部分中显式突出“同一组 leaf assignment 同时服务于 split certification 与 leaf-value update”的闭环关系。
- 新增了一张真正服务于论文主线的 round-level proof flow figure：
  - 位于 `sections/05_zkgbdt.tex`；
  - 使用 TikZ 直接在 LaTeX 中绘制；
  - 图中串起：
    - `S^(t)`
    - `G^(t)`
    - `ell^(t,k)`
    - leaf histograms
    - all-node histograms
    - gain tensor
    - committed split
    - leaf values
    - `S^(t+1)`
  - 其作用是帮助读者直观看到一轮证明如何闭环，而不是再给出一个模块图。
- 为支持该图，在 `main.tex` 中加入了：
  - `tikz`
  - `arrows.meta`
  - `positioning`

### 当前编译 / 验证状态

- 已再次运行 `latexmk -pdf main.tex`。
- 编译成功，`main.pdf` 已更新为 16 页版本。
- 本轮新增 figure 未引入新的编译错误。

### 当前论文状态判断

- 到这一轮为止，技术部分已经明显比初始版本更接近“正式投稿草稿”的组织：
  - overview 更 formal；
  - tools 与 protocol instantiation 已分节；
  - objective rewriting 已公式化；
  - appendix 已有 protocol skeleton；
  - 正文已有 round-level proof flow figure。

### 建议的下一步

- 若继续打磨，最值得做的是：
  - 进一步压缩第 5 节各段首句，减少重复过渡；
  - 开始补 evaluation 里与新技术主线呼应的实验问题；
  - 或者补一张更偏“histogram to split-score” 的解释图，和当前 round-flow 图形成互补。

## 2026-04-07 00:00:00 +0800

### 用户本轮请求

- 指出 `3.1` 中 forest objects 只有符号罗列，没有解释形状、性质和用途；
- 要求加强该小节，并简要解释这些对象如何用于 inference，同时记得引用 `cq++24`。

### 本轮修改与决定

- 已更新 `sections/03_problem_statement.tex` 中的 `3.1 Forest Representation and Batched Inference`。
- 修改方式不是增大篇幅式铺陈，而是直接对每个 committed object 补三类信息：
  - shape；
  - structural property；
  - role in inference / later proof。
- 具体补充如下：
  - 对 `\mathbf{L},\mathbf{R}` 明确说明其 row-sparse selector 性质，并指出主要用于后续统计传播；
  - 对 `\mathbf{N}^{\leftarrow},\mathbf{N}^{\rightarrow}` 明确说明它们是 inference 中真正 fetch 的 hyperbox payload；
  - 对 `\mathbf{E}, \boldsymbol{\Theta}` 明确说明它们主要服务于 well-formedness 与 split certification，而非 inference fetch path；
  - 对 `\mathbf{tree}, \mathbf{Root}` 明确说明它们如何把 fetched row 绑定到正确树；
  - 对 `\mathbf{score}` 明确说明它在 inference 中被 fetch 后再聚合。
- 同时把这一小节最后一段改成更明确的 inference 描述：
  - 直接写出 protocol fetch 的对象组
    `(\mathbf{tree}, \mathbf{N}^{\leftarrow}, \mathbf{N}^{\rightarrow}, \mathbf{score})`；
  - 并明确说明这沿用了 `cq++24` 的 hyperbox row-fetch 思路。

### 当前编译 / 验证状态

- 已运行 `latexmk -pdf main.tex`。
- 编译成功，`main.pdf` 已更新。
- 本轮改动未引入新的编译错误或版式问题。

### 建议的下一步

- 如果继续提升 overview，可考虑再补一张很小的“fetched row schema”示意图；
- 但从信息密度上看，当前 `3.1` 已经比之前更像一个真正服务于后文的 overview，而不是符号清单。
  - leaf value update。

### 当前验证状态

- 本轮只新增了 `OVERVIEW.md` 并追加了日志，没有改动论文 TeX 正文。
- 未执行新的 LaTeX 编译；根目录主稿上轮已确认可编译。

### 建议的下一步

- 后续若继续修改论文，建议先把 `OVERVIEW.md` 作为统一技术底稿使用，再回写到：
  - `sections/03_problem_statement.tex`
  - `sections/04_protocol.tex`
- 很适合下一步做的工作包括：
  - 将 `Technical Overview` 进一步对齐到 `OVERVIEW.md` 的 P0--P7 分解；
  - 检查 `Construction` 是否完整覆盖 `OVERVIEW.md` 中列出的所有 primitive；
  - 决定哪些旧稿中的 replication / concatenated lookup 细节需要进入正文，哪些仅保留在 appendix 或内部技术说明中。

## 2026-04-03 19:59:34 +0800

### 用户本轮请求

- 根据反馈修改 `OVERVIEW.md`：
  - 提升 `domain lifting batch / replication / interleaving batch` 的贡献地位；
  - 扩展森林编码部分对各矩阵 / 张量的解释；
  - 在 P0 中将矩阵乘法改写为显式 `\cdot`；
  - 进一步解释 P2 中的 `S` 与 `W`；
  - 将 softmax 的明确做法纳入原语目录；
  - 并阅读 `ZK-GBDT/` 代码目录，确认文档理解与实现对齐。

### 本轮调查与修改

- 已阅读 `ZK-GBDT/` 中与当前论文结构最相关的代码与测试，包括：
  - `include/forest_row_fetch.hpp`
  - `include/forest_inference.hpp`
  - `include/hist_agg.hpp`
  - `include/interleaved_batching.hpp`
  - `include/cube_softmax.hpp`
  - `include/sparse_routing.hpp`
  - 对应的若干 tests 与 README
- 基于代码确认了以下事实：
  - `forest_row_fetch` 已经固定了 `tree | lower_bounds | upper_bounds | score | optional leaf_index` 的 fetch schema；
  - `forest_inference` 已经明确实现了“row fetch + half-open box containment check”；
  - `hist_agg` 的接口正是 `(indices, values, histogram)`；
  - `interleaved_batching` 真实实现了基于 power-of-two bucket merge 的 interleaving batch；
  - `cubeMiddleSoftmaxProtocol` 已明确实现 `exp -> middle-axis sum -> denominator replication -> division`，并支持 explicit shift 与 row-max shift。
- 已据此重写 `OVERVIEW.md` 的若干关键段落：
  - 将 `domain lifting batch / replication / interleaving batch` 与 `histogram / aggregation` 明确写成两条并列的核心贡献线；
  - 扩展森林编码小节，补充每个 matrix / tensor 的：
    - 数学含义；
    - shape；
    - selector / routing 语义；
    - 在 inference / training 中的具体用途；
  - 将 P0 的矩阵乘法改成显式 `\cdot`；
  - 补充了 `\mathbf{S}^{(t)}`、`\mathbf{W}^{(t)}` 的含义与 shape，并增加与代码对齐的三维张量记号 `\mathcal{S}, \mathcal{G}`；
  - 新增了 supporting composite protocols 小节，将：
    - `forest_row_fetch`
    - `forest_inference`
    - `cubeMiddleSoftmaxProtocol`
    系统纳入目录；
  - 在 aggregation / interleaving / replication 等处补充了与代码实现的一一对应说明。

### 当前技术判断

- 现在的 `OVERVIEW.md` 已经比上一版更接近“可直接驱动论文改写的技术底稿”，因为它不再只基于旧稿与主稿叙事，而是同时对齐了当前代码库中真实存在的协议分层。
- 一个关键修正是：
  - `domain lifting batch / replication / interleaving batch` 不应只被写成 supporting compatibility trick；
  - 它们应与 `histogram / aggregation` 一起构成论文最稳定的两条贡献主线。

### 当前验证状态

- 本轮未改动 LaTeX 主稿正文；
- 未重新编译论文；
- 已更新 `OVERVIEW.md` 与协作日志。

### 建议的下一步

- 下一步非常适合直接改写：
  - `sections/03_problem_statement.tex`
  - `sections/04_protocol.tex`
- 改写时建议显式采用 `OVERVIEW.md` 中的两条主线：
  - batching / alignment；
  - histogram / split-search algebraization；
- 同时可以考虑把代码中已有的 `forest_row_fetch / forest_inference / cubeMiddleSoftmax` 适度吸收到正文或 appendix 的“implementation-aligned protocol instantiation”里。

## 2026-04-03 20:23:06 +0800

### 用户本轮请求

- 不再参考其他材料，只把 `OVERVIEW.md` 当作独立文档重新阅读，检查其自身的可读性与完整性，并修复不合适之处。

### 本轮修改与判断

- 本轮按“单文档自洽性”而不是“与外部材料对齐”的标准重读并修订了 `OVERVIEW.md`。
- 主要修复了以下问题：
  - 增加了 `2.3 索引与 Reshape 约定`，明确：
    - 全局节点编号；
    - 叶子编号范围；
    - `\operatorname{Flat}(\cdot)` 的含义；
    - `\mathbf{W}^{(t)}` 与 `\widetilde{\mathbf{W}}^{(t)}` 的区别。
  - 在“核心问题”中新增 `P-Compat`，把异构 domain / shape 的统一 batching 显式提升为一个独立问题，而不再只是散落在 primitive 小节里的背景工具。
  - 将 `P2` 中的 score update 改为使用 padded 叶值矩阵 `\widetilde{\mathbf{W}}^{(t)}`，从而和全局叶子编号向量 `\boldsymbol{\ell}^{(t,k)}` 自洽。
  - 将 `P4` 中的内部节点传播改写成显式使用 `\operatorname{Flat}(\cdot)` 的形式，避免把三维张量直接和矩阵相乘所带来的歧义。
  - 删除或弱化了若干会打断阅读的“外部视角”措辞，例如：
    - 直接提到代码目录；
    - 直接提到旧稿 / 当前主稿演化历史；
    - 将文档内部定义与外部实现混写在一起。

### 当前文档状态

- `OVERVIEW.md` 现在更接近一份可独立阅读的技术总览：
  - 符号系统更自洽；
  - 问题分解更完整；
  - compact 与 padded 对象的区别更明确；
  - batching 主线在问题层级中被正式纳入，而不是只在 primitive 层级出现。

### 当前验证状态

- 本轮仅修改了 `OVERVIEW.md` 与日志。
- 未重新编译 LaTeX 主稿。

### 建议的下一步

- 现在适合把 `OVERVIEW.md` 直接作为重写：
  - `sections/03_problem_statement.tex`
  - `sections/04_protocol.tex`
  的唯一技术底稿。
- 若继续优化，可进一步考虑：
  - 是否为 `OVERVIEW.md` 增加一张 “problem -> primitive -> protocol” 总表；
  - 是否把 `P-Compat` 显式挪入论文 `Construction` 章节最前部，作为全文第一条技术主线。

## 2026-04-03 20:24:44 +0800

### 用户本轮请求

- 修复 `OVERVIEW.md` 中 Markdown 公式在 VS Code 预览下的渲染问题，尤其不要让等号单独占一行。

### 本轮修改

- 已对 `OVERVIEW.md` 中相关 display math 做纯排版修正，不改变技术内容：
  - 将若干单独成行的 `=` 收回到公式主行；
  - 同时一并收回了若干单独成行的 `:=`；
  - 保留原有数学含义不变。
- 典型修复位置包括：
  - P2 中的 score update；
  - softmax 张量公式；
  - histogram 定义；
  - internal-node propagation；
  - prefix / lifted residual / interleaving / address / softmax definition 等。

### 当前状态

- `OVERVIEW.md` 现在更适合在 VS Code Markdown Preview 中阅读。
- 本轮没有改动 LaTeX 主稿正文，也没有重新编译论文。

## 2026-04-03 20:27:01 +0800

### 用户本轮请求

- 继续修复 `OVERVIEW.md` 的 Markdown 公式排版，不仅等号不要单独成行，加号等运算符也不要放在行首。

### 本轮修改

- 进一步整理了 `OVERVIEW.md` 中的 display math 排版：
  - 将若干仍然在换行后以 `+` 开头的公式收并回上一行；
  - 将若干仍然在换行后以 `\iff`、`\Longrightarrow` 开头的公式改写为同一行；
  - 保持数学内容不变，仅优化 Markdown Preview 的渲染稳定性。
- 已额外扫描文档，确认目前不存在以 `+`、`\iff`、`\Longrightarrow`、`\land` 开头的公式行。

### 当前状态

- `OVERVIEW.md` 的公式排版现在更适合 VS Code Markdown Preview。
- 本轮仍未改动 LaTeX 主稿正文，也未重新编译论文。

## 2026-04-07 20:22:41 +0800

### 用户本轮请求

- 加强 `3.1` 中 committed forest 符号的介绍。
- 需要补清楚各对象的形状、结构性质和用途。
- 需要简要说明这些对象如何用于 inference，并明确引用 `cq++24`。

### 本轮修改

- 重写了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中 `3.1 Forest Representation and Batched Inference` 的开头段和符号列表。
- 对每个 committed object 都补上了三类信息：
  - 形状；
  - 关键结构约束；
  - 在 inference 或后续 training proof 中的作用。
- 具体上：
  - `L,R` 现在明确写成 internal-row one-hot、leaf-row zero 的 routing selector，并点明其后续用于 histogram propagation；
  - `N^{\leftarrow},N^{\rightarrow}` 明确写成 node-wise half-open hyperbox，强调 leaf row 对应 accepting region；
  - `E,\Theta` 明确写成 split feature / threshold 的结构性见证，而不是 inference 主路径对象；
  - `tree, Root` 明确写成 tree binding 元数据，并解释 inference 中为何要把 tree index 一起 fetch；
  - `score` 明确写成 leaf payload。
- 在列表后新增了一段更完整的 inference 说明：
  - 明确说明沿用 `cq++24` 的 row-fetch pattern；
  - 给出输入 batch `X \in [B]^{b \times d}`；
  - 说明 prover 会对每个 tree-sample pair 选定 accepting leaf row，并批量 fetch
    `(\mathbf{tree}, \mathbf{N}^{\leftarrow}, \mathbf{N}^{\rightarrow}, \mathbf{score})`；
  - 说明随后验证 query 落在 fetched half-open box 中，并沿 tree 轴聚合 leaf score 得到 class scores。

### 当前状态

- `3.1` 现在更接近“overview but still formal”的写法，读者可以直接看出这些对象为什么存在，以及 inference 用到了哪一部分 committed state。
- 已重新运行 `latexmk -pdf main.tex`，编译通过，`main.pdf` 已更新。

## 2026-04-07 20:29:45 +0800

### 用户本轮请求

- 先参考 `cq++24` 论文中的 decision tree 示意图，再为论文 `3.1` 生成我们自己的版本。
- 希望图的组织方式能借鉴对方如何解释 tree semantics 和 committed representation。

### 本轮修改

- 先查阅了 `cq++24` 的公开 PDF，并重点参考了其 decision-tree 相关示意部分：
  - `Fig. 3` 用一棵小树解释 decision-tree 的语义；
  - `Fig. 4` 紧接着把同一棵树翻译成 `N^{\leftarrow}, N^{\rightarrow}, E` 等矩阵对象。
- 基于这个组织方式，为当前论文新增了一个原生 `TikZ` 图：
  - 新文件 [figures/forest_encoding_inference.tex](figures/forest_encoding_inference.tex)；
  - 左 panel 画单棵树的语义视图；
  - 右 panel 画 row-oriented committed view；
  - 明确突出 inference 真正 fetch 的列
    `(\mathbf{tree}, \mathbf{N}^{\leftarrow}, \mathbf{N}^{\rightarrow}, \mathbf{score})`；
  - 同时把 `L,R,E,\Theta,Root` 作为“also committed once”的结构性 metadata 单独标出。
- 在 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 的 `3.1` 中插入了该图，并补了一小段承接文字，说明：
  - 该图沿用了 `cq++24` 的讲法；
  - 左边是 tree semantics；
  - 右边是 proof 实际操作的 committed row view；
  - inference payload 与其他 structural metadata 在功能上是分开的。
- 为支持该图，在 [main.tex](main.tex) 中补充了 TikZ library：
  - `matrix`
  - `fit`

### 当前状态

- `3.1` 现在已经有一张可继续编辑的 `TikZ` 示意图，适合后续继续改节点文字、表格列、配色和版式。
- 已重新运行 `latexmk -pdf main.tex`，`main.pdf` 已更新。
- 当前图可正常编译；仍有一条轻微的 overfull warning，主要是图整体较宽，但不影响继续迭代。

## 2026-04-07 20:53:46 +0800

### 用户本轮请求

- 修复 `3.1` 新图中的版式问题：
  - 右侧若干 box 超出虚线边界；
  - 右下角注释 node 与图主体挤在一起。

### 本轮修改

- 重排了 [figures/forest_encoding_inference.tex](figures/forest_encoding_inference.tex) 右侧说明区域：
  - 将 query 说明框与 metadata 说明框整体右移；
  - 缩小二者的文字宽度，避免与中间表格过于贴近。
- 将原先单独悬在右下角的注释 node 改成跟随 metadata 框定位：
  - 使用 `([yshift=-3mm]other.south west)` 放置；
  - 增加固定 `text width`，避免文字自然伸展挤向图主体。
- 将原先手写坐标的虚线边框改为自动 `fit` 包围框：
  - 现在会根据树图、表格、说明框和注释框的实际边界自动扩展；
  - 后续如果继续改内容，不需要再手工调矩形坐标。
- 顺手把右侧标题 `Also committed once:` 收短成 `Also committed:`，消除了由窄栏文字断词引起的小 warning。

### 当前状态

- 右侧说明区域与主图已经明显分开，虚线边框也会完整包住所有图元。
- 已重新运行 `latexmk -pdf main.tex`，`main.pdf` 已更新。
- 当前这张图已干净通过编译，没有新增的图版式 warning。

## 2026-04-07 20:59:54 +0800

### 用户本轮请求

- 当前图仍不符合预期：
  - 左侧树图不满足“叶子都出现在最后一层”的要求；
  - 右侧 `(b)` 中各元素还是小格子矩阵，不够正式；
  - 希望每一列都是一个单独的大矩形框，而不是每个元素各自一个小矩形。

### 本轮修改

- 重画了 [figures/forest_encoding_inference.tex](figures/forest_encoding_inference.tex)：
  - 左侧改为两层内部节点、最底层统一四个叶子的完整小树；
  - 明确让所有叶子都落在最后一层；
  - 同时把行索引也同步成内部节点在前、叶子在后：
    `0,1,2` 为 internal rows，`3,4,5,6` 为 leaf rows。
- 将右侧 committed view 从 cell-by-cell 的表格改成 column-by-column 的版式：
  - `\mathbf{u}`
  - `\mathbf{tree}`
  - `\mathbf{N}^{\leftarrow}`
  - `\mathbf{N}^{\rightarrow}`
  - `\mathbf{score}`
  每一列现在都是一个独立的大矩形框，顶部和底部对齐。
- 用红色直接高亮 fetched row 的对应条目，而不是再给单独某一整行加外框：
  - 例子里 query 改为 fetch row `u=5`；
  - 在五个列框中对应把 `5`、`t`、`(3,0)`、`(B+1,5)`、`w_2` 标红。
- 为避免整张图再次横向出界，最终把整幅 `tikzpicture` 用 `\resizebox{\linewidth}{!}{...}` 收进了版心。

### 当前状态

- 该图现在满足“叶子在最后一层”和“每列一个大矩形框”这两个结构要求。
- 已重新运行 `latexmk -pdf main.tex`，`main.pdf` 已更新。
- 当前图可正常编译，且本轮没有新增图版式 warning。

## 2026-04-07 22:30:24 +0800

### 用户本轮请求

- 仓库里新增了一张参考图片，希望据此继续修改 `3.1` 的示意图。
- 具体要求：
  - 改成多棵树，而不是单棵树；
  - 在树上明确标出节点编号；
  - 右侧表格补入 `\mathbf{E}` 和 `\boldsymbol{\Theta}`；
  - 删除图右下角那段解释性文字；
  - 整体版式继续优化。

### 本轮修改

- 读取了用户新增的参考图 [image.png](image.png)，并据此重画了
  [figures/forest_encoding_inference.tex](figures/forest_encoding_inference.tex)。
- 左侧 `(a)` 改为两棵小树：
  - 第一棵树使用节点 `0` 到 `6`；
  - 第二棵树使用节点 `7` 到 `13`；
  - 每个 internal node 与 leaf node 内部都直接标出其全局编号；
  - 同时保留 split 条件或 leaf score，形成“编号 + 语义”的双层标注。
- 右侧 `(b)` committed view 扩展为 7 列：
  - `\mathbf{u}`
  - `\mathbf{tree}`
  - `\mathbf{E}`
  - `\boldsymbol{\Theta}`
  - `\mathbf{N}^{\leftarrow}`
  - `\mathbf{N}^{\rightarrow}`
  - `\mathbf{score}`
- 表格内容也同步改成两棵树共享一个 global node namespace 的形式：
  - 第一棵树为 `t_0`；
  - 第二棵树为 `t_1`；
  - 中间用水平分隔线将两棵树对应的行隔开。
- 将高亮 fetch 的示例改为第二棵树中的 leaf row：
  - query 仍为 `x=(4,2)`；
  - 高亮改为 fetch row `u=12`；
  - 在所有相关列中同步将该行元素标红。
- 删除了右下角原有的解释性段落，只保留 query/fetch 的说明框。
- 顺手更新了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中紧邻图的引导文字：
  - 从 “one concrete tree” 改为 “two concrete trees”；
  - 并简化了对列的说明，避免正文 overfull。

### 当前状态

- `3.1` 的图现在已经对齐到用户给的参考方向：多棵树、节点编号、扩展列、无右下角说明块。
- 已重新运行 `latexmk -pdf main.tex`，`main.pdf` 已更新。
- 当前编译通过，且本轮结束时没有新的正文或图版式 warning。

## 2026-04-07 22:30:24 +0800

### 用户本轮请求

- 用户更新了参考图片，希望继续修图：
  - 修复箭头与图片元素重叠的问题；
  - `(a)` 中使用更小的树，并去掉一个叶子；
  - `(b)` 中的矩阵列排得更紧一些。

### 本轮修改

- 调整了 [figures/forest_encoding_inference.tex](figures/forest_encoding_inference.tex) 左侧树图区：
  - 将两棵树都改成 3 叶的小树；
  - 第一棵树保留节点 `0,1,2,3,4,5`；
  - 第二棵树保留节点 `7,8,9,10,11,12`；
  - 删除了原先每棵树最右侧的第四个叶子，使树更紧凑。
- 重新摆放了叶子坐标，避免树边与叶节点或相邻树叶重叠。
- 将右侧 committed view 的列整体压紧：
  - 所有列左移；
  - 减少列间横向空隙；
  - 保持 `u/tree/E/Theta/N^left/N^right/score` 的顺序不变。
- 将 query 框同步左移，并将红色指示箭头改成折线路径：
  - 先向下，再向左接近 `score` 列；
  - 避开 query 框、表格列和虚线边界内的主体图元。
- 图注第一句从 `A single-tree explanation` 改为 `A multi-tree explanation`，与当前多树版式保持一致。

### 当前状态

- 箭头与图主体不再重叠，左侧树也更小更紧凑。
- `(b)` 的矩阵列现在更紧，整张图更接近用户更新后的参考图。
- 已重新运行 `latexmk -pdf main.tex`，`main.pdf` 已更新。
- 当前图编译通过，未引入新的版式 warning。

## 2026-04-07 22:38:38 +0800

### 用户本轮请求

- 用户指出上一版仍有两个实质问题：
  - 左侧森林视觉上仍像是在共享叶子；
  - 树的节点编号不满足“叶子编号大于内部节点编号”。

### 本轮修改

- 重新设计了左侧森林的全局编号体系，使其满足
  `internal id < leaf id`：
  - 第一棵树 internal nodes 改为 `0,1,2`，leaf nodes 改为 `6,7,8`；
  - 第二棵树 internal nodes 改为 `3,4,5`，leaf nodes 改为 `9,10,11`。
- 右侧 committed view 的所有列同步改成新的全局编号顺序：
  - `u` 列现在是 `0..5` 的 internal rows 在前，`6..11` 的 leaf rows 在后；
  - `tree / E / Theta / N^left / N^right / score` 六列内容都按新顺序重排。
- 将 query/fetch 示例也同步更新：
  - 原先 fetch `u=12`；
  - 现在改成 fetch `u=11`，对应第二棵树的最后一个 leaf row。
- 对左侧两棵树的叶子坐标再次拉开：
  - 第一棵树叶子落在 `-9.55,-7.8,-5.55` 一带；
  - 第二棵树叶子落在 `-4.55,-2.8,-0.55` 一带；
  - 两棵树现在不再共用任何 leaf node，也不会在视觉上贴成同一排共享叶子。
- 树下方说明文字同步改成：
  - “internal nodes are indexed before leaves.”

### 当前状态

- 左侧森林现在是两棵完全分离的小树，不再共享叶子。
- 全局编号体系已经满足“内部节点编号在前，叶子编号在后”。
- 已重新运行 `latexmk -pdf main.tex`，`main.pdf` 已更新。
- 当前图编译通过，没有新增 warning。

## 2026-04-08 00:05:00 +0800

### 用户本轮请求

- 不要再做大规模符号体系改动；
- 保持论文现有记号和叙事；
- 重新扫描 `ZK-GBDT/`，只修正与代码语义明显不一致的地方；
- 不要在论文正文里讨论代码实现。

### 本轮处理

- 重新核对了当前论文中的几个关键语义点：
  - [sections/03_problem_statement.tex](sections/03_problem_statement.tex)
  - [sections/05_zkgbdt.tex](sections/05_zkgbdt.tex)
  - [OVERVIEW.md](OVERVIEW.md)
  - [figures/forest_encoding_inference.tex](figures/forest_encoding_inference.tex)
- 按先前已确认的代码语义，这一轮只做最小必要修正：
  - `\boldsymbol{\Theta}` 不能写成 one-hot threshold tensor；
  - optimal split certification 里不能继续使用 one-hot 的 `\Theta[u,j,b]` 约束；
  - 图中 `\Theta` 一列本来展示的是标量 threshold bin，图注和正文应与之匹配；
  - 图文件里还残留了一个 `treenote` 引用，会导致编译失败。

### 本轮修改

- 在 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中：
  - 将 `\boldsymbol{\Theta}` 改为标量 threshold-index vector；
  - 保持原有组织方式，只修改其 shape 和语义；
  - 调整图前说明，使之与当前图中 `\Theta` 的标量展示一致。
- 在 [sections/05_zkgbdt.tex](sections/05_zkgbdt.tex) 中：
  - 将 committed object 列表中的 `\Theta` 改为 threshold-index vector；
  - 将 optimal split certification 从 one-hot `\Theta[u,j,b]` 约束，改为
    `\Gamma[u,j,\Theta[u]]` 命中所选 bin 的写法；
  - 删除了正文里显式谈论“current implementation / code”的句子。
- 在 [OVERVIEW.md](OVERVIEW.md) 中：
  - 将 `\Theta` 的定义同步成标量 threshold index；
  - 将 P6 的叙述同步成 `\mathbf{E}` 与标量 `\Theta` 共同确定 split。
- 在 [figures/forest_encoding_inference.tex](figures/forest_encoding_inference.tex) 中：
  - 修掉了残留的 `treenote` 引用；
  - 图注改成说明 `\mathbf{E}` 列展示的是 selected feature index，`\Theta` 列展示的是 selected threshold bin。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有重写整套记号，也没有把代码实现细节直接写进论文正文。

## 2026-04-08 00:18:00 +0800

### 用户本轮请求

- 先提交当前修改；
- 然后继续改进技术部分的专业性和可读性；
- 但不要在论文里讨论代码本身。

### 本轮处理

- 重新扫描了当前技术部分，重点检查：
  - [sections/03_problem_statement.tex](sections/03_problem_statement.tex)
  - [sections/05_zkgbdt.tex](sections/05_zkgbdt.tex)
  - [OVERVIEW.md](OVERVIEW.md)
  - [figures/forest_encoding_inference.tex](figures/forest_encoding_inference.tex)
- 删除了正文中显式提及“current implementation / codebase”的句子，只保留 paper-facing 语义。
- 在不改变整体结构和记号体系的前提下，补做了一轮轻量润色：
  - 将第 3 节 training pipeline 的过渡句改得更 formal；
  - 将第 5 节 round-level proof 的开头收得更紧；
  - 将 inference 段中的 `fetched scores` 改成 `fetched leaf scores`，避免表意松散；
  - 保留 `\Theta` 的标量 threshold-index 语义不变。

### 验证

- 重新运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新。

## 2026-04-08 00:32:32 +0800

### 用户本轮请求

- 提交当前修改；
- 继续打磨技术部分，使表述更专业、更易读；
- 以论文写作为中心，不改动整体符号体系和协议语义。

### 本轮处理

- 对技术主线做了小幅但系统的行文收束，涉及：
  - [sections/03_problem_statement.tex](sections/03_problem_statement.tex)
  - [sections/04_protocol.tex](sections/04_protocol.tex)
  - [sections/05_zkgbdt.tex](sections/05_zkgbdt.tex)
- 第 3 节的处理重点是：
  - 将开头的 framing 改成更正式的三点式概括；
  - 将 training proof 的六步流程改成更统一的 pipeline 口吻；
  - 压缩了 histogram 段落里偏口语化的句子。
- 第 4 节的处理重点是：
  - 明确 domain-lifted batch 与 interleaving batch 分别覆盖哪类重复模式；
  - 让 theorem 前后的解释语气更一致。
- 第 5 节的处理重点是：
  - 收紧 protocol section 的开头；
  - 让 round-proof flow、histogram propagation、argmax certification 等段落的措辞更正式；
  - 避免重复解释同一语义，提升可扫描性。

### 验证

- 计划在本轮修改后再次运行 `latexmk -pdf main.tex`；
- 若编译通过，则将这一轮润色作为新的提交保存。

## 2026-04-08 10:25:22 +0800

### 用户本轮请求

- 强化第 2.3 节对明文 GBDT 的描述；
- 更详细说明 GBDT 如何生成、如何使用、softmax 与伪残差如何计算、节点如何分裂；
- 若引入新符号，要求全文保持一致。

### 本轮处理

- 重写了 [sections/02_background.tex](sections/02_background.tex) 中的 `Gradient Boosted Decision Trees` 小节。
- 新版 2.3 现在按明文训练流程展开：
  - 定义 score matrix $\mathbf{S}^{(t)}$ 及其初始化；
  - 明确写出 $\mathbf{P}^{(t)}$、$\mathbf{Z}^{(t)}$、softmax 概率 $\boldsymbol{\pi}^{(t)}$；
  - 写出伪残差定义 $\mathbf{G}^{(t)} = \mathbf{Y} - \boldsymbol{\pi}^{(t)}$；
  - 说明每轮为每个 class 训练一棵回归树 $f^{(t,k)}$；
  - 写出 score update；
  - 补充 inference 时如何累加树输出并再做 softmax；
  - 更正式地定义 node split、左右子集、RSS 目标、递归生长与 leaf value。
- 本轮新增符号主要是背景层面的 $\mathbf{P}^{(t)}$、$\mathbf{Z}^{(t)}$、$\boldsymbol{\pi}^{(t)}$ 与局部 leaf value $w_{\ell}^{(t,k)}$。
- 其中 $\mathbf{P}^{(t)}$、$\mathbf{Z}^{(t)}$、$\mathbf{G}^{(t)}$ 与后文 protocol section 保持一致，没有改动后文核心符号体系。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮未改动协议语义或后文技术部分结构，只增强了背景节的可读性和完整性。

## 2026-04-08 10:45:50 +0800

### 用户本轮请求

- Figure 1 中的 `\mathbf{E}` 应该按 one-hot 形式展示；
- 第 3.1 节的说明太繁复，希望进一步收缩；
- 对直观变量少解释，把解释留给不直观的对象。

### 本轮处理

- 修改了 [figures/forest_encoding_inference.tex](figures/forest_encoding_inference.tex)：
  - 将表中 `\mathbf{E}` 一列从标量 feature index 改成显式 one-hot 行向量；
  - 对应调整了列宽；
  - 删除了图注中“为紧凑起见用标量显示 `\mathbf{E}`”的说明。
- 修改了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 的 3.1：
  - 将 committed forest 的介绍从“长解释列表”收缩为“对象列表 + 最少必要说明”；
  - 保留了对 `\mathbf{E}, \boldsymbol{\Theta}, \mathbf{L}, \mathbf{R}` 的简短解释，因为它们在图中不如 box / score 直观；
  - 删除了原来对若干直观对象的重复性用途说明。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有改动后续协议语义，只调整了 Figure 1 的展示方式和 3.1 的行文密度。

## 2026-04-08 19:40:41 +0800

### 用户本轮请求

- 指出 3.2 中关于 “one round” 与 “prepare residuals / leaf values for next round” 的表述不准确；
- 要求按当前做法修正 round-level training pipeline 的时间关系。

### 本轮处理

- 修改了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 的 3.2：
  - 不再将整段写成含糊的 “one round” 流程；
  - 改为先说明每个 round 先认证 $\mathbf{S}^{(t)}$ 与 $\mathbf{G}^{(t)}$；
  - 再说明每个 class-specific tree $(t,k)$ 分别执行 histogram / split-search / leaf-value 认证；
  - 将 “next round's leaf values” 改成更准确的 “round-$t$ trees 的 leaf values”。
- 同步修改了 [sections/05_zkgbdt.tex](sections/05_zkgbdt.tex) 中 round-level flow 图的 caption 与解释段，消除相同的时间关系错误。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮只修正了 technical overview 与 flow figure 的叙述，不涉及新的符号或协议结构改动。

## 2026-04-08 20:46:52 +0800

### 用户本轮请求

- 强调 proof of training 中所有 $\mathbf{S}^{(t)}$ 都承诺在同一个 PCS 中；
- 强调这些 score-state relations 是一次性共同证明的，因此 proof size 与 boosting rounds 无关；
- 允许重新核对 `ZK-GBDT` 项目以确认该事实。

### 本轮处理

- 重新核对了 `ZK-GBDT` 中与 boosting state 相关的实现与说明，重点查看：
  - `forest_boosting_state.hpp`
  - `forest_training_workflow.cpp`
  - `examples/README.md`
- 确认当前主线是把 score / shifted-score / softmax / pseudo-residual 等对象沿 iteration 轴组织成一个全局 boosting-state 见证，并在单个 PCS / 单个 boosting-state protocol 中统一处理。
- 对应修改了：
  - [sections/03_problem_statement.tex](sections/03_problem_statement.tex)
  - [sections/05_zkgbdt.tex](sections/05_zkgbdt.tex)
- 新表述现在明确说明：
  - $\mathbf{S}^{(0)},\ldots,\mathbf{S}^{(T)}$ 不是逐轮分别承诺；
  - 它们是同一个全局 score tensor 的不同切片；
  - 所有 score-update / softmax / residual checks 共用这一组 PCS 承诺；
  - 因此 proof size 不随 boosting rounds 增长，增长的是 witness 大小和 prover work。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有改动协议公式，只增强了技术部分对全局 boosting-state commitment 的强调。

## 2026-04-08 21:22:24 +0800

### 用户本轮请求

- 在 3.4 的 Domain-lifted batch 中解释为什么约束写成 divisibility claim；
- 解释其含义，即 residual 在整个 domain 上为零，足以表达各类约束；
- 并强调这是本文的创新之一。

### 本轮处理

- 修改了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 的 3.4：
  - 在公式前补充了从 row-wise identity 到 residual polynomial 再到 vanishing polynomial divisibility 的解释；
  - 明确说明 divisibility claim 的语义就是“该约束在整个 domain 的每一行都成立”；
  - 增加一句，指出 domain-lifted batch 是本文提出的 proof-composition technique。
- 修改了 [sections/04_protocol.tex](sections/04_protocol.tex)：
  - 在 theorem 前加入一段更正式的说明；
  - 直接标明 domain-lifted batch 是本文的第一个新 batching tool。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有改动 theorem 内容或协议公式，只增强了 3.4/4.1 的解释性与贡献表达。

## 2026-04-08 21:26:53 +0800

### 用户本轮请求

- 联网检索相关上下文，确认 “domain-lifted batch / interleaved batch 都是本文创新” 这一 claim 是否站得住；
- 如果站得住，则在论文中论证其正当性，并写进去。

### 本轮处理

- 联网检索并核对了若干相关论文与资料，重点包括：
  - Aurora
  - CQ++
  - Sparrow
  - 以及若干围绕 vanishing polynomial / batching / interleaving 的 ePrint 检索
- 结论不是“绝对不存在先例”，而是更稳妥的学术表述：
  - 相关文献中已经普遍存在 vanishing-polynomial constraints 与同域 random-linear-combination batching；
  - 但没有找到把
    1. heterogeneous-domain linear claims 的 common-domain lifting，
    2. aligned same-form nonlinear bundles 的 coordinate-wise interleaving
    明确抽象成可复用 batching theorem 的做法。
- 因此正文里的 claim 被改成：
  - `to the best of our knowledge`
  - 并明确说明我们的 claim 是“as reusable proof-composition tools in this setting”，而不是宣称相关数学恒等式本身从未出现过。
- 对应修改了：
  - [sections/03_problem_statement.tex](sections/03_problem_statement.tex)
  - [sections/04_protocol.tex](sections/04_protocol.tex)
- 新增内容包括：
  - 与 Aurora / CQ++ 的对比句；
  - 对 novelty boundary 的收窄说明；
  - 同时把 domain-lifted 与 interleaved 两个工具都标为本文的 batching contributions。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有改动协议结构，只把 novelty claim 写得更有依据、更稳妥。

## 2026-04-08 21:54:37 +0800

### 用户本轮请求

- 认为 3.4 中对 interleaved batch 的解释仍不够清楚；
- 希望参考已有文档里的更完整描述，进一步优化 3.4 interleaved batch 的写作。

### 本轮处理

- 重新检索并阅读了仓库中关于 interleaving 的现有描述，重点参考：
  - [OVERVIEW.md](OVERVIEW.md)
  - [sections/04_protocol.tex](sections/04_protocol.tex)
  - 若干旧稿与实现侧说明中的 interleaving / replication 线索
- 重写了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中 3.4 的 `Interleaving batch` 段落。
- 新版叙事结构改为：
  - 先说明它要解决的问题：很多局部 nonlinear gadgets 虽然形式相同，却会分裂成很多独立小 batch；
  - 再说明第一步是先对齐 shape，通常由 replication 完成；
  - 再解释 interleaving 的具体动作：把各 bundle 的同位置 tuple 交错写入一个更大的 bundle；
  - 最后说明其语义：这不是改变约束，而是把多个局部 pointwise checks 重新编号为一个共享 domain 上的大 pointwise relation。
- 同时保留了其适用场景：
  - lookup-style table-difference checks；
  - same-form rounding constraints。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮只重写了 3.4 中 interleaved batch 的解释，没有改动 theorem 本身或后续协议结构。

## 2026-04-08 22:00:32 +0800

### 用户本轮请求

- 指出当前对 interleaved batch 原理的理解有误；
- 给出了一份更具体的 `Batch Lookup` 草稿，要求据此更正相关内容。

### 本轮处理

- 重新阅读了用户给出的 batch lookup 草稿，并核对了实现侧相关代码：
  - `include/algebra/interleaved_batching.hpp`
  - `src/algebra/interleaved_batching.cpp`
  - `src/protocols/less_check.cpp`
  - `src/protocols/exp_check.cpp`
- 确认此前的问题在于：把 interleaving 过度抽象成“bundle 重新编号”，而没有抓住其真正的代数核心：
  - 先用 $X \mapsto X^r$ 将短 query lift 到较大 domain；
  - 再用 verifier-known 的稀疏 `even/odd` selectors；
  - 把两个 query polynomial 交错成一个 virtual query polynomial；
  - 递归合并后，对同一张表只做一次 batched lookup / same-form nonlinear check。
- 对应修改了：
  - [sections/03_problem_statement.tex](sections/03_problem_statement.tex)
  - [sections/04_protocol.tex](sections/04_protocol.tex)
- 具体更新包括：
  - 在 3.4 中改为以 batched lookup 为核心例子解释 interleaving；
  - 明确写出 `even_n(X)`、`odd_n(X)` 与交错后的 $h(X)$；
  - 说明不同 domain 时先做 lift，再做 interleave；
  - 在第 4 节把原来的抽象 vector-level interleaving 定义改成 polynomial-level pairwise interleaving；
  - 将 theorem 改成递归的 `lift + interleave` 合并过程，并补充“merged bundle is virtual”的说明。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮已经把 3.4 与第 4 节的 interleaving formalization 对齐到同一套 lift-and-interleave 原理。

## 2026-04-08 22:13:26 +0800

### 用户本轮请求

- 认为当前 interleaved batch 的描述仍然过于偏向 batch lookup；
- 希望将其改写成更 generic 的版本，并解释在当前系统中有哪些 case 属于这个模板，例如 `div_check`。

### 本轮处理

- 进一步阅读并核对了实现中的 generic 用例，重点包括：
  - `div_check`
  - `exp_check`
  - `less_check`
  - `interleaved_batching.cpp`
- 将 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中 3.4 的 interleaved batch 重写为更 generic 的 “same-form local gadget” 叙事：
  - 先定义适用场景：多个共享同一 local verification rule 和同一组 public parameters 的 nonlinear gadget instances；
  - 再说明做法：group by shared public parameters，lift smaller domains，component-wise interleave witness bundles；
  - 最后说明 lookup / range check / divisibility-by-power-of-two 都是这个模板的实例。
- 同步修改了 [sections/04_protocol.tex](sections/04_protocol.tex)：
  - 在 interleaving 小节开头把对象从 “query families” 收成 generic “nonlinear gadget instances”；
  - 在 theorem 后补上 “先按 shared public parameters 分组，再在组内应用 theorem” 的说明。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有改动 interleaving 的代数原理，只把叙事从 lookup-specific 收回到 generic gadget-level 描述。

## 2026-04-08 22:31:49 +0800

### 用户本轮请求

- 认为 interleaved batch 的符号体系与 domain-lifted batch 差距过大；
- 希望在 3.4 中明确解释 substitution `X \mapsto X^r` 的作用，并引用对应引理；
- 认为 theorem 4.4 的描述不清楚，要求改成明确的递归合并过程：
  - 同 domain 直接合并成 doubled domain；
  - 否则取两个最小 domain，把较小者 lift 到较大者；
  - 重复直到只剩一项；
- 希望证明最终 domain 大小等于“不小于所有原始 domain 之和的最小 power-of-two”。

### 本轮处理

- 重写了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中 3.4 的 interleaving 叙事：
  - 将符号统一为与 domain-lifted batch 相同的索引风格 `i \in [m]`、domain size `n_i`、bundle `\mathcal U_i`；
  - 将 local gadget 明确写成共享 public parameter `\rho` 和 pointwise rule `\Psi_\rho` 的实例族；
  - 明确说明 `X \mapsto X^r` 的作用是借助 row replication，把较小 domain 上的行周期性复制到较大 domain 上，从而只改变 proof shape、不改变 local tuple 的语义；
  - 在 overview 层面把 merge 过程收成“equal-size merge / lift smaller then merge”的递归过程，并指出最终 domain 大小由 \cref{thm:interleaving-batch} 给出。
- 重写了 [sections/04_protocol.tex](sections/04_protocol.tex) 中的 interleaving theorem：
  - theorem 现在按用户要求，显式写成 active-bundle 递归合并算法；
  - 将对象记号统一成 polynomial bundle `\mathcal U_i = (u_i^{(1)}(X), \ldots, u_i^{(s)}(X))`；
  - 在 theorem 中直接陈述最终 domain 大小为 `\operatorname{pow2ceil}(\sum_i n_i)`；
  - 在 proof 中分别证明：
    - lift 与 pairwise interleave 保持原 pointwise relation；
    - 每一步 merge 在 domain-size 层面等价于把两项替换成 `\operatorname{pow2ceil}(a+b)`；
    - 递归合并后的最终结果确实等于总和的最小 power-of-two 上界。
- 顺手统一了 theorem 内的 evaluation 记号，避免 `u_i(a)` 与 vector indexing 混用。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮完成后，3.4 的 interleaving 叙事与第 4 节的 theorem 已经对齐到同一套 merge process 和同一套符号体系。

## 2026-04-08 22:42:36 +0800

### 用户本轮请求

- 认为 interleaving theorem 的符号仍然过重；
- 希望去掉 `\mathcal{U}_i` 一类的 bundle 记号，直接写成一堆 `(u_i(X), n_i)`；
- 希望去掉 `pow2ceil` 这类临时符号，改成正式的 `2^{\lceil \log_2(\cdot)\rceil}` 表述。

### 本轮处理

- 继续收紧了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中 3.4 的 interleaving 叙事：
  - 将对象从 `\mathcal U_i` 改写成更轻量的 `(u_i(X), n_i)`；
  - 将 merge process 直接写成“同 size 直接合并；否则取最小两个，先 lift 小的，再合并”的递归过程；
  - 将最终 domain 大小改写成 `n = 2^{\lceil \log_2(n_1+\cdots+n_m)\rceil}`。
- 重写了 [sections/04_protocol.tex](sections/04_protocol.tex) 中 interleaving theorem 的记号：
  - theorem 现在直接维护 active pairs `\{(u_i(X), n_i)\}`；
  - 去掉了 `pow2ceil` 记号，所有相关结论和 proof 都改写成 `2^{\lceil \log_2(\cdot)\rceil}`；
  - 保留了前一轮已经对齐到实现的 merge semantics，只是把呈现方式改得更轻、更接近正文口吻。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有改变 theorem 的含义，只是进一步简化了 interleaving 的符号和表述方式。

## 2026-04-09 00:06:39 +0800

### 用户本轮请求

- 认为 3.2 中“六点流程”仍然容易引起误解；
- 希望改成逻辑性表述，即“对于每个第 $t$ 轮，需要同时满足哪些条件”，而不是给人一种执行顺序的印象。

### 本轮处理

- 重写了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中 3.2 的主体段落：
  - 保留了单个 PCS 承诺全部 `\mathbf{S}^{(t)}` 的结构性说明；
  - 将原来的六点 pipeline 改写成“对每个 round $t$ simultaneously hold 的条件集合”；
  - 新表述现在按逻辑关系组织为五项：
    - 当前 boosting state `\mathbf{S}^{(t)}, \mathbf{G}^{(t)}` 的正确性；
    - 每棵 round-`t` class-specific tree 的 leaf assignment 正确性；
    - 由 leaf assignment 和 residual 派生出的 histogram 正确性；
    - 由 histogram 导出的 split-score tensor 与 `(\mathbf{E}, \boldsymbol{\Theta})` 的优化性绑定；
    - 当前 round leaf values 与下一状态 `\mathbf{S}^{(t+1)}` 的更新一致性。
- 将结尾总结句改成“这些条件 together imply a valid plaintext GBDT training trajectory”，避免读者把这小节理解成执行脚本。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有改动协议含义，只调整了 3.2 的逻辑组织和表述方式。

## 2026-04-09 00:13:44 +0800

### 用户本轮请求

- 检查 3.2 中出现的符号是否都已经在上文明确给出 shape；
- 如果某个对象此前没有明确 shape，则要求在它第一次出现处补上。

### 本轮处理

- 逐项核对了 [sections/02_background.tex](sections/02_background.tex) 与 [sections/03_problem_statement.tex](sections/03_problem_statement.tex)：
  - `\mathbf{S}^{(t)}`、`\mathbf{G}^{(t)}` 的 shape 已在 background 中定义，但为了减少读者来回翻找，在 3.2 中再次显式写成 `\mathbb{F}^{M\times K}`；
  - `\boldsymbol{\ell}^{(t,k)}`、`\mathbf{E}`、`\boldsymbol{\Theta}` 的 shape 在 3.1 已定义，因此未重复扩写；
  - `histograms`、`candidate split-score tensor`、`leaf values` 在 3.2 中此前只有语义，没有 shape，于是补成：
    - histogram tensors over `N_{\mathrm{tot}}\times d\times B`；
    - `\Gamma^{(t,k)}\in\mathbb{F}^{N_{\mathrm{int}}\times d\times B}`；
    - `\widetilde{\mathbf{W}}^{(t)}\in\mathbb{F}^{N_{\mathrm{tot}}\times K}`；
    - `\mathbf{S}^{(t+1)}\in\mathbb{F}^{M\times K}`。
- 保持了 3.2 的逻辑化写法，没有再把它改回流程叙事。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮只补了 shape 信息，没有改变任何协议内容。

## 2026-04-09 00:25:02 +0800

### 用户本轮请求

- 检查全文中的符号，确认它们第一次被定义的位置；
- 如果某个符号出现时尚未被定义，则在适当位置补充定义或说明。

### 本轮处理

- 进行了一轮全文符号审计，重点检查：
  - background 中的全局基础记号是否覆盖后文使用；
  - technical overview 中新引入的 round-level objects 是否在首次出现处有 shape；
  - protocol 节中局部中间变量是否存在“先用后定义”。
- 在 [sections/05_zkgbdt.tex](sections/05_zkgbdt.tex) 中补了几类此前缺少首次说明的符号：
  - `\mathbf{tree}_{\mathrm{int}}`：说明为 internal rows 上的 tree-index vector，leaf / padding rows 上补零；
  - inference lookup 中的
    `\mathbf{ind}, \mathbf{U}^{\leftarrow}, \mathbf{U}^{\rightarrow}, \mathbf{s}`：
    补了各自的 shape 和语义；
  - `\mathbf{tree}_{\mathrm{ext}}, \mathbf{F}^{\leftarrow}, \mathbf{F}^{\rightarrow}`：
    说明为 committed columns 的 leaf-row restrictions；
  - softmax 辅助对象 `\mathbf{P}^{(t)}, \mathbf{Z}^{(t)}, \mathbf{I}^{(t)}`：
    补了 shape；
  - prefix / total / right-side statistics：
    补了
    `\mathbf{C}^{(t,k)}_{\leq}, \mathbf{H}^{(t,k)}_{\leq}`,
    `\mathbf{C}^{(t,k)}_{\Sigma}, \mathbf{H}^{(t,k)}_{\Sigma}`,
    `\mathbf{C}^{(t,k)}_{>}, \mathbf{H}^{(t,k)}_{>}`
    的 shape；
  - `\Gamma^{(t,k)}`：
    在 protocol 节首次定义处补了 shape；
  - `\widetilde{\mathbf{n}}^{(t,k)}, \widetilde{\mathbf{a}}^{(t,k)}`,
    `\widetilde{\mathbf{W}}^{(t)}`, `\mathbf{W}^{(t)}`：
    补了 shape。
- 此前在 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中已经补过
  `\mathbf{S}^{(t)}, \mathbf{G}^{(t)}, \Gamma^{(t,k)}, \widetilde{\mathbf{W}}^{(t)}` 等
  round-level 对象的 shape，本轮保留不动。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮完成后，全文中我检查到的主要“先用后定义”的局部技术符号都已补到首次自然出现处。

## 2026-04-09 00:39:11 +0800

### 用户本轮请求

- 继续优化技术部分的写作；
- 目标是让行文更流畅易懂，同时让符号更明确、更直观。

### 本轮处理

- 对 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 做了一轮 prose pass：
  - 收紧 opening 段落，使“核心挑战 / 两个障碍 / 三个 ingredient”更直接；
  - 将 3.1 开头改成更直接的 “adopt the hyperbox encoding of CQ++” 写法；
  - 调整 3.1 里若干解释句的句法，减少机械重复；
  - 继续收紧 3.2 的五条条件，使它们更平行、更像 correctness conditions；
  - 将 `(\mathbf{E}, \boldsymbol{\Theta})` 等对象写成更直观的“encoded split”表述；
  - 收紧 3.4 domain-lifted / interleaving 两段的叙事，减少绕句；
  - 对 `u_i(a)` 增补说明：它表示从 witness bundle 在行 `a` 处抽出的 local tuple。
- 对 [sections/04_protocol.tex](sections/04_protocol.tex) 做了轻量澄清：
  - 在 interleaving theorem 里补了 `u_i(a)` 的解释；
  - 保持 theorem 和 proof 的数学内容不变，只改可读性。
- 对 [sections/05_zkgbdt.tex](sections/05_zkgbdt.tex) 做了对应的 prose 收束：
  - batched inference 改成 “two-stage proof” 的直接表述；
  - round-level proof graph 的说明更简洁；
  - propagation / gain / leaf-value 小节中若干过长句被拆短；
  - 若干局部对象改成更自然的描述，例如 “the split encoded by ...”。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有改协议语义，只做了写作和局部记号说明的优化。

## 2026-04-10 00:10:52 +0800

### 用户本轮请求

- 认为 3.4 中 interleaved batch 的写作太 formal、太蹩脚；
- 希望在 tech overview 中改成：
  - 简要说明问题；
  - 非正式地描述两个同形向量 `f,g` 在同一个 local constraint 下如何 batch；
  - 说明这个约束是 local 的，只依赖当前位置的值；
  - 简单讨论不同长度向量的情况；
- 同时希望去掉 `\Psi_\rho` 这类不直观的符号。

### 本轮处理

- 重写了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中 3.4 的 interleaving 段落：
  - 不再从抽象 predicate + parameter tuple 开始；
  - 改成先讲“same-form local nonlinear checks”的问题；
  - 明确写出 local 的含义：某一行是否合法只依赖该行本身，不依赖向量的其他位置；
  - 用两个等长向量 `\mathbf f,\mathbf g` 和同一个局部约束 `\varphi(x)=0` 作为核心说明；
  - 保留 `\operatorname{Int}_n(f,g)` 公式，但其作用现在作为例子出现，而不是抽象定义的中心；
  - 对不同长度的情况，改成一句直观说明：先用 `X\mapsto X^r` 按 row replication 把短向量 lift 到大域，再 interleave；
  - 结尾再回到“实际协议里是 component-wise 作用于短 witness bundles”。
- 同步修改了 [sections/04_protocol.tex](sections/04_protocol.tex) 中 interleaving theorem 的记号：
  - 将 theorem 里的公共局部关系从 `\Psi(\rho;\cdot)` 改成更直观的 `\varphi(\cdot)`；
  - 将 shared public parameters 改写成一句说明，而不再塞进 predicate 记号本身。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有改 interleaving theorem 的数学内容，只重写了 overview 叙事并同步简化了记号。

## 2026-04-10 00:16:47 +0800

### 用户本轮请求

- 指出 interleaving 这段不应使用 `row` 叙事；
- 要求完全按向量视角来写，把 `f,g` 当作向量，使用 `entry / position` 一类表述。

### 本轮处理

- 对 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中 3.4 的 interleaving 段落做了纯措辞修正：
  - 将 “validity at one row” 改成 “validity at one position”；
  - 将 “row by row” 改成 “entrywise”；
  - 将 “every row of the larger domain still corresponds ...” 改成 “every position of the larger vector ...”。
- 对 [sections/04_protocol.tex](sections/04_protocol.tex) 中对应 theorem / proof 做了同样的视角统一：
  - 将 “every row must satisfy” 改成 “every point must satisfy”；
  - 将 proof 中 “repeats the rows” 改成 “repeats the entries of the evaluation vector”；
  - 将 “row-wise relation” 改成 “pointwise relation”。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮没有改动任何数学内容，只统一了 interleaving 段落的向量化表述。

## 2026-04-10 00:20:33 +0800

### 用户本轮请求

- 将 interleaving 示例中的向量元素记号从 `\mathbf{f}_0` 改成 `\mathbf{f}[0]`；
- 同时要求在第 2 节检查并补充这种 bracket indexing 的说明。

### 本轮处理

- 修改了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex)：
  - 将 interleaving 示例向量改成
    `(\mathbf{f}[0], \mathbf{g}[0], \mathbf{f}[1], \mathbf{g}[1], \ldots)`。
- 修改了 [sections/04_protocol.tex](sections/04_protocol.tex)：
  - 将 pairwise interleaving 定义中的 evaluation vector 改成
    `(f[0], g[0], f[1], g[1], \ldots, f[n-1], g[n-1])`。
- 修改了 [sections/02_background.tex](sections/02_background.tex)：
  - 在 notation 小节补了一句，说明当需要强调向量索引时，统一写成 `\mathbf{v}[i]`。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 本轮仅统一了索引记法，没有改动任何协议内容。

## 2026-04-10 00:28:41 +0800

### 用户本轮请求

- 希望继续精简 sec 3 的 `domain-lifted batch`；
- 要求只展示两个不同 domain size 的实例如何合并，而不是泛化到多个实例。

### 本轮处理

- 精简了 [sections/03_problem_statement.tex](sections/03_problem_statement.tex) 中的 `domain-lifted batch`：
  - 去掉了多实例批处理的 general `m`-claim 叙事；
  - 改成只讲两个线性 claim 的合并；
  - 现在 overview 里直接说明：
    - 两个 claim 分别写在 `\mathbb{H}_{n_1}` 和 `\mathbb{H}_{n_2}` 上；
    - 将较小的 residual 通过 `\nu_{n_2}(X)/\nu_{n_1}(X)` lift 到大域；
    - 然后在同一个 ambient domain 上做普通 batch。
- 保留了正式 theorem 的完整 generality，没有改 [sections/04_protocol.tex](sections/04_protocol.tex) 的 theorem 形式。

### 验证

- 运行了 `latexmk -pdf main.tex`；
- 编译成功，`main.pdf` 已更新；
- 这轮只收缩了 overview 的展示范围，没有改 theorem 或协议语义。

### 本轮补充

- 将论文正文中的术语统一为 `domain-lifting batching` 和 `interleaving batching`；
- 同步更新了摘要、引言、协议节、结论和附录中的 visible 表述；
- 同时把对应 theorem / equation 标签也改成了新的命名，保持源文件检索一致。

### 本轮继续

- 继续检查全文里 `batch` 相关表述的自然程度；
- 把摘要、引言、`3.4`、`4` 节、结论和附录里偏生硬的句子改得更直接；
- 保持协议语义不变，只优化叙述流畅度和术语一致性。

### 本轮索引统一

- 扫描全文中的二维矩阵索引写法；
- 将 `\mathbf{V}[i][j]` 统一改为 `\mathbf{V}[i,j]`；
- 重新编译确认没有影响正文排版或交叉引用。

### 本轮 theorem 4.4

- 将 `4.4` 的 interleaving batching theorem 改写成“递归合并算法 + 证明”的结构；
- statement 中直接列出 lift / interleave 的 merge 规则；
- proof 中保留 row-replication 和 pairwise interleaving 的正确性论证，并用归纳给出最终 domain size 结论。

### 本轮再调整

- 按你的要求，把 theorem statement 改成“存在一个算法”；
- statement 只陈述该算法能合并为单个 check、不会引入新的 PCS，并满足性质 1/2；
- proof 中再展开具体 merge 算法与两个性质的证明。

### 本轮补充性质

- 在 `4.4` 的 interleaving batching theorem 中新增 opening / verification 复杂度性质；
- 现在 theorem 明确说明：`widehat{u}` 的 opening 可归约到各个 `u_i` 的 opening；
- 同时补充 verifier 侧的 `O(n\log \widehat{n})` 检查开销表述。

### 本轮简化

- 重新梳理了 theorem 4.4 的 statement 和 proof，保留三条原始性质；
- statement 仍只说明“存在一个算法”，proof 中给出具体 merge 过程；
- 压缩了 proof 中关于实现和复杂度的重复解释，保留 row-replication、interleaving 和 domain-size 的核心论证。

### 本轮两遍 scan

- 将 theorem 4.4 的 proof 改成两遍 scan 结构；
- 第一遍按桶从小到大合并相同 size 的 pair，并保持总 size 不变；
- 第二遍再取最小的两个 active pair 合并，从而更直接地推出 property 2 的 domain-size 上界和最终取整结果。

### 本轮 lookup example

- 在 `4.2` 后新增了一个 explicit lookup batching example；
- 例子说明如何先在每个 table 内 interleave queries，再用随机平移把不同 table 合成一个大 table；
- 最后把所有 family-level query 再 interleave 成一个总 query，并用一次 lookup 证明 `\mathbf{f}\subseteq \mathbf{t}`。

### 本轮 quantization

- 在 sec 2 新增了 `Quantization and Fixed-Point Reduction` 小节；
- 用统一的 fixed-point 视角解释了 feature bin、$2^q$ 量化、floor rounding，以及后续的 divisibility / quotient 约束；
- 在 `4.2` 后补了一个 interleaving batching 的 quantization 例子，强调多个同 divisor + rounding 的固定点检查可以合并成一个虚拟实例。

### 本轮 SUGGESTION 第一批修订

- 按 `SUGGESTION.md` 对 sec 2 增补了 object glossary、PCS 接口说明、formal statement、informal security theorem，以及 `Field Embedding and Range Assumptions`；
- 明确把 trainer 语义收束为“fixed quantized trainer semantics”，而不是泛化地声称证明任意真实 GBDT / XGBoost 训练；
- 收紧了 sec 3 的 overview：补了 routing orientation、accepting leaf 的唯一性、valid split 的限制，并弱化了关于 round 数不增长的表述；
- 收紧了 sec 4 的 batching tools：domain-lifting batching 加入了 residual / degree 语境，interleaving batching 改成 bundle 版本并弱化了复杂度与 opening 的 claim；
- 将 sec 5 的 protocol 主体改成命题式结构，补了 forest well-formedness、batched inference、boosting-state、leaf assignment、histogram、propagation、prefix / total、split optimality、leaf values 与 round-level theorem。

### 本轮 SUGGESTION 第二批修订

- 在 sec 5 里把 address-based aggregation 的语义补成了显式 statement，并把 prefix operator 明确成 public linear map；
- 补写了 `Protocol soundness` theorem，把 KZG、imported gadgets、domain-lifting、interleaving 与 aggregation 的误差源统一进一个 union-bound 形式；
- 更新了 Appendix A：Algorithm 2 现在直接调用 sec 5 的命题名，并新增 relation / gadget / batching / imported-vs-new 的汇总表；
- 顺手收了两处版面问题：leaf histogram aggregation 那段的长句，以及 appendix relation table 的宽度。

### 本轮 SUGGESTION 收尾

- 明确把 lookup、aggregation、max-selection 与 softmax 一样写成 named imported interfaces，而不再使用含混的 “standard gadget” 口吻；
- 在 sec 4 的 lookup batching example 里补了 tuple-encoding 的说明；
- 在 sec 2 与 sec 5 的安全性表述里都明确说明：本文主张 soundness，而不单独主张 argument of knowledge；
- 将 appendix 关系表直接缩放到版心，进一步压低版面 warning。

### 本轮 ACM CCS 模板切换

- 联网核对了 ACM 官方模板来源：`acmart` 官方文档当前版本为 `v2.16 (2025/08/27)`，并确认 submission / review 模式应使用 `acmart` 的 `manuscript, review` 选项；
- 将最新 released `acmart` 模板 vendored 到项目根目录，新增 `acmart.cls`、`ACM-Reference-Format.bst`、`acm-jdslogo.png`，覆盖系统里旧的 `acmart v1.81`；
- 将 `main.tex` 从 `article` 切换为 `\documentclass[manuscript,review,anonymous]{acmart}`，同时改用 `ACM-Reference-Format` 参考文献样式，并修复了 `abstract` 位置与 `amssymb`/`newtx` 的兼容问题；
- 重新编译 `latexmk -pdf main.tex` 通过；当前剩余的是 `acmart` 自身的元数据提醒，例如 `keywords`、`CCS concepts`、图片 `Description` 尚未补全。

### 本轮按 CCS 2026 CFP 最小样例收口

- 重新核对了 CCS 2026 CFP 页面与其链接的官方最小样例 `sample-ccs2026.tex`，不再沿用通用 `acmart` 的推断配置；
- 将 `main.tex` 的头部改成 `sample-ccs2026.tex` 的结构：使用 `\documentclass[sigconf]{acmart}`，保留示例 rights-management 字段、CCSXML 块、`\ccsdesc` 与 `\keywords` 区块，并保持匿名提交方式；
- 将 bibliography 移到 appendix 之前，并新增单独的 `Open Science` appendix 占位文件 `sections/09_open_science.tex`，使整体结构更接近 CFP 要求；
- 重新编译 `latexmk -pdf main.tex` 通过；当前 PDF 为 `13` 页，剩余主要是正文版面 overfull/underfull、图片 `Description`、以及 appendix 中的个别交叉引用 warning。

### 本轮 sec 2 与记号规范整理

- 参考 `zkPOT_CNN-1.pdf` 的 preliminaries 风格，重写了 `sections/02_background.tex` 中的 `2.4 Quantization and Fixed-Point Reduction`，将其收束为一条统一的固定点缩放语义：公共尺度 `\Delta=2^q`、量化关系 `b=a\Delta+r`、以及它为何是 interleaving batching 的典型应用；
- 重写了 `2.5 Field Embedding and Range Assumptions`，不再罗列多组细碎的 bounds，而是引入单一的公共幅值上界 `\mathcal{B}`，并用 `2\mathcal{B}<|\mathbb{F}|` 给出 no-wraparound 命题；
- 顺手把 encoding 约定里的向量项写法统一成 `\mathbf{v}[i]`，避免在 preliminaries 里混用 `v_i` 与 `\mathbf{v}[i]`；
- 新增 `NOTATION.md`，集中记录当前论文的全局非临时符号和写作约定，包括 bold arrays、方括号索引、`f(X)` 作为向量编码多项式、padding / tilde 语义、以及 forest / histogram / batching tools 的占用符号；
- 新增 `AGENT.md`，要求后续 agent 在编辑论文前先读 `NOTATION.md`，并在引入新全局符号时同步更新该文档；
- `latexmk -pdf main.tex` 重新编译通过；未引入新的 LaTeX 错误。

### 本轮 2.4 收口

- 按“固定点算术规则”重写了 `2.4`：不再讨论 softmax 或具体子协议，只保留加减法不需要 rescale、乘除会把尺度推到更大域因而必须显式 reduction 这一条主线；
- 将量化关系明确写成 `a=\lfloor b/\Delta\rfloor \Leftrightarrow b=a\Delta+r`，并解释它为什么是后文反复出现的 fixed-point reduction relation；
- 补回了 `2.5` 里的 `No-wraparound regime` 命题与证明，重新强制编译后交叉引用已恢复正常。
