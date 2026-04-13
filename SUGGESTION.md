# Revision instructions for the technical part of the CCS draft

Ignore the introduction and evaluation sections for now. Focus only on improving the technical core (Sections 2–5 and Appendix A). The goal is to turn the current draft from a high-level architecture sketch into a technically closed, reviewer-resistant CCS paper.

## Overall diagnosis

The current technical part has a strong high-level idea, but it still reads more like a design blueprint than a complete protocol paper. The main strengths are:
- the core intuition is clear: avoid proving per-feature sorting, and instead prove histogram correctness plus algebraic split reconstruction;
- the paper has a good organizing principle around a small primitive catalog;
- the use of global node namespace, hyperbox forest encoding, and round-level dependency structure is promising.

However, in its current form, the draft still has four major weaknesses:

1. **The exact proved statement is not formalized tightly enough.**  
   It is still unclear what is public, what is committed/private, what exact trainer semantics are being proved, and what end-to-end relation the verifier accepts.

2. **Several key protocol steps are only named, not specified.**  
   For example: leaf-assignment proof, histogram aggregation at addresses, prefix-sum proof, zero-safe division proof, max-selection proof, and batching across rounds/classes are all mentioned, but not instantiated precisely enough.

3. **Some theorem statements and proofs are currently too weak or too informal.**  
   In particular, Theorem 4.4 is not yet stated at the right level of generality for how it is later used, and its proof has gaps / overclaims.

4. **The writing often repeats the same intuition twice (Section 3 and Section 4 / 5), while the truly reviewer-critical details are deferred or hidden behind phrases like “standard,” “usual,” or “handled by an imported subroutine.”**  
   For CCS, this is dangerous: reviewers will attack the undefined edges.

---

## Highest-priority fixes

## 1. Make the exact relation and security statement explicit

Add a formal subsection near the start of the technical part called something like:

### `Formal statement being proved`

It should define:
- what is public: `(M, d, B, K, T, learning rate, tree shape/depth policy, quantization parameters, lookup tables, PCS parameters, etc.)`;
- what is secret but committed: dataset `D`, labels `Y`, forest metadata, leaf values, boosting-state tensors, intermediate trace;
- what the witness is;
- what exact relation the verifier checks.

State the main theorem in a formal way, e.g.:

- **Completeness**: an honestly generated quantized training trace is accepted;
- **Soundness**: any accepting proof implies existence of a witness corresponding to a valid execution of the specified quantized GBDT trainer;
- **Zero knowledge / witness privacy**: specify exactly what hiding property is achieved, under what commitment variant and imported subprotocol assumptions.

Right now, the paper says many things informally, but there is no single formal theorem that says exactly what the protocol proves.

### Important:
Do **not** describe the proved semantics as “real GBDT training” in an unqualified way. Describe it as:
- **correct execution of a fixed, quantized, tabulated trainer semantics**, or
- **correct execution of the quantized training trace defined in the paper**.

That wording matters.

---

## 2. Clarify the trainer semantics: are we proving Friedman-style gradient boosting, or XGBoost-style training?

This is currently one of the most dangerous sources of reviewer confusion.

The draft mixes:
- multinomial logistic boosting via pseudo-residuals,
- regression-tree training with RSS / mean targets,
- histogram-style split search,
- XGBoost-style implementation motivation.

These are related, but **not identical**.

### Fix:
Add a short subsection that explicitly says which trainer is being proved.

For example:
- if the paper proves **Friedman-style gradient boosting with regression trees on pseudo-residuals**, say exactly that;
- if it only borrows **histogram quantization** from XGBoost, say that explicitly;
- if it does **not** use Hessian-based XGBoost gains / regularization, say so clearly.

Otherwise a reviewer will say:
> “This is not actually proving XGBoost training; it is proving a simplified residual-fitting trainer.”

That criticism is avoidable if the paper is explicit.

Also define:
- tie-breaking rule for equal gains;
- stopping rule when no valid split exists;
- whether tree shape is fixed in advance;
- whether min-child-size / min-gain / regularization exist.

These are not implementation details. They are part of the *statement being proved*.

