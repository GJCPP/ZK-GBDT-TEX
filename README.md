# ZK-GBDT TeX Project

This repository now contains a minimal LaTeX paper scaffold for writing a
paper on zero-knowledge gradient boosted decision trees.

## Structure

- `main.tex`: paper entry point
- `sections/`: section files split by topic
- `bibliography/references.bib`: BibTeX database
- `figures/`: figures and diagrams
- `tables/`: table assets or generated inputs

## Build

If you have a LaTeX toolchain installed, a typical local build is:

```powershell
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

If you use `latexmk`, this is simpler:

```powershell
latexmk -pdf main.tex
```
