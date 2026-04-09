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

## VS Code SyncTeX (Forward/Inverse Search)

This project includes workspace settings in `.vscode/settings.json` and
`.latexmkrc` to always generate SyncTeX metadata.

For the built-in VS Code PDF viewer:

1. Install the VS Code extension `LaTeX Workshop`.
2. Build from VS Code (or run `latexmk -pdf main.tex`) and confirm
	`main.synctex.gz` is generated in the project root.
3. Open the PDF with `LaTeX Workshop: View LaTeX PDF file`.
4. Use reverse search with a double click in the PDF viewer.

If inverse search (PDF -> source) is still not working on macOS with Skim:

1. Install the VS Code extension `LaTeX Workshop`.
2. Build from VS Code (or run `latexmk -pdf main.tex`) and confirm
	`main.synctex.gz` is generated in the project root.
3. If you use Skim as external viewer, set Skim inverse search command:
	- In Skim, open `Settings -> Sync`.
	- Preset: `Custom`.
	- Command: `code`.
	- Arguments:
	  - `-g`
	  - `%file:%line`
4. In VS Code command palette, run `LaTeX Workshop: View LaTeX PDF file`
	and test both directions:
	- Source -> PDF: `LaTeX Workshop: SyncTeX from cursor`.
	- PDF -> Source: double click in the built-in PDF viewer, or
	  `Shift + Command + Click` in Skim after the Sync setup above.

If you installed the `code` command recently, run VS Code command palette
`Shell Command: Install 'code' command in PATH` once, then restart Skim.
