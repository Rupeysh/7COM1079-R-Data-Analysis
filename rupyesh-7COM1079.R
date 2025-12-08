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


# 3. STATISTICAL ANALYSIS
## Data set Summary Statistic
print(summary(hotel))


## Summary of reviews
summary(hotel_clean$Reviews)


# Correlation between Reviews and Rating
cor_test <- cor.test(hotel_clean$Reviews, hotel_clean$Rating)
print(cor_test)


# CONTINGENCY TABLE (Comparison of Proportions for Review Groups)
# Create two-level Review Group for proportions test
hotel_clean$Review_Group <- ifelse(hotel_clean$Reviews >= 500, "High", "Low")


# Create a second categorical variable: High Rating (Yes/No)
hotel_clean$Rating_Flag <- ifelse(hotel_clean$Rating >= 4, "High_Rating", "Low_Rating")


# Contingency table
cont_table <- table(hotel_clean$Review_Group, hotel_clean$Rating_Flag)
print(cont_table)


# STATISTICAL TEST FOR PROPORTIONS (Chi-Square Test)
chi_test <- chisq.test(cont_table)
print(chi_test)


# 4. VISUALISATION
# Scatter plot: Reviews vs Rating
plot1 <- ggplot(hotel_clean, aes(x = Reviews, y = Rating)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Relationship Between Hotel Reviews and Rating",
    x = "Number of Reviews",
    y = "Rating"
  )
print(plot1)


# Histogram of review counts
plot2 <- ggplot(hotel_clean, aes(x = Reviews)) +
  geom_histogram(bins = 30, fill = "steelblue", alpha = 0.7) +
  labs(
    title = "Distribution of Hotel Reviews",
    x = "Reviews",
    y = "Count of Hotels"
  )
print(plot2)


# Boxplot: Review group vs Rating
plot3 <- ggplot(hotel_clean, aes(x = Review_Group, y = Rating, fill = Review_Group)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Rating Distribution by Review Category",
    x = "Review Category",
    y = "Rating"
  )
print(plot3)


# Top 10 Most Reviewed Hotels (Bar Plot)
top10_reviews <- hotel_clean %>%
  arrange(desc(Reviews)) %>%
  head(10)

ggplot(top10_reviews, aes(x = reorder(Hotel_Name, Reviews), y = Reviews)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Top 10 Most Reviewed Hotels",
    x = "Hotel Name",
    y = "Number of Reviews"
  )


# Review Distribution by Star Rating (Boxplot)
ggplot(hotel_clean, aes(x = as.factor(Star_Rating), y = Reviews, fill = as.factor(Star_Rating))) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Review Distribution Across Hotel Star Ratings",
    x = "Star Rating",
    y = "Number of Reviews"
  ) +
  theme(legend.position = "none")


# Distribution of Ratings (Histogram)
ggplot(hotel_clean, aes(x = Rating)) +
  geom_histogram(bins = 20, fill = "darkblue", alpha = 0.7) +
  labs(
    title = "Hotel Rating Distribution",
    x = "Rating",
    y = "Frequency"
  )
