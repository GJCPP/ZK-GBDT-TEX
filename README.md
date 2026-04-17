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

For VS Code/Cursor with SumatraPDF on Windows:

1. Install the VS Code extension `LaTeX Workshop`.
2. Build from VS Code (or run `latexmk -pdf main.tex`) and confirm
	`main.synctex.gz` is generated in the project root.
3. Open the PDF with `LaTeX Workshop: View LaTeX PDF file`. The workspace
	settings open `main.pdf` in SumatraPDF and pass it a working inverse-search
	command.
4. Use reverse search with a double click in SumatraPDF.

If inverse search (PDF -> source) is still not working with SumatraPDF:

1. In SumatraPDF, open `Settings -> Options`.
2. Set the inverse-search command to:
	`"C:\Users\11768\AppData\Local\Programs\Microsoft VS Code\bin\code.cmd" -r -g "%f:%l"`
3. In VS Code command palette, run `LaTeX Workshop: View LaTeX PDF file`
	and test both directions:
	- Source -> PDF: `LaTeX Workshop: SyncTeX from cursor`.
	- PDF -> Source: double click in SumatraPDF.
