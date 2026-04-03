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
