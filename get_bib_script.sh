
#!/bin/bash

cd OneDrive\ -\ University\ of\ Illinois\ -\ Urbana/Research/Projects/Third\ Year\ Paper/LaTeX/ThirdRevision


curl https://paperpile.com/eb/dPGWvOFKna -o citationsv3.bib -L

rm -rf `biber --cache`
