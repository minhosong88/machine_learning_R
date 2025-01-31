# **Adult Salary Prediction with Logistic Regression**

## **Project Overview**

This project focuses on **data cleaning and logistic regression modeling** to predict whether an individual earns more than $50K per year based on demographic and employment-related attributes. The dataset contains various categorical and numerical features that influence income levels.

The key objectives of this project are:

- **Data preprocessing and cleaning**, including handling missing values and reducing category levels for better model performance.
- **Exploratory Data Analysis (EDA)** to visualize feature distributions and relationships with income.
- **Building a logistic regression model** to classify individuals' income levels and evaluate its performance using accuracy, recall, and precision.

---

## **Dataset Description**

The dataset contains the following features:

- **age** – Age of the individual.
- **workclass** – Employment type.
- **education** – Highest level of education attained.
- **marital-status** – Marital status of the individual.
- **occupation** – Type of job.
- **relationship** – Relationship status (e.g., husband, wife, own-child).
- **race** – Ethnicity of the individual.
- **sex** – Gender of the individual.
- **capital-gain** – Capital gains recorded.
- **capital-loss** – Capital losses recorded.
- **hours-per-week** – Average working hours per week.
- **native-country** – Country of origin.
- **income** – Binary target variable (`<=50K` or `>50K`).

---

## **Implementation**

This project consists of **one main script**:

- **`adult_salary_logit.ipynb`** – R script for data cleaning, visualization, and model training.

---

## **How to Run the Code**

### **Running the R Script (`adult_salary_logit.ipynb`)**

#### **1. Install Required Libraries**

Before running the script, install the necessary R packages:

```r
install.packages("dplyr")
install.packages("ggplot2")
install.packages("caTools")
install.packages("Amelia")
```

## **Key Findings**

### **1. Data Cleaning & Preprocessing**

- **Employment types and marital status categories were reduced** to enhance model interpretability.
- **Missing values** were identified and handled by removing rows with `NA` values.
- **Country categories were grouped into regions** to simplify classification.

### **2. Exploratory Data Analysis (EDA)**

- The **age distribution** shows higher-income individuals tend to be older.
- The **working hours per week histogram** indicates that income distribution varies with work hours.
- **Income distribution across regions** was visualized to identify geographical patterns.

### **3. Model Performance**

A **logistic regression model** was trained and evaluated using key classification metrics:

- **Accuracy**: 76.4%
- **Recall**: 92.0%
- **Precision**: 87.9%

### **4. Model Limitations**

- The model **does not consider feature interactions** that might improve predictive power.
- **Cost-sensitive evaluation** is needed to determine the business impact of classification errors.
