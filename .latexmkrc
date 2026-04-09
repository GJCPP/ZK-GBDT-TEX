# Ensure SyncTeX is always generated, including terminal builds.
$pdf_mode = 1;
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
