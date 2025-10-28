#Ahmed Wali Azeemi
#20332545

library(readr)
JPM_data <- read_csv("JPMorganData.csv")
str(JPM_data)

library(dplyr)
str(JPM_data)

JPM_data %>%
  filter(JPM.Close > 150)

View(JPM_data)
JPM_data %>%
  select(date, JPM.Open, JPM.Close)

JPM_data <- JPM_data %>%
  mutate(Price_Change = JPM.Close - JPM.Open)

JPM_data <- JPM_data %>%
  arrange(desc(JPM.Close))


View(JPM_data)

JPM_data <- JPM_data %>%
  rename(Trade_Volume = JPM.Volume)

names(JPM_data)
head(JPM_data)


summary(JPM_data)
JPM_data$date_chr <- as.character(JPM_data$date)
JPM_data$JPM.Volume_num <-  as.numeric(gsub(",","",JPM_data$Trade_Volume))

names(JPM_data)
str(JPM_data$JPM.Volume_num)
summary(JPM_data$JPM.Volume_num)


install.packages("ggplot2")
library(ggplot2)

JPM_data$date <- as.Date(JPM_data$date)

# Basic line plot of closing price over time
ggplot(JPM_data, aes(x = date, y = JPM.Close)) +
  geom_line(color = "blue") +
  labs(title = "JPMorgan Closing Price Over Time",
       x = "Date",
       y = "Closing Price ($)")

write.csv(JPM_data, "JPMorgan_cleaned.csv", row.names = FALSE)

getwd()
