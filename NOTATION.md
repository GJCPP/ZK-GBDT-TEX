# Notation Guide

This file records the paper's current global notation and formatting conventions.
It is the source of truth for non-temporary symbols. When editing the paper,
reuse the symbols below unless there is a strong reason to change them.

## General conventions

- We work over a finite field `\mathbb{F}`.
- Indices start from `0` unless stated otherwise.
- For `n \in \mathbb{N}`, `[n] := \{0,1,\ldots,n-1\}`.
- Bold symbols denote committed arrays.
  - Bold lowercase is preferred for one-dimensional vectors introduced in new text.
  - Bold uppercase is used for matrices and tensors, and also for global objects already fixed in the paper, such as `\mathbf{D}`, `\mathbf{Y}`, `\mathbf{S}`, `\mathbf{G}`.
- Array entries use bracket notation:
  - vector entry: `\mathbf{v}[i]`
  - matrix entry: `\mathbf{V}[i,j]`
  - tensor entry: `\mathbf{A}[t,k,r]`
- Do not use nested indexing such as `A[i][j]`.
- If `\mathbf{v}\in\mathbb{F}^n` is a vector, then `v(X)` denotes its polynomial encoding over `\mathbb{H}_n`.
- More generally, lowercase roman polynomials such as `f(X)`, `g(X)`, `u(X)`, `v(X)` denote encodings of the corresponding bold arrays after row-major flattening.
- Tensor slice notation is preferred for round/class indices, e.g. `\mathbf{S}[t,k,r]` and `\widetilde{\mathbf{W}}[t,u,k]`.
- A tilde indicates a padded or ambient-space version of an object, e.g. `\widetilde{\mathbf{W}}`.
- `\Flat(\mathbf{A})` denotes row-major flattening of a tensor into a vector.

## Field and domain symbols

- `\mathbb{F}`: base field.
- `L`: ambient power-of-two exponent used to derive all evaluation domains.
- `\omega`: primitive `2^L`-th root of unity.
- `\omega_n`: primitive `n`-th root of unity induced from `\omega`.
- `\mathbb{H}_n`: multiplicative subgroup of size `n`.
- `\nu_n(X)`: vanishing polynomial of `\mathbb{H}_n`, namely `X^n - 1`.
- `\lambda_n^{(i)}(X)`: `i`-th Lagrange basis polynomial on `\mathbb{H}_n`.

## Public dimensions and global parameters

- `M`: number of training samples.
- `d`: number of features.
- `B`: number of feature bins.
- `K`: number of classes.
- `T`: number of boosting rounds.
- `b`: external inference batch size.
- `\mu`: public learning rate.
- `\Delta := 2^q`: public fixed-point scale.
- `\mathcal{B}`: single public magnitude bound used in the no-wraparound assumption.

## Node and tree indexing

- `N_{\mathrm{int}}`: number of internal nodes in the global forest namespace.
- `N_{\mathrm{tot}}`: total number of node rows in the global forest namespace.
- Node identifiers are one-based; node `u` corresponds to physical row `u-1` after row-major flattening.
- Internal-node identifiers lie in `\{1,\ldots,N_{\mathrm{int}}\}`.
- Leaf identifiers lie in `\{N_{\mathrm{int}}+1,\ldots,N_{\mathrm{tot}}\}`.
- The value `0` is reserved as the null child pointer for leaf and padding rows.
- Trees are globally indexed by round-major, class-minor order.

## Data and boosting-state objects

- `\mathbf{D}\in[B]^{M\times d}`: quantized dataset.
- `\mathbf{Y}\in\{0,1\}^{K\times M}`: one-hot label matrix.
- `\mathbf{S}\in\mathbb{F}^{T\times K\times M}`: score tensor.
- `\mathbf{P}\in\mathbb{F}^{T\times K\times M}`: exponentiated score tensor.
- `\mathbf{Z}\in\mathbb{F}^{T\times M}`: sample-wise softmax denominator tensor.
- `\boldsymbol{\pi}\in\mathbb{F}^{T\times K\times M}`: softmax probability tensor.
- `\mathbf{I}\in\mathbb{F}^{T\times M}`: inverse-denominator tensor used by the imported softmax interface.
- `\mathbf{G}\in\mathbb{F}^{T\times K\times M}`: pseudo-residual tensor.

## Forest objects

- `\mathbf{lc},\mathbf{rc}\in\{0,1,\ldots,N_{\mathrm{tot}}\}^{N_{\mathrm{tot}}}`: left/right child index vectors, with internal entries pointing to one-based child identifiers and leaf/padding entries equal to `0`.
- `\mathbf{L},\mathbf{R}\in\{0,1\}^{N_{\mathrm{tot}}\times N_{\mathrm{tot}}}`: sparse routing operators induced by `\mathbf{lc},\mathbf{rc}` when a matrix form is convenient.
- `\mathbf{N}^{\leftarrow},\mathbf{N}^{\rightarrow}\in[B+1]^{N_{\mathrm{tot}}\times d}`: lower and upper node bounds.
- `\mathbf{E}\in\{0,1\}^{N_{\mathrm{tot}}\times d}`: feature-selection matrix.
- `\boldsymbol{\Theta}\in[B]^{N_{\mathrm{tot}}}`: threshold-index vector.
- `\mathbf{tree}\in[TK]^{N_{\mathrm{tot}}}`: tree-index vector.
- `\mathbf{Root}\in\{0,1\}^{TK\times N_{\mathrm{tot}}}`: root selector matrix.
- `\mathbf{score}\in\mathbb{F}^{N_{\mathrm{tot}}}`: leaf-score vector.
- `\mathbf{tree}_{\mathrm{int}}`: internal-row restriction of `\mathbf{tree}`, extended by zeros elsewhere.
- `\mathbf{tree}_{\mathrm{ext}}`: leaf-row restriction of `\mathbf{tree}`.
- `\mathbf{F}^{\leftarrow}, \mathbf{F}^{\rightarrow}`: leaf-row restrictions of `\mathbf{N}^{\leftarrow}, \mathbf{N}^{\rightarrow}`.

## Inference objects

- `\mathbf{X}\in[B]^{b\times d}`: inference query batch.
- `\mathbf{X}^{\mathrm{rep}}`: tree-replicated query tensor used in batched inference.
- `\mathbf{ind}\in[TK]^{bTK}`: fetched tree indices in inference.
- `\mathbf{U}^{\leftarrow}, \mathbf{U}^{\rightarrow}\in[B+1]^{bTK\times d}`: fetched lower/upper boxes.
- `\mathbf{s}\in\mathbb{F}^{bTK}`: fetched leaf scores.

## Training and histogram objects

- `\mathbf{L}\in\{N_{\mathrm{int}}+1,\ldots,N_{\mathrm{tot}}\}^{T\times K\times M}`: leaf-assignment tensor.
- `\operatorname{addr}\in[N_{\mathrm{tot}}dB]^{T\times K\times M\times d}`: zero-based histogram-aggregation addresses induced by `\mathbf{L}` and `\mathbf{D}`.
- `\mathbf{C}, \mathbf{H}\in\mathbb{F}^{T\times K\times N_{\mathrm{tot}}\times d\times B}`: count and residual-sum histogram tensors.
- `\mathbf{C}^{\mathrm{leaf}}, \mathbf{H}^{\mathrm{leaf}}`: leaf-supported histogram tensors before propagation.
- `\mathbf{C}_{\le}, \mathbf{H}_{\le}`: prefix histograms along the bin axis.
- `\mathbf{C}_{>}, \mathbf{H}_{>}`: right-side histograms derived from totals minus prefixes.
- `\Gamma\in\mathbb{F}^{T\times K\times N_{\mathrm{int}}\times d\times B}`: candidate split-score tensor.
- `\widetilde{\mathbf{W}}\in\mathbb{F}^{T\times N_{\mathrm{tot}}\times K}`: padded leaf-value tensor.
- `\mathbf{W}`: compact leaf-only version of the same object when needed.

## Batching-tool symbols

- `F_i(X), Q_i(X)`: residual and quotient polynomials in domain-lifting batching.
- `\widehat{F}_i(X)`: lifted residual polynomial.
- `N`: largest common ambient domain size in a domain-lifting batch.
- `\eta`: random batching challenge used in linear combination.
- `\mathbf{u}_i(X) = (u_{i,1}(X),\ldots,u_{i,c}(X))`: bundle of encodings in interleaving batching.
- `\widehat{\mathbf{u}}(X)`: merged interleaved bundle.
- `\varphi`: local nonlinear relation checked pointwise.
- `\operatorname{even}_n(X), \operatorname{odd}_n(X)`: sparse public selectors used in pairwise interleaving.
- `\operatorname{Int}_n(f,g)(X)`: pairwise interleaving of two length-`n` encodings.

## Imported proof interfaces

- `\Pi_{\mathrm{softmax}}`: imported softmax proof interface.
- `\Pi_{\mathrm{lookup}}`: imported lookup proof interface.
- `\Pi_{\mathrm{agg}}`: imported aggregation proof interface.
- `\Pi_{\mathrm{max}}`: imported max-selection proof interface.

## Reserved-style rules

- Do not reuse any symbol listed above for a different global meaning.
- Temporary proof-local letters such as `a,b,c,i,j,r,x,z` are fine, but they should remain local.
- If a new symbol becomes global, add it to this file in the same change.
- If a global symbol changes meaning, update this file and all affected paper sections together.
