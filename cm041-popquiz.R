# cm 4.2

library(tidyverse)

pvals <- tribble(
  ~statement, ~true_false,
  "A non-significant p-value means that the null hypothesis is true.", FALSE,
  "A significant p-value means that the null hypothesis is false.", FALSE,
  "The p-value is the probability of getting a result as or more extreme than the one observed if the null hypothesis were true.", TRUE, 
  "If p = .05, the null hypothesis has only a 5% chance of being true.", FALSE,
  "The p-value tells you the probability that the result you observed was due to chance.", FALSE,
  "If p < .05, the chances that your results are accurate is > 95%.", FALSE,
  "If p > .05, the chances are greater than 1 in 20 that difference would be found again if the study were repeated.", FALSE,
  "If p > .05, the probability is less than 1 in 20 that a difference this large could occur by chance alone.", FALSE,
  "If p > .05, the probability is greater than 1 in 20 that a difference this large or larger could occur by chance alone.", TRUE
)

create_pvals_quiz <- function(n_statements){
  ind_quiz <- pvals %>% 
  group_by(true_false) %>% 
  sample_n(n_statements, replace = FALSE) %>% 
  arrange(statement) %>% 
  select(-true_false)
  return(ind_quiz)
}

create_pvals_quiz(2)

pvals_quiz_students <- map_dfr(.x = 2, .f = ~create_pvals_quiz(.))

confs <- tribble(
  ~statement, ~true_false,
  "95% of all samples will give an average height between 67.9 and 68.3 inches.", FALSE,
  "There is a 95% chance that the true mean is between 67.9 and 68.3 inches.", FALSE,
  "We are 95% confident that the population mean height of children (in this age range) is between 67.9 and 68.3 inches.", TRUE,
  "There is only a 0% or a 100% chance of the interval 67.9 to 68.3 inches containing the true population mean.", TRUE
)