---

## 3. Strengthen the protocol structure: convert Section 5 from prose into lemmas

Section 5 should not be only a narrative walkthrough. Rewrite it as a sequence of named claims / lemmas.

Suggested structure:

### 5.1 Forest well-formedness
State exactly what it means for `(L, R, E, Θ, N←, N→, tree, Root, score)` to encode a valid forest.

### 5.2 Leaf assignment correctness
State and prove that `ℓ^(t,k)` indeed maps each sample to the unique accepting leaf of the `(t,k)`-th tree.

### 5.3 Leaf histogram correctness
State the exact aggregation relation connecting `(ℓ^(t,k), D, G^(t)[·,k])` to `(C_leaf^(t,k), H_leaf^(t,k))`.

### 5.4 Internal histogram propagation
State the recursive / linear relation that derives `C^(t,k), H^(t,k)` from leaf histograms and routing matrices.

### 5.5 Prefix / total / right-side statistics
State the linear relations producing `C_≤, H_≤, C_Σ, H_Σ, C_>, H_>`.

### 5.6 Candidate split-score correctness
State the zero-safe division / reciprocal relation precisely.

### 5.7 Split optimality
State exactly what is proved about `(E, Θ)`:
- does it prove **one maximizer**?
- the **lexicographically first maximizer**?
- an **arbitrary maximizer**?
- only among **valid splits**?

### 5.8 Leaf value correctness and round closure
State the relation for `n_e, a_e, W_f, S^(t+1)`.

### 5.9 End-to-end round theorem
Combine the above into one round-level correctness theorem.

This will make the protocol feel like a proof system rather than a set of connected ideas.

---

## 4. Add a dedicated subsection on integer embedding, sign, and no-wraparound bounds

This is currently missing and absolutely necessary.

The draft uses:
- fixed-point quantities,
- negative residuals,
- sums over many samples,
- squares of sums,
- divisions / reciprocals,
- softmax-related lookup tables,
- learning-rate updates.

All of these live in a field, but the paper never states the no-wraparound assumptions needed to interpret field arithmetic as integer arithmetic.

### Add a subsection like:
### `Field embedding and range assumptions`

It should specify bounds for:
- `G^(t)[r,k]`,
- histogram sums `H`,
- leaf sums `a_e`,
- counts `C`, `n_e`,
- squared terms such as `(H_≤)^2`,
- updated scores `S^(t)`,
- lookup table domains for `exp` and reciprocal / inverse,
- quantized leaf values and boosted scores.

Then state an explicit proposition:
> Under these bounds, all field operations coincide with the intended signed integer / fixed-point semantics.

Without this, the whole protocol can be attacked as only proving correctness modulo `|F|`.

---

## 5. Fix the undefined semantics around invalid splits and tie handling

This is a major logical gap.

The current text says:
- invalid splits are masked with `χ`,
- zero-safe division sets the score to zero when invalid,
- then `(E, Θ)` selects a maximizing split.

This is underspecified in two ways:

### Problem A: if all splits are invalid
Then every candidate score may be zero.  
How does the protocol distinguish:
- “this node should stop and become a leaf”
from
- “pick an arbitrary invalid split with zero score”?

### Problem B: multiple maximizers
If several `(j,b)` pairs achieve the same maximum, the current constraints only prove the chosen one is a maximizer, not that it matches a deterministic trainer.

### Fix:
You must encode one of the following semantics explicitly:
- **arbitrary maximizing valid split is acceptable**;
- **lexicographically smallest valid maximizer is selected**;
- **the trainer is nondeterministic on ties**;
- **the tree shape is fixed and split selection is constrained only on active internal nodes**.

Similarly, define what happens when a node has no valid split:
- it becomes a leaf;
- its descendants are padding / inactive;
- corresponding rows in `E, Θ, score, W_f` satisfy explicit zero constraints.

Right now this part is not technically closed.

---

## Section-by-section revision instructions

## Section 2 (Preliminaries)

### 2.1 Notation and Polynomial Encoding
Improve precision and reduce future ambiguity.

