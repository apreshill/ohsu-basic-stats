# extract nhanes data

library(RNHANES)
library(tidyverse)

# this takes forever
files <- nhanes_data_files()
variables <- nhanes_variables()

files %>% 
  count(component)

files %>% 
  count(component, cycle) %>% 
  filter(cycle == "2015-2016") 

last_exam_vars <- variables %>% 
  filter(component == "examination" & cycle == "2015-2016") %>% 
  filter(data_file_name %in% c("BMX_I", "BPX_I"))

nhanes_search(files, "", component == "examination", cycle == "2015-2016")
nhanes_search(variables, "", component == "examination", cycle == "2015-2016",
              data_file_name == "BMX_I")
nhanes_search(variables, "", component == "examination", cycle == "2015-2016",
              data_file_name == "BPX_I")

my_bmi <- nhanes_load_data("BMX", year = "2015-2016")