# Prompt for AI Agent: Continue the ZK GBDT Paper

You are continuing work on the LaTeX paper project in this directory. Your job
is not only to answer the user's immediate request, but also to preserve
continuity across turns.

## Primary Goals

1. Help improve the ZK GBDT paper and project files in a way consistent with
   the current draft direction.
2. Prefer a security-systems paper style (CCS / IEEE S\&P / USENIX Security)
   over a pure cryptography-paper style, unless the user explicitly asks for
   stronger formalization.
3. Keep notation, terminology, and motivation readable to a systems-security
   audience.
4. Preserve correctness and mathematical rigor where needed, but avoid
   front-loading too much crypto-specific machinery before the reader needs it.

## Paper Direction

The current draft has converged to the following structure:

1. `Introduction`
2. `Preliminaries`
3. `Technical Overview`
4. `Construction`
5. `Evaluation`
6. `Related Work`
7. `Conclusion`

The current narrative is:

- explain plaintext / quantized GBDT first;
- explain why proving optimal split is hard;
- motivate the histogram-based view as the key bridge;
- use the technical overview to explain the system flow;
- keep the more algebraic batching / replication / interleaving discussion in
  the construction section.

## Important Writing Preferences

- Avoid unnecessary "crypto smell" in early sections.
- Do not introduce terms abruptly. If a term like `sorting`, `argmax`,
  `hyperbox`, `pseudo-residual`, or `batched identity` appears, make sure it has
  enough context before or at first use.
- When introducing a technical tool, explain:
  - why it is needed;
  - where it is used;
  - what complexity or proof-structure problem it solves.
- Prefer high-level security-paper exposition first, then formulas, then local
  technical detail.
- Keep imported primitives clearly separated from the paper's new contributions.

## Current Technical Emphasis

The main contribution line currently centers on:

- histogram / aggregation as first-class proof objects;
- domain lifting for heterogeneous subgroup sizes;
- replication for shape alignment;
- interleaving for bundling pointwise nonlinear checks;
- training proof written as a structured pipeline instead of a monolithic
  generic circuit.

## Citation Policy

- If you add or change references, ensure they refer to real papers.
- When online verification is needed, verify titles and bibliographic metadata.
- Prefer real primary sources and actual publication metadata.

## Required Maintenance Task After Each Round

After every meaningful interaction round, you must update:

- `Agent Conversation Log.md`

Append a new dated summary entry that records:

1. the user's latest request;
2. what you changed, decided, or investigated;
3. important terminology or structural changes;
4. compile / verification status;
5. recommended next steps.

Do not overwrite the existing log. Append to it.
Write the appended summary in Chinese, because the collaboration is primarily
conducted in Chinese.

## Working Method

- Read the current LaTeX files before making structural changes.
- If the user's request concerns writing quality or paper flow, inspect the
  neighboring sections as well, not just the local file.
- If the task affects paper structure, check whether the introduction, roadmap,
  and related work still match the updated organization.
- Compile after substantial edits whenever feasible.

## Immediate Local Context

Before doing new work, read:

- `Agent Conversation Log.md`
- `sections/01_introduction.tex`
- `sections/02_background.tex`
- `sections/03_problem_statement.tex`
- `sections/04_protocol.tex`

Then continue from the current draft state rather than restarting the paper
design from scratch.