#### Fixes:
- Define all tensor shapes once in a table.
- Define whether flattening is always row-major over the full tensor or only the last axes.
- When using `Flat(A)`, specify the target length and axis order explicitly.
- Define `tree(u)` notation if you will repeatedly refer to the tree containing node `u`.
- Add an “object glossary” table with columns:
  - symbol
  - shape
  - support (all rows / only internal / only leaves / only one tree)
  - semantic meaning
  - whether committed or virtual

This will significantly improve readability.

### 2.2 Polynomial Commitments
This subsection is too light.

#### Add:
- whether KZG commitments are binding only or also hiding;
- whether the protocol assumes a trusted setup;
- how “virtual polynomials” are opened in practice;
- whether the verifier checks only random evaluations or also degree bounds;
- what PCS interface imported gadgets may assume.

### 2.3 GBDT background
Clarify trainer semantics as discussed above.

#### Also add:
- explicit note that the objective is the paper’s quantized trainer objective;
- exact role of quantization in thresholding and leaf values;
- whether tree depth / structure is public or fixed.

### 2.4 Quantization and fixed point
This subsection currently introduces the idea, but not enough to support the rest.

#### Add:
- exact signed representation convention;
- rounding convention for multiplication / scaling / division;
- whether `exp` values are table-looked-up exactly or approximated;
- how reciprocal / inverse is represented;
- how learning rate `µ` is represented.

### 2.5 What must be proved
This subsection is useful, but it should end with a formal roadmap of lemmas, not just a four-item list.

---

## Section 3 (Technical Overview)

This section is conceptually strong, but currently too repetitive and too abstract in places.

## Main revision goal:
Keep Section 3 intuitive and high-level.  
Move exact symbolic burden into Section 5.

### 3.1 Forest representation and batched inference
Good intuition, but make two things explicit:

1. **orientation of routing matrices**  
   Right now the propagation equations later look circular unless the reader infers that rows of `L, R` point from parent to child and that node ordering is topological.

2. **uniqueness of accepting leaf**
   Say explicitly why the fetched leaf is unique:
   - hyperboxes partition the tree’s domain, or
   - forest well-formedness plus containment proof imply uniqueness.

If you do not prove uniqueness, reviewers may ask whether two leaf rows can both contain the same sample.

### 3.2 Training proof pipeline
This part is good, but the claim

> “the proof size does not grow with the number of boosting rounds”

is too strong as currently written.

#### Rewrite this claim more carefully:
Something like:
- “the number of PCS instances / commitment objects can be kept independent of `T` by stacking rounds along an additional axis,”
- or “the PCS-level opening pattern is independent of `T`, although witness size and prover work still grow with `T`.”

Do **not** leave it in the stronger unqualified form unless you prove a precise theorem about proof size.

### 3.3 Objective rewriting for split search
This section is clean. Keep it.

#### But add:
- one sentence explicitly connecting `(3.2)` to the later tensors `C_≤, H_≤, C_>, H_>`.
- one sentence clarifying that the maximization is only over **valid** splits.

### 3.4 Batching overview
This section overlaps too much with Section 4.

#### Fix:
- keep only intuition and one toy example;
- delete almost all theorem-like prose here;
- reserve formal statements/proofs for Section 4.

Right now Section 3.4 and Section 4 feel duplicative.

---

## Section 4 (Proof-Batching Tools)

This section needs the most technical tightening.

## 4.1 Domain-lifting batching
The core idea is fine, but the theorem needs more exact context.

### Add:
- degree discussion: after lifting, what degree bound must the PCS support?
- explicit statement that `ν_N / ν_n` is a polynomial because `n | N`;
- explicit residual polynomial used in the soundness proof;
- whether `Q(X)` is virtual or prover-supplied.

### Optional strengthening:
Add one short corollary specialized to the way the protocol will actually use it:
- batching routing / padding / tensor-linear identities over one ambient domain.

This would make the later application less handwavy.

## 4.2 Interleaving batching
This is currently the weakest formal section.

