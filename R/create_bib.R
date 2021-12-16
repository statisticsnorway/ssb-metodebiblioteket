source("R/auto_test.R")
create_bib <- function (title, 
                        package,
                        labels = "R",
                        url = NULL,
                        collection = "posts", 
                        author = "auto", 
          slug = "auto", date = Sys.Date(), date_prefix = NULL, 
          draft = FALSE, edit = interactive()) 
{
  site_dir <- distill:::find_site_dir(".")
  if (is.null(site_dir)) 
    stop("You must call create_post from within a Distill website")
  site_config <- rmarkdown::site_config(site_dir)
  posts_dir <- file.path(site_dir, paste0("_", collection))
  posts_index <- file.path(site_dir, site_config$output_dir, 
                           collection, paste0(collection, ".json"))
  slug <- distill:::resolve_slug(title, slug)
  post_dir <- distill:::resolve_post_dir(posts_dir, slug, date_prefix)
  if (identical(author, "auto")) {
    author <- NULL
    if (file.exists(posts_index)) 
      posts <- jsonlite::read_json(posts_index)
    else posts <- list()
    if (length(posts) > 0) 
      author <- list(author = posts[[1]]$author)
  }
  if (is.null(author)) {
    author <- list(author = list(list(name = fullname(fallback = "Unknown"))))
  }
  else if (is.character(author)) {
    author <- list(author = author)
  }
  ## new part
  source("R/auto_test.R")
  descript <- get_description(package, title)
  descript <- gsub("''", "'", descript)
  db <- Rd_db(package)
  details <- lapply(db, tools:::.Rd_get_metadata, "details")[paste0(title, ".Rd")]
  #params <- lapply(db, tools:::.Rd_get_metadata, "arguments")[paste0(title, ".Rd")]
  
  #params <- paste(unlist(params),collapse="")
  
  #params <- lapply(db,function(x) {
  #  tags <- tools:::RdTags(x)
  #  if("\\arguments" %in% tags){
      # return a crazy list of results
      #out <- x[which(tmp=="\\author")]
      # return something a little cleaner
  #    out <- paste(unlist(x[which(tags=="\\arguments")]),collapse="")
  #  }
   # else
   #   out <- NULL
   # invisible(out)
  #})
  #params <- params$ProtectTable.Rd
  #params <- gsub("\n","", unlist(params)) # further cleanup
  params <- sprintf("```{r, echo = FALSE}\nlibrary(knitr)\nsource('../../R/auto_test.r')\ndt <- get_parameters(\'%s\', \'%s\')\nkable(dt)\n```",
                     package, title)
  
  values <- sprintf("```{r, echo = FALSE}\nlibrary(knitr)\nsource('../../R/auto_test.r')
                    \n\ndt_val <- get_value(\'%s\', \'%s\')\n\n```\n`r dt_val$text`\n\n```{r, echo = FALSE}\nif(nrow(dt_val$dt)>0) kable(dt_val$dt)\n```\n",
                    package, title)
  
  examples <- sprintf("```{r, echo = F, comment = '', class.output='kodebox'}\nprint_examples(\'%s\', \'%s\')\n```", 
                      package, title)
  
  categors <- paste0("  - ",labels,"\n", collapse="")

  pack_version <- packageVersion(package)
  
  if (!is.null(url)){
    url_button <- sprintf("<div><span class='highlight'>[Go to source code](%s) </span></div>", url)
  } else {
    url_button <-""
  }
  
  author = paste0("author:\n  - name: ", package, "\n    affiliation: ",pack_version, "\n")
  ##
  #author <- yaml::as.yaml(author, indent.mapping.sequence = TRUE)
  if (draft) 
    draft <- "\ndraft: true"
  else draft <- ""
  
  yaml <- sprintf("---\ntitle: \"%s\"\ndescription: |\n %s\n%sdate: %s\noutput:\n  distill::distill_article:\n    self_contained: false\n    toc: true\n    toc_depth: 3%s\ncategories:\n%s---", 
                  title, descript, author, format.Date(date, "%F"), draft, categors)
  body <- sprintf("\n\n%s\n\n## Parameters\n%s\n## Values\n%s\n## Examples\n%s\n", 
                  url_button, params, values, examples)
        
  if (distill:::dir_exists(post_dir)) 
    stop("Post directory '", post_dir, "' already exists.", 
         call. = FALSE)
  dir.create(post_dir, recursive = TRUE)
  post_file <- file.path(post_dir, distill:::file_with_ext(slug, "Rmd"))
  con <- file(post_file, open = "w", encoding = "UTF-8")
  on.exit(close(con), add = TRUE)
  xfun::write_utf8(yaml, con)
  xfun::write_utf8(body, con)
  bullet <- "v"
  circle <- "o"
  new_collection <- !(collection %in% names(distill:::site_collections(site_dir, 
                                                             site_config)))
  if (new_collection) {
    cat(paste0(bullet, " Created new collection at _", 
               collection), "\n")
  }
  cat(paste(bullet, "Created post at", paste0("_", 
                                              collection, "/", basename(post_dir))), "\n")
  if (new_collection) {
    cat(paste0(circle, " ", "TODO: Register '", 
               collection, "' collection in _site.yml\n"))
    cat(paste0(circle, " ", "TODO: Create listing page for '", 
               collection, "' collection\n\n"))
    cat("See docs at https://rstudio.github.io/distill/blog.html#creating-a-collection")
  }
  if (edit) 
    distill:::edit_file(post_file)
  invisible(post_file)
}




