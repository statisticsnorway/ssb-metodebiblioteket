The website is rebuilt automatically when a new merge is made into the master branch. 

The status page is "frozen" and isn't rebuilt. A new status page can be re-run by first running the GitHub scraping in file `internal/run_scraping`.  

The status page can then be updated locally using:
```
quarto render status.qmd
```
New files from the rendering are in the _freeze/status folder and can then be added to GitHub to update this file.