### Major issue 1: theorem stated at the wrong level of generality
The theorem is phrased for a pointwise relation of the form `φ(u_i(a)) = 0`, i.e. a predicate on **one value** per location.

But later uses like:
- quantization,
- lookup checks,
- reciprocal checks,
- zero-safe division

typically involve **tuples of witness values** at the same index, not one scalar.

#### Fix:
Generalize the theorem to handle **bundles**:
- each local instance should be a tuple of aligned vectors / columns;
- the local relation should be `φ(u_{i,1}(a), ..., u_{i,c}(a)) = 0`;
- then state how interleaving is applied coordinatewise across the tuple.

Without this, the theorem does not actually cover the later examples cleanly.

### Major issue 2: the complexity claim is too aggressive / under-justified
The statement
- “using two scans... runs in `O(m + log n̂)` time”

is not convincingly justified as written.

The second phase repeatedly takes the two smallest active pairs.  
Unless you specify a concrete bucket / queue data structure and prove the bound, reviewers may reject the complexity claim.

#### Fix:
Either:
- fully specify the bucketed implementation and prove the claim, or
- weaken the claim to something easier to defend, e.g. `O(m log m)` or `O(m log n̂)`.

Do not overclaim here.

### Major issue 3: property (2) proof is currently not rigorous
The derivation of the final size after the first scan is not adequately justified. The proof seems to rely on the binary expansion of the total size, but it does not say that explicitly.

#### Fix:
Rewrite property (2) proof using a binary-expansion argument:
- after merging equal-size pairs greedily, each remaining active size appears at most once;
- hence the multiset of remaining sizes corresponds exactly to the binary representation of `S = Σ_i n_i`;
- therefore the largest remaining size is `2^{⌊log2 S⌋}`;
- after the second phase, the final size becomes the next power of two, i.e. `2^{⌈log2 S⌉}`.

Also fix the notation typo in the displayed equality where the index on `n'_s` is clearly wrong.

### Major issue 4: what exactly is amortized?
Property (3) says any opening of the final virtual polynomial reduces to one opening per original `u_i`.

That is fine mechanically, but it weakens the intuitive claim that interleaving reduces proof size.
Readers may ask:

> if I still need one opening per original polynomial, what did interleaving buy me?

#### Fix:
Be precise:
- interleaving reduces the number of **logical local-check instances** and avoids introducing new committed witness columns;
- it does **not automatically** reduce the number of base PCS openings unless combined with additional batched-opening machinery.

State this honestly. It will make the theorem more credible.

## 4.3 Explicit lookup batching example
Useful, but again currently too informal.

### Improve by:
- stating the collision event explicitly when shifting by `α`;
- explaining whether the tables are disjoint after shift with overwhelming probability or whether this is folded into the lookup protocol’s soundness;
- clarifying whether table entries are field elements or encoded tuples.

---

## Section 5 (Protocol)

This is where the paper most needs concrete instantiation.

## 5.1 Committed forest representation
Good object list, but “the remaining hyperbox equations are the usual ones” is too vague.

### Replace that with explicit constraints:
- booleanity / one-hot constraints for `L, R, E, Root`;
- leaf rows are zero in `L, R, E, Θ`;
- internal rows are zero in `score`;
- parent-child tree-index consistency;
- selected coordinate updates exactly one bound;
- non-selected coordinates are inherited unchanged;
- root boxes are global;
- inactive / padding rows are zeroed.

### Also fix dimensional clarity:
Expressions like
- `Root N← = 0`
- `Root N→ = (B+1)1`
- `Root tree = (0,1,...,TK-1)`

should specify the dimensions of the RHS explicitly.

## 5.2 Batched forest inference
This section needs one more formal statement.

### Add:
- what the query batch `X` is (public? committed? witness?);
- how `ind` is constrained to fetch exactly one row from the correct tree;
- whether `tree_ext` contains only leaf rows;
- why containment plus lookup implies correctness of the selected leaf;
- whether uniqueness must be proved separately.

Also, if inference is used as a subroutine for proving `ℓ^(t,k)`, say that explicitly and reuse the exact same statement later in Section 5.3 instead of speaking loosely about “batched forest inference.”

