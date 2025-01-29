# **Bike Sharing Demand Prediction**

## **Project Overview**

This project explores **bike rental demand prediction** using **linear regression**. The dataset includes **hourly rental data**, with features such as temperature, season, weather conditions, and time. The goal is to **analyze seasonality and limitations of linear regression** in modeling time-dependent data.

We perform **Exploratory Data Analysis (EDA)**, feature engineering, and build **multiple regression models** to understand the relationship between weather and bike rentals.

---

## **Dataset Description**

The dataset contains the following columns:

- **datetime** – Hourly timestamp
- **season** – Categorical (1: Spring, 2: Summer, 3: Fall, 4: Winter)
- **holiday** – Whether the day is a holiday (0: No, 1: Yes)
- **workingday** – Whether the day is a working day (0: No, 1: Yes)
- **weather** – Weather conditions (1: Clear, 4: Heavy Rain/Snow)
- **temp** – Temperature (°C)
- **atemp** – Feels-like temperature (°C)
- **humidity** – Relative humidity
- **windspeed** – Wind speed
- **casual** – Number of non-registered users
- **registered** – Number of registered users
- **count** – Total bike rentals (Target variable)

---

## **Implementation**

This project consists of **two main files**:

1. **`BikeSharingDemand.R`** – R script for data analysis, visualization, and model building.
2. **`bike_sharing_LT.ipynb`** – Jupyter Notebook with a similar workflow in Python.

---

## **How to Run the Code**

### **Running the R Script (`BikeSharingDemand.R`)**

#### **1. Install Required Libraries**

```r
install.packages("ggplot2")
install.packages("dplyr")
```

#### **2. Load Data and Run the Script**

```r
library(ggplot2)
library(dplyr)

# Load the dataset
bike <- read.csv('bikeshare.csv')

# Run EDA and Model
source("BikeSharingDemand.R")
```

## **Key Findings**

### **1. EDA Insights:**

- Bike rentals **increase during summer and fall**.
- There is a **strong correlation** between **temperature** and **rental count** (`correlation = 0.39`).
- **Hourly rentals** peak at **8 AM (commute) and 5 PM (evening return).**

### **2. Model Performance:**

#### **Simple linear regression (`count ~ temp`)**

- `R² = 0.1556`, meaning temperature alone explains ~15.6% of rental variability.

#### **Multiple regression (`count ~ season + weather + temp + humidity + windspeed + hour`)**

- `R² = 0.3344`, showing better but still limited predictive power.

### **3. Limitations of Linear Regression:**

- **Fails to capture seasonality and long-term trends.**
- **Ignores non-linear relationships** in bike rental behavior.
- **Better alternatives**: Time-series models (e.g., ARIMA, SARIMA) or tree-based models (Random Forest, XGBoost).

---

## **Next Steps**

- Explore **non-linear models** (e.g., Random Forest, Gradient Boosting).
- Use **time-series forecasting** for better trend prediction.
- Improve feature engineering by incorporating **weekday/weekend effects**.
