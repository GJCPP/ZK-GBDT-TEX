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