## 5.3 Round-level training proof
This is the heart of the paper, and it needs the biggest rewrite.

### A. Global boosting-state commitment
Make the global tensor explicit.

Instead of only saying “all score matrices are arranged along one extra round axis,” define:
- `S ∈ F^{(T+1) × M × K}`,
- `G ∈ F^{T × M × K}`,
- `P ∈ F^{T × M × K}`,
- `Z ∈ F^{T × M}`,
- `I ∈ F^{T × M}`,
or whatever exact shapes are intended.

Then say:
- how they are flattened,
- which slices correspond to round `t`,
- which relations are proved slice-wise and which are globally batched.

### B. Pseudo-residual proof
This part currently says exp / inverse are handled by lookup or imported zkML subroutine.

That is too loose.

#### Fix:
Present this as an **interface assumption**:
- the protocol assumes subroutines `Π_exp` and `Π_inv` (or one `Π_softmax`) satisfying certain completeness/soundness/ZK properties;
- the main theorem is parameterized by those subroutines.

Do not simply say “handled by an imported subroutine.”  
That sounds unfinished.

### C. Leaf histogram construction
The address tensor `addr^(t,k)` is introduced, but the actual proof relation is not formally stated.

#### Add a lemma / proposition:
The prover proves that aggregating:
- ones at addresses `addr^(t,k)[r,j]`,
- and residual values `G^(t)[r,k]` at the same addresses,

produces `Flat(C_leaf^(t,k))` and `Flat(H_leaf^(t,k))`.

Right now the address tensor appears, but the actual aggregation claim is missing.

### D. Propagation equations
The equations
- `Flat(C) = Flat(C_leaf) + L Flat(C) + R Flat(C)`
- `Flat(H) = Flat(H_leaf) + L Flat(H) + R Flat(H)`

need one more sentence explaining why they have a unique intended solution.

#### Add:
- the tree ordering is topological / children have larger indices than parents;
- `L + R` is nilpotent on a tree;
- therefore these equations are equivalent to recursive upward accumulation.

Without that, the equations look circular.

### E. Tree-specific support masking
For each `(t,k)`, clarify that histograms are supported only on the nodes of tree `(t,k)` and are zero outside that tree.

This is not explicit enough right now.  
Otherwise `C^(t,k)` and `H^(t,k)` are tensors over all `N_tot` rows but no zero-support condition outside the relevant tree is stated.

### F. Prefix / total statistics
Currently the text just says the prover commits these tensors satisfying prefix and total sum equations.

#### Improve by:
- defining the prefix operator once as a public linear map;
- then say the relation is a linear identity and thus eligible for domain-lifting batching.

This will make the proof path much cleaner.

### G. Zero-safe gain tensor
Equation (5.21) should not be written as if the protocol literally divides inside the field without additional witnesses.

#### Fix:
Rewrite this as an algebraic relation using reciprocal witnesses. For example:
- introduce `Rcp_≤` and `Rcp_>` with masked reciprocal constraints,
- then define `Γ` using multiplication by those witnesses.

Also clearly distinguish:
- integer / fixed-point gain semantics,
- field-level constraint system,
- zero-safe masking condition.

Right now the displayed formula is intuitive, but not proof-system level.

### H. Max-selection
The current constraints prove that the chosen feature/threshold attains the maximum, but they do not yet encode tie-breaking.

Add deterministic tie-breaking if the claimed trainer is deterministic.
If the semantics allow an arbitrary maximizer, say so explicitly.

Also define how max-selection is restricted to **valid** candidate splits.

### I. Leaf values and round closure
Same issue as the gain tensor:
`W_f[u,k] = a_e[u] / n_e[u]` should be rewritten as a reciprocal / masked division relation, not simply displayed as arithmetic quotient.

Also add the support rule:
- internal rows are zero,
- inactive leaves are masked,
- rows not belonging to tree `(t,k)` are zero.

## 5.4 Soundness composition
This subsection currently feels too short for how much it is supposed to justify.

