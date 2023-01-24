
\#!/bin/bash

cd OneDrive\ -\ University\ of\ Illinois\ -\ Urbana/Research/Writing/git/Slavery\ in\ Brazil/


curl https://paperpile.com/eb/RRFZCXkhDG -o citations_slavery_brazil.bib -L

rm -rf `biber --cache`
