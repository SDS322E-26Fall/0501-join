library(tidyverse)
library(nycflights13)

#####################################################################
# Your time - join

# Which two datasets in `nycflights13` are relevant if we would like to 
# plot all the destination on a map? How would you join them?

#Is every row joined properly? If not, can you find all of them and 
# decide what you want to do next?  








# If you find working with the full flights data is too challenging,
# you can start from the small subset below and then generalize it to the full `flights` data

flights_sml <- flights |>
  select(month:day, hour, origin, dest, tailnum, carrier) |>
  head(30)


