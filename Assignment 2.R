#Name: Ahmed Wali Azeemi
#CWID:20332545

#Okay, So I did Feature Engineering – Volatility

#Pivot Table – Monthly summary

#ggplot Visualization – Line chart

#Recode – High/Low Volume

#Binning – Closing Price categories

#Grep – Filter dates

#Join – Sector data

#Correlation Matrix

#Linear Regression + p-values
#__________________________________________________________________________


install.packages("tidyverse")
install.packages("lubridate")
install.packages("ggplot2")

library(tidyverse)
library(lubridate)
library(ggplot2)

jpm <- read_csv("JPMorgan_cleaned.csv")


glimpse(jpm)

jpm$date <- ymd(jpm$date_chr)
jpm$Month <- format(jpm$date, "%Y-%m")

jpm <- jpm %>%
  mutate(
    volatility = JPM.High - JPM.Low,
    volatility_percent = (volatility / JPM.Low) * 100
  )

#Monthly Summary (Pivot Table)   
pivot_table <- jpm %>%
  group_by(Month) %>%
  summarise(
    Average_Close = mean(JPM.Close, na.rm = TRUE),
    Total_Volume = sum(JPM.Volume_num, na.rm = TRUE),
    Avg_Volatility = mean(volatility, na.rm = TRUE)
  )

pivot_table
    
View(pivot_table)


#JPM Closing Price Over Time
ggplot(jpm, aes(x = date, y = JPM.Close)) +
  geom_line(color = "steelblue") +
  labs(title = "JPM Closing Price Over Time", 
       x = "Date", 
       y = "Closing Price") +
  theme_minimal()


#Monthly Average Close Price
ggplot(pivot_table, aes(x = as.Date(paste0(Month, "-01")), y = Average_Close)) +
  geom_line(color = "steelblue", size = 1) +
  labs(title = "Monthly Average Close Price (JPM)",
       x = "Month",
       y = "Average Close Price") +
  theme_minimal()


#Monthly Trading Volume
ggplot(pivot_table, aes(x = as.Date(paste0(Month, "-01")), y = Total_Volume)) +
  geom_col(fill = "darkgreen") +
  labs(title = "Monthly Total Trading Volume (JPM)",
       x = "Month",
       y = "Total Volume Traded") +
  theme_minimal()




jpm <- jpm %>%
  mutate(volume_category = ifelse(JPM.Volume_num > mean(JPM.Volume_num, na.rm = TRUE), "High", 
                                  "Low"))

jpm <- jpm %>%
  mutate(close_bin = cut(JPM.Close, breaks = 4, labels = c("Low", "Medium", "High", "Very High")))

jpm_2020 <- jpm %>%
  filter(grepl("^2020", Month))

sectors <- data.frame(
  Month = unique(jpm$Month),
  Sector = sample(c("Finance", "Tech"), length(unique(jpm$Month)), replace = TRUE)
)

jpm <- left_join(jpm, sectors, by = "Month")

numeric_data <- jpm %>%
  select(JPM.Open, JPM.High, JPM.Low, JPM.Close, JPM.Volume_num, volatility, volatility_percent)

cor_matrix <- cor(numeric_data, use = "complete.obs")
print(cor_matrix)

model <- lm(JPM.Close ~ JPM.Open + JPM.High + JPM.Low + JPM.Volume_num + 
              volatility_percent, data = jpm)
summary(model)

View(jpm)
head(jpm)
jpm %>% select(date, JPM.High, JPM.Low, volatility, volatility_percent,
               Month, volume_category, close_bin) %>% head()

ggplot(jpm, aes(x = volatility, y = JPM.Close)) +
  geom_point(color = "tomato", alpha = 0.6) +
  labs(title = "Scatter Plot: Volatility vs Close Price",
       x = "Volatility (High - Low)",
       y = "Closing Price") +
  theme_minimal()

write.csv(jpm,file = "JPMassignment3.csv")
#____________________________________________________________________________________________


#Explanation: 
  #As you said to bring new variable, I used daily volatility and volatility percent, As my new variables

#I used variables like daily volatility and volatility percent to measure market fluctuations, 
#finding moderate volatility and stable daily price movements. Monthly averages showed an upward 
#trend in closing prices, with volume spikes indicating significant trading events. 
#Visuals revealed a strong positive relationship between opening and closing prices, 
#confirmed by a high correlation in the matrix. Linear regression indicated that JPM.Open 
#was a significant predictor for JPM.Close, while volume and volatility had minimal impact.
#The data showed strong, stable trends, making it suitable for forecasting and modeling.



