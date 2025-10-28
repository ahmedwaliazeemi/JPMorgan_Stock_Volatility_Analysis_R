# 🏦 J.P. Morgan Stock Volatility and Price Prediction (R)

🎯 Project Overview

This project provides a comprehensive quantitative analysis of J.P. Morgan (JPM) stock data (2019-2025) using R and the tidyverse. The analysis centers on Feature Engineering by deriving daily price volatility metrics. Key steps include creating a Monthly Summary Pivot Table, performing a Correlation Analysis on all variables, and developing a Linear Regression model to predict JPM's closing price based on engineered and core financial features.

✨ Key Features

Feature Engineering: Developed new variables for daily price fluctuation, specifically volatility (High - Low) and volatility_percent.

Data Categorization: Implemented recoding and binning for Volume and Closing Price to facilitate deeper analysis.

Statistical Modeling: Built a Linear Regression model to determine which financial features are the most significant predictors of the JPM closing price.

Correlation Mapping: Generated a full correlation matrix to map relationships between all engineered and core financial variables.

Monthly Summary: Created a monthly pivot table summarizing average prices, total volume, and volatility.

🛠️ Technology Stack

# Core Language
Language: R

# Data & Analysis Packages
Manipulation: tidyverse
Modeling: stats (lm function)
Date Handling: lubridate
Visualization: ggplot2




🚀 How to Run the Analysis Locally

To replicate the analysis and run the script, you will need R and RStudio installed.

Clone the Repository:

git clone [https://github.com/YourUsername/JPMorgan_Stock_Volatility_Analysis_R.git](https://github.com/YourUsername/JPMorgan_Stock_Volatility_Analysis_R.git)
cd JPMorgan_Stock_Volatility_Analysis_R




Install Packages: Run this command in your R console:

install.packages(c("tidyverse", "lubridate", "ggplot2"))




Execute the Script: Open the assignment 3.R file in RStudio and run the entire script. The output will display the monthly pivot table, correlation matrix, and the summary of the linear regression model.

📂 Repository Contents

assignment 3.R: The main R script containing all data cleaning, feature engineering, statistical modeling, and analysis steps.

JPMorganData.csv: The original, raw input data file.

JPMorgan_cleaned.csv: The cleansed and preprocessed data file used directly by the main script.

Rhistory: Command history log.
