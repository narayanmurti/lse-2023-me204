#### SETUP ####
df <- read.csv("Dec_lsoa_grocery.csv")
View(df)

#### FILTER ####

#LSE zone
a <- df[df['area_id'] == 'E01004735',]

View(a)


#select columns
selected_cols <- c("area_id", "fat", "saturate", "salt", "protein", "sugar", 
                   "carb", "fibre", "alcohol", "population", "male", "female",
                   "age_0_17", "age_18_64", "avg_age", "area_sq_km",
                   "people_per_sq_km")
df <- df[selected_cols]
View(df)


#### Q1 ####

#order by alc, decreasing
ordered_by_alc <- df[order(df$alcohol, decreasing = TRUE),]
#slice the top three
top_three_alc <- ordered_by_alc[1:3, ]
#slice the bottom three using the length of the df
bottom_three_alc <- ordered_by_alc[(length(ordered_by_alc) - 2):length(ordered_by_alc), ]
#reorder bottom three so that lowest is first
bottom_three_alc <- bottom_three_alc[order(bottom_three_alc$alcohol),]

top_three_alc_areas <- top_three_alc['area_id']
print(top_three_alc_areas)

bottom_three_alc_areas <- bottom_three_alc['area_id']
print(bottom_three_alc_areas)


#### population ####



#first col
population_avg <- mean(df[, 'population'])

#second col
population_sd <- sd(df[, 'population'])

#create df
population_summary <- data.frame(population_avg, population_sd)

#### plot ####
plot(df$fat, df$sugar, cex=0.5, main = 'Fat vs Carbs', xlab = 'Fat', ylab = 'Sugar', pch = 3)
