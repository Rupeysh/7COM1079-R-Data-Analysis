# Load libraries
library(dplyr)
library(ggplot2)


# 1. READ DATASET
hotel <- read.csv("D:/SoftwareP/hyderabad.csv", stringsAsFactors = FALSE)
## View structure
str(hotel)


# 2. CLEAN DATASET
## Rename columns
colnames(hotel) <- c("Hotel_Name","Rating","Rating_Description","Reviews",
                     "Star_Rating","Location","Nearest_Landmark","Distance",
                     "Price","Tax")


## Convert to correct formats
hotel$Reviews <- as.numeric(hotel$Reviews)
hotel$Rating <- as.numeric(hotel$Rating)
hotel$Price <- as.numeric(hotel$Price)


## Remove missing values for review-based analysis
hotel_clean <- hotel %>%
  filter(!is.na(Reviews), !is.na(Rating))


## Create review category
hotel_clean <- hotel_clean %>%
  mutate(Review_Group = case_when(
    Reviews >= 1000 ~ "Highly Reviewed",
    Reviews >= 200  ~ "Moderately Reviewed",
    TRUE ~ "Low Reviews"
  ))
