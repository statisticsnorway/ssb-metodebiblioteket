#Note that some tests are taken from the package own tests, see citation

# markvanderloo (2023). data-cleaning
# [R package]. GitHub. 
# https://github.com/data-cleaning/validate/blob/master/pkg/inst/tinytest/test_validator.R
# commit f76654d


#### validator ####
rules <- validator(speed >= 0
                   , dist >= 0
                   , speed/dist <= 1.5
                   , cor(speed, dist)>=0.2)

rule <- validator(
  !is.na(turnover)
  , !is.na(other.rev)
  , !is.na(profit)
)
out <- confront(SBS2000, rule)
summary(out)

rules <- validator( 
  !any(is.na(incl.prob))
  , all(is.na(vat)) )
out <- confront(SBS2000, rules)
summary(out)

rules <- validator(
  nchar(as.character(size)) >= 2
  , field_length(id, n=5)
  , field_length(size, min=2, max=3)
)
out <- confront(SBS2000, rules)
summary(out)

#### confront ####

#Note that some tests are taken from the package own tests

# markvanderloo (2023). data-cleaning
# [R package]. GitHub. 
# https://github.com/data-cleaning/validate/commits/master/pkg/inst/tinytest/test_confrontation.R
# commit 3574d40
