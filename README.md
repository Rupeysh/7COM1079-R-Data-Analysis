# 7COM1079-R-Data-Analysis
This analysis examines how customer review volume influences hotel ratings and pricing in Hyderabad. Using visualisations and correlation testing, the study finds weak, non-significant relationships, showing that review counts do not strongly predict hotel ratings or pricing behaviour.

The code loads the hotel dataset and prepares it for analysis. It first reads the CSV file and checks its structure. Then, the column names are renamed to make them easier to understand. Some columns—like reviews, rating, and price—are converted into numeric values so calculations can be done correctly.
The code removes any rows that are missing review or rating data to keep the dataset clean. Finally, it creates a new category called Review_Group, which labels hotels as Highly Reviewed, Moderately Reviewed, or Low Reviews based on how many customer reviews they received.
