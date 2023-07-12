#### SETUP ####
library(tidyverse)

#### FILTER ####
df <- read_csv("Dec_lsoa_grocery.csv")

df <- select(df, c("area_id", "fat", "saturate", "salt", "protein", "sugar", 
                   "carb", "fibre", "alcohol", "population", "male", "female",
                   "age_0_17", "age_18_64", "avg_age", "area_sq_km",
                   "people_per_sq_km"))


#### Q1 ####
#oeder by alc, descending
ordered_by_alc <- arrange(df, desc(alcohol))
#slice top three alc
top_three_alc <- slice(ordered_by_alc, 1:3)
#slice bottom three alc, using length of df
bottom_three_alc <- slice(ordered_by_alc, (length(ordered_by_alc)-2):length(ordered_by_alc))
#reorder bottom three so that lowest is first
bottom_three_alc <- arrange(bottom_three_alc, alcohol)

bottom_three_alc_areas <- select(bottom_three_alc, 'area_id')
print(bottom_three_alc_areas)

top_three_alc_areas <- select(top_three_alc, 'area_id')
print(top_three_alc_areas)


#### population ####
population_summary <- df %>% summarize(population_avg = mean(population), population_sd = sd(population))


#### plot ####
ggplot(df, aes(x = df$fat, y=df$sugar)) +
  geom_point()
