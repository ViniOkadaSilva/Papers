
#!/bin/bash

cd OneDrive\ -\ University\ of\ Illinois\ -\ Urbana/Research/Writing/git/Teen\ Marriage\ and\ Domestic\ Violence/


curl https://paperpile.com/eb/OmEIiJkfEK -o citations_marriage.bib -L

rm -rf `biber --cache`
