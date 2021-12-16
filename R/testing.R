# Create posts and testing

#### Create posts ####
source("R/create_bib.R")
create_bib("ProtectTable", package = "easySdcTable", 
           url = "https://github.com/statisticsnorway/easySdcTable/blob/master/R/ProtectTable.R")

create_bib("PLSrounding", package = "SmallCountRounding",
           'https://github.com/statisticsnorway/SmallCountRounding/blob/master/R/PLSrounding.R')

create_bib("ProtectKostra", package = "Kostra",
           labels = c("R", "confidentiality"),
           'https://github.com/statisticsnorway/Kostra/blob/main/R/ProtectKostra.R')


#### TEST Rd2md ####
library(Rd2md)
db <- tools::Rd_db("Kostra")["LmImpute.Rd"]
save(db, file = "test.Rd")
outfile = "test.md"
Rd2markdown(rdfile = "test.Rd", outfile = outfile)

Rd2md:::RdTags(db)
## give a markdown source file
rdfile = "~/git/MyPackage/man/myfun.Rd"
## specify, where markdown shall be stored
outfile = "/var/www/html/R_Web_app/md/myfun.md"
## create markdown
## Rd2markdown(rdfile = rdfile, outfile = outfile)





#### TESTING ####
library(distill)
rename_post_dir("_posts/2021-11-24-calibratessb", date_prefix = NULL) 
rename_post_dir("_posts/2021-11-24-lmimpute", date_prefix = NULL) 

check_bullet <- function(txt){
  txt <- trimws(txt)
  txt <- substr(txt, 1, 1)
  txt %in% c("-", "•")
}

source("R/create_bib.R")
create_bib("ProtectTable", package = "easySdcTable", 
           url = "https://github.com/statisticsnorway/easySdcTable/blob/master/R/ProtectTable.R")

package = "easySdcTable"
title = "ProtectTable"
get_description(package, title)

get_value('easySdcTable', 'ProtectTable')

####
db <- Rd_db(package)
params <- lapply(db, tools:::.Rd_get_metadata, "arguments")[paste0(title, ".Rd")]
out <- paste(unlist(params),collapse="")


#
x <- c("Peter: Parker", "Hawk & Dove", "J Jonah Jameson", "3JPX spo", "Bruce", "    Hi")
x <- trimws(x)
x <- word(x, 1)
x <- substr(x, nchar(x), nchar(x))
x
gsub("\\s+(\\S)\\S*(?!\\S)","\\2", x, perl=TRUE)
output <- gsub("\\s+(\\S)\\S*(?!\\S)", "\\1", x, perl=TRUE)
output

substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
library(stringr)



########
#package = "Kostra"
#func = "LmImpute"
tools:::Rdo_collect_metadata(myrd, "methods")

Rd_get_metadata <- tools:::.Rd_get_metadata
Rd_contents <- tools:::Rd_contents
Rd_get_example_code <- tools:::.Rd_get_example_code
Rd_get_section <- tools:::.Rd_get_section
Rd_get_text <- tools:::.Rd_get_tex

Rd_get_metadata(myrd, 'author')
RdTags(txt)
tools:::prepare_Rd(myrd)
tools::checkRd(myrd)

db = Rd_db(package)
myrd <- db$ProtectTable.Rd
Rd_contents(toRd(myrd))

db <- Rd_db("Kostra")
keywords <- lapply(db, tools:::.Rd_get_metadata, "keyword")

kw_table <- sort(table(unlist(keywords)))
rev(kw_table)[1 : 5]

lapply(db$KostraData.Rd, tools:::.Rd_get_metadata, "authors")
tools:::parse_Rd(db)


library(tools)
db <- Rd_db("Kostra")
grep("ProtectTable.Rd", names(db), value = TRUE)
db[grep("ProtectTable.Rd", names(db))]


lapply(db, tools:::.Rd_get_metadata, "usage")$ProtectTable.Rd
lapply(db, tools:::.Rd_get_metadata, "value")$ProtectTable.Rd
lapply(db, tools:::.Rd_get_metadata, "code")$ProtectTable.Rd
args <- lapply(db, tools:::.Rd_get_metadata, "arguments")$ProtectTable.Rd
out <- paste(unlist(x[which(tags=="\\author")]),collapse="")
unlist(out)

args() <- lapply(db,function(x) {
  tags <- tools:::RdTags(x)
  if("\\arguments" %in% tags){
    # return a crazy list of results
    #out <- x[which(tmp=="\\author")]
    # return something a little cleaner
    out <- paste(unlist(x[which(tags=="\\arguments")]),collapse="")
  }
  else
    out <- NULL
  invisible(out)
})
args()$ProtectTable.Rd

lapply(db, tools:::.Rd_get_metadata, "examples")$ProtectTable.Rd
lapply(db, tools:::.Rd_get_metadata, "note")$ProtectTable.Rd
lapply(db, tools:::.Rd_get_metadata, "details")$ProtectTable.Rd
lapply(db, tools:::.Rd_get_metadata, "details")["ProtectTable.Rd"]