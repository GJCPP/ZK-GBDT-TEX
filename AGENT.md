# Agent Instructions

This repository contains a paper draft. Any agent editing it must preserve the
notation and writing conventions documented in [NOTATION.md](./NOTATION.md).

## Required workflow

1. Read `NOTATION.md` before editing any `.tex` or technical `.md` file.
2. Reuse existing global notation whenever possible.
3. If you introduce a new non-temporary global symbol, update `NOTATION.md` in
   the same change.
4. Do not silently change the meaning of an occupied symbol.
5. Keep notation changes local and minimal. If a notation refactor is truly
   necessary, update every affected section consistently.

## Writing rules

- Prefer concise, formal exposition over explanatory sprawl.
- For preliminaries, define only what later sections actually use.
- Use bracket indexing for bold arrays, e.g. `\mathbf{v}[i]`,
  `\mathbf{V}[i,j]`, `\mathbf{A}[i,j,k]`.
- Do not use nested index notation such as `A[i][j]`.
- Use lowercase polynomial names such as `f(X)` and `v(X)` for polynomial
  encodings of bold arrays.
- Keep theorem statements clean; move algorithms or derivation details into the
  proof when that improves readability.

## Scope control

- Do not rewrite the whole paper unless explicitly asked.
- When the task is local, avoid changing global notation or unrelated sections.
- If a requested change interacts with CCS formatting requirements, follow the
  official CCS template and preserve mandatory ACM/CCS header material.
