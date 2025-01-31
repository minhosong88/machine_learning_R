# **Iris Dataset KNN Classification**

## **Project Overview**

This project focuses on **classification using K-Nearest Neighbors (KNN)** on the **Iris dataset**. The objective is to predict the species of a flower based on its **sepal and petal dimensions** after applying **data standardization**.

The key objectives of this project are:

- **Data preprocessing and standardization**, ensuring all numerical features have zero mean and unit variance.
- **Train-test splitting** to evaluate model performance.
- **Building a KNN model** to classify species based on sepal and petal dimensions.
- **Tuning the K value** to find the optimal number of neighbors (`K`) for the best classification accuracy.

---

## **Dataset Description**

The dataset contains the following features:

- **Sepal.Length** – Length of the sepal in cm.
- **Sepal.Width** – Width of the sepal in cm.
- **Petal.Length** – Length of the petal in cm.
- **Petal.Width** – Width of the petal in cm.
- **Species** – Target variable representing the flower species (`setosa`, `versicolor`, or `virginica`).

---

## **Implementation**

This project consists of **one main script**:

- **`iris_knn_classification.R`** – R script for data preprocessing, KNN modeling, and performance evaluation.

---

## **How to Run the Code**

### **Running the R Script (`iris_knn_classification.R`)**

#### **1. Install Required Libraries**

Before running the script, install the necessary R packages:

```r
install.packages("dplyr")
install.packages("ggplot2")
install.packages("caTools")
install.packages("class")
```

## **Key Findings**

### **1. Data Preprocessing & Standardization**

- The dataset was **split into independent features (`Sepal.Length`, `Sepal.Width`, `Petal.Length`, `Petal.Width`) and the target variable (`Species`)**.
- **Standardization (`scale()`) was applied** to ensure that all numerical features have zero mean and unit variance.
- The target variable was **re-added to the dataset after standardization** to ensure no information loss.

### **2. Train-Test Split**

- The dataset was **split into 70% training and 30% testing** using `sample.split()`.
- The split was applied consistently to **both the standardized features and the target variable**.

### **3. KNN Model Performance**

- **KNN was applied with `K=1`**, and the **misclassification rate was calculated**.
- The **error rate fluctuates due to the small dataset size**.
- **The best K value was determined through an error rate plot**.

---

## **Choosing the Best K Value**

A **KNN model was trained for K values ranging from 1 to 10**, and the error rate was plotted.

### **Observations from the Graph:**

- The **error rate is highest at K = 2**.
- The **error rate significantly drops around K = 3 and K = 5**.
- There is a **stable error rate** from **K = 5 to K = 9**, but it slightly increases.
- At **K = 10**, the error rate drops again.

### **Best K Choice:**

- **K = 5** appears to be a strong choice since it has the **lowest error rate**.
- **K = 3** is also a good option, but **K = 5** is generally preferred for better generalization.
- Higher values (K = 6, 7, 8, 9) show a slightly **higher error rate**, which indicates they might not be the optimal choice.

### **Final Recommendation:**

- **Best K = 5**, as it achieves the lowest error rate while avoiding extreme overfitting (small K) or underfitting (large K).

---

## **Limitations**

- **Small dataset size** leads to **fluctuations in prediction error**.
- The model is **highly sensitive to K**, and different train-test splits may lead to different results.
- **Cross-validation could help** in getting more stable error estimates.

---

## **Next Steps**

- Apply **cross-validation** to better estimate model performance.
- Test **alternative distance metrics** in KNN (e.g., Manhattan, Minkowski).
- Compare KNN with other classification models (e.g., Decision Trees, SVM, Neural Networks).