### Add a formal theorem:
Give the final soundness error as a union bound over:
- PCS binding / opening failure,
- lookup / softmax / max-subprotocol errors,
- domain-lifting random-linear-combination error,
- aggregation error,
- interleaving-batched local-check error.

Be explicit about:
- whether challenges are independent,
- whether batching challenges are reused across rounds / relations,
- how many such challenges exist.

Also state whether the proof is argument-of-knowledge, not just sound, if that is what you want to claim.

---

## Appendix A

The appendix is helpful, but it should do more than restate the prose.

## Requested improvements:
- make Algorithm 2 call the exact lemma names / proof obligations from Section 5;
- indicate which steps are linear, which are nonlinear, which are imported, and which are aggregated/batched;
- optionally add a table:
  - relation name
  - involved objects
  - proof gadget
  - batching mode
  - imported vs new

This would be extremely useful for reviewers.

---

## Technical correctness / reviewer-risk checklist

The agent must fix all of the following explicitly:

- [ ] formal statement of the proved relation;
- [ ] explicit public/private/witness split;
- [ ] exact trainer semantics;
- [ ] deterministic handling of ties and invalid splits;
- [ ] active/inactive node semantics and tree shape policy;
- [ ] hiding / zero-knowledge assumptions of the PCS and imported gadgets;
- [ ] no-wraparound / signed fixed-point bounds;
- [ ] precise aggregation statement using addresses;
- [ ] precise reciprocal / zero-safe division constraints;
- [ ] theorem-level end-to-end soundness statement;
- [ ] more honest / precise claim about proof size vs number of rounds;
- [ ] generalization of Theorem 4.4 from scalar local checks to tuple/bundle local checks;
- [ ] corrected proof of Theorem 4.4 property (2);
- [ ] clarified complexity claim for Theorem 4.4;
- [ ] explicit explanation of what interleaving actually amortizes.

---

## Writing problems to fix everywhere

These are not stylistic nitpicks; they are materially hurting technical clarity.

### 1. Too many vague phrases
Reduce phrases like:
- “the usual equations,”
- “standard gadget,”
- “handled by lookup-based nonlinear checks,”
- “the remaining relations are absorbed,”
- “the protocol follows the pattern of [2],”
- “one can prove,”
- “the same idea applies.”

Replace them with either:
- an explicit lemma / equation / interface, or
- a precise imported-subroutine assumption.

### 2. Excess duplication
Section 3 and Sections 4–5 currently repeat each other too much.

Use this rule:
- Section 3 = intuition only;
- Section 4 = general batching theorem(s);
- Section 5 = protocol instantiation only.

### 3. Notation overload without object summary
Add a summary table of symbols and shapes.  
This one change will improve the paper a lot.

### 4. Dimension / support ambiguity
Every time an object is introduced, specify:
- shape,
- support,
- whether it is committed or virtual,
- whether it is global or per-round/per-class.

### 5. Overclaiming novelty / succinctness
Tone down claims unless they are precisely justified.
For example, avoid:
- “proof size does not grow with T”
unless this is rigorously proved under all imported subprotocols.

Prefer:
- “the PCS-level opening pattern is independent of T”
or similarly precise language.

### 6. The technical prose should become more theorem-driven
Right now the paper often says what the prover “does.”  
Instead, it should more often say what relation is proved and then how.

---

## Suggested rewrite order for the agent

1. Add a formal statement / theorem subsection.
2. Add an object glossary table.
3. Rewrite Section 5 into lemma-style protocol components.
4. Add fixed-point / no-wraparound subsection.
5. Repair Section 4.2 theorem statement and proof.
6. Clarify trainer semantics, tie-breaking, and invalid-split policy.
7. Reduce duplication between Sections 3 and 4 / 5.
8. Rewrite soundness composition as a real theorem.
9. Update Appendix A so it mirrors the final protocol structure.

---

## One-sentence bottom line

The paper already has a publishable *core idea*, but the technical section must be rewritten so that every claimed proof step is either:
- explicitly formalized,
- clearly delegated to a named imported subprotocol with stated guarantees,
- or removed from the main claim.

At present, too many crucial steps are still described only at the level of architecture.
