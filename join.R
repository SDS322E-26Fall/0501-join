library(tidyverse)
library(nycflights13)

##################################################################
# the flight data
flights

flights_tiny <- flights |>
  select(month:day, hour, origin, dest, tailnum, carrier) |>
  head(5)
flights_tiny

flights_sml <- flights |>
  select(month:day, hour, origin, dest, tailnum, carrier) |>
  head(30)
flights_sml

# the airport data
airport

airports_origin <- airports |> filter(faa %in% c("JFK", "EWR", "LGA"))
airports_origin

airports_dest <- airports |> filter(faa %in% flights_tiny$dest)
airports_dest


##################################################################
# left join flights_tiny with airport_origin
flights_tiny |> left_join(airports_origin, by = c("origin" = "faa"))


# left join flights_tiny with airport_dest - what do you see?
flights_tiny |> left_join(airports_dest, by = c("dest" = "faa"))


# how would you deal with the missingness from the join?
# option 1: exclude the BQN airport
flights_tiny |> filter(dest != "BQN") |>
  left_join(airports, by = c("dest" = "faa"))


# Option 2: find the Puerto Rico airport information to the `airports` data.
bqn_tbl <- tibble(faa = "BQN", name = "Rafael Hernández Airport",
       lat = 18.4944, lon = -67.1296, alt = 49, tz = -4,
       dst = "A", tzone = "America/Puerto_Rico")
all_airports <- airports |> bind_rows(bqn_tbl)

flights_tiny |> left_join(all_airports, by = c("dest" = "faa"))


#####################################################################
# Your time - pipe
# Without running the code, guess whether the following code will work.

# Question 1
flights |> select(month)
# Question 2
month |> select(flights)
# Question 3
flights |> unique(dep_delay)

# Question 4
flights$dep_delay |> unique()



#####################################################################
# Your time - join
# Connect the `flights_sml` data with the airport information by the destination airport.

# * What do you observe when you check the joined data?
# * How would you fix it?
# * Think about what can you do with this joined data

flights_sml <- flights |>
  select(month:day, hour, origin, dest, tailnum, carrier) |>
  head(30)






#####################################################################
#####################################################################
# Application 1a

flights |>
  # we looked in the air_time vs. distance plot
  # before the there are long flights
  # thqt go to HNL (Hawaii)
  filter(dest != "HNL") |>
  filter(carrier %in% c("AA", "DL", "UA")) |>
  ggplot(aes(x = air_time)) +
  geom_histogram(binwidth = 10)  +
  facet_wrap(vars(carrier), ncol = 1)

#####################################################################
# Your time
# Create a copy of the above code and modify the code
# to use the full carrier name rather than abbreviation





#####################################################################
#####################################################################
# Application 1b
our_carriers = c("AA", "DL", "WN", "MQ", "UA", "9E")
flights |>
  filter(dest != "HNL") |>
  filter(carrier %in% our_carriers) |>
  ggplot(aes(x = air_time)) +
  geom_histogram(binwidth = 10)  +
  facet_wrap(vars(carrier), ncol = 1)


#####################################################################
# Your time
# Create a copy of the above code and modify the code to
# 1. use the full carrier name rather than abbreviation
# 2. use a free scale for the y-axis
# 3. reorder the facets by the median air_time (hint: use `fct_reorder` function)








#####################################################################
