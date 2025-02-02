# **Loan Data Support Vector Machine (SVM) Classification**

## **Project Overview**

This project applies **Support Vector Machine (SVM)** for classification on a **loan dataset**. The objective is to predict whether a borrower **fully repays a loan** based on features like **FICO score, interest rate, and loan purpose**.

The key objectives of this project are:

- **Data preprocessing**, including categorical variable transformation.
- **Exploratory Data Analysis (EDA)** with visualizations.
- **Train-test splitting** to evaluate model performance.
- **Building and tuning an SVM model** to classify loan repayment status.
- **Performance evaluation using accuracy, precision, and recall**.

---

## **Dataset Description**

The dataset contains the following key features:

- **fico** – FICO credit score of the borrower.
- **int.rate** – Interest rate assigned to the loan.
- **purpose** – Purpose of the loan (e.g., debt consolidation, credit card).
- **inq.last.6mths** – Number of credit inquiries in the last six months.
- **delinq.2yrs** – Number of past delinquencies in the last two years.
- **pub.rec** – Number of derogatory public records.
- **credit.policy** – Whether the borrower meets the credit underwriting criteria.
- **not.fully.paid** – **Target variable** (1 = Not Fully Paid, 0 = Fully Paid).

---

## **How to Run the Code**

### **1. Install Required Libraries**

Before running the script, install the necessary R packages:

```r
install.packages("dplyr")
install.packages("ggplot2")
install.packages("caTools")
install.packages("e1071")
```

## **Key Findings**

### **1. Data Preprocessing**

- Converted categorical variables (`inq.last.6mths`, `delinq.2yrs`, `pub.rec`, `not.fully.paid`, `credit.policy`) to **factor type** for proper model interpretation.
- Verified the dataset structure with `summary(df)` and `str(df)`.

### **2. Exploratory Data Analysis (EDA)**

#### **FICO Score Distribution by Loan Repayment Status**

- A histogram was plotted to visualize the **distribution of FICO scores**, colored by **not fully paid** status.
- **Observation:** **Lower FICO scores tend to have a higher chance of not fully repaying loans.**

#### **Loan Purpose vs. Loan Repayment Status**

- A **barplot** was created to compare the **count of different loan purposes**, colored by repayment status.
- **Observation:** Certain loan purposes, like **small business loans**, have a higher proportion of **not fully paid** loans.

#### **Interest Rate vs. FICO Score (Scatter Plot)**

- A **scatter plot** was generated to analyze the relationship between **interest rate and FICO score**.
- **Observation:** Borrowers with **lower FICO scores tend to have higher interest rates**.

---

## **3. Train-Test Split**

- The dataset was **split into 70% training and 30% testing** using `sample.split()`.
- Both training and testing datasets maintained the same proportion of **not fully paid** cases.

---

## **4. Building the SVM Model**

- An **SVM model** was trained using the `svm()` function with default parameters.
- The **model summary** was examined, and the **gamma value** was extracted manually (`model$gamma`).

### **Initial Model Performance**

- The **confusion matrix** was generated using `table(predicted.values, test$not.fully.paid)`.
- Basic **accuracy was calculated** as the ratio of correctly predicted cases.

---

## **5. Model Tuning (Hyperparameter Optimization)**

- Used the `tune()` function to optimize **cost and gamma** for better classification performance.
- The best values were found, and the model was retrained with `svm(cost=100, gamma=0.1)`.
- The final **confusion matrix** was computed again.

### **Performance Metrics**

- **Accuracy** = \( \frac{\text{Correct Predictions}}{\text{Total Predictions}} \)
- **Precision** = \( \frac{\text{True Positives}}{\text{Predicted Positives}} \)
- **Recall** = \( \frac{\text{True Positives}}{\text{Actual Positives}} \)

---

## **Key Observations**

- **Higher interest rates correlate with a higher probability of not fully paying loans.**
- **Borrowers with lower FICO scores receive higher interest rates.**
- **Certain loan purposes have a higher risk of defaulting.**
- **Tuning hyperparameters improves model performance, increasing accuracy and recall.**

---

## **Limitations**

- **Imbalanced dataset:** The number of **fully paid** vs. **not fully paid** loans might not be equal, affecting performance.
- **Feature selection:** Additional **feature engineering** may improve predictive accuracy.
- **SVM scaling issues:** For larger datasets, **computational efficiency** could be a concern.

---

## **Next Steps**

- Apply **SMOTE (Synthetic Minority Over-sampling Technique)** to balance the dataset.
- Test **alternative classifiers** (e.g., Logistic Regression, Decision Trees, Random Forests).
- Perform **cross-validation** to get a more reliable model performance estimate.
