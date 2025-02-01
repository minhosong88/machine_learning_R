# **College Data Frame: Decision Tree & Random Forest Classification**

## **Project Overview**

This project focuses on **classification using Decision Trees and Random Forests** on the **College dataset**. The objective is to predict whether a school is **Private or Not** based on various numerical and categorical attributes.

The key objectives of this project are:

- **Exploratory Data Analysis (EDA)** to visualize relationships between variables.
- **Data Cleaning & Preprocessing**, ensuring correct values and handling inconsistencies.
- **Train-test splitting** to evaluate model performance.
- **Building a Decision Tree (CART) model** to classify schools as `Private` or `Not Private`.
- **Building a Random Forest model** to improve classification accuracy.
- **Evaluating model performance** using accuracy, precision, and recall.

---

## **Dataset Description**

The dataset contains the following features:

- **Private** – Target variable (Categorical: `Yes` or `No`).
- **Apps** – Number of applications received.
- **Accept** – Number of applicants accepted.
- **Enroll** – Number of new students enrolled.
- **Top10perc** – Percentage of new students from the top 10% of their high school class.
- **Top25perc** – Percentage of new students from the top 25% of their high school class.
- **F.Undergrad** – Number of full-time undergraduates.
- **P.Undergrad** – Number of part-time undergraduates.
- **Outstate** – Out-of-state tuition.
- **Room.Board** – Cost of room and board.
- **Books** – Estimated book costs.
- **Personal** – Estimated personal spending.
- **PhD** – Percentage of faculty with a Ph.D.
- **Terminal** – Percentage of faculty with a terminal degree.
- **S.F.Ratio** – Student-to-faculty ratio.
- **perc.alumni** – Percentage of alumni donating.
- **Expend** – Instructional expenditure per student.
- **Grad.Rate** – Graduation rate.

---

## **Implementation**

This project consists of **one main script**:

- **`college_tree_methods.R`** – R script for data preprocessing, Decision Tree modeling, Random Forest modeling, and performance evaluation.

---

## **How to Run the Code**

### **1. Install Required Libraries**

Before running the script, install the necessary R packages:

```r
install.packages("ISLR")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("caTools")
install.packages("rpart")
install.packages("rpart.plot")
install.packages("randomForest")
```

## **Key Findings**

### **1. Exploratory Data Analysis (EDA)**

- **Scatter Plot of `Grad.Rate` vs. `Room.Board`**, colored by `Private` status.
- **Histogram of `F.Undergrad`**, colored by `Private`, to visualize enrollment distribution.
- **Histogram of `Grad.Rate`**, colored by `Private`, revealing an anomaly (grad rate > 100%).

#### **Data Cleaning**

- **Identified an incorrect `Grad.Rate` value > 100%**.
- **Fixed the error by capping the `Grad.Rate` at 100%**.

---

### **2. Train-Test Split**

- The dataset was **split into 70% training and 30% testing** using `sample.split()`.
- Ensured **consistent train-test separation** to fairly evaluate models.

---

### **3. Decision Tree Model**

- **Built a CART Decision Tree (`rpart`)** to classify `Private` schools.
- **Plotted the tree** using `prp()` for interpretability.
- **Predicted on test data** and evaluated with a **confusion matrix**.
- **Computed accuracy, precision, and recall**:

#### **Results from a Single Tree:**

- **Accuracy:** 0.9313
- **Precision:** 0.9467
- **Recall:** 0.9581

---

### **4. Random Forest Model**

- **Built a Random Forest model (`randomForest`)** with the training data.
- **Checked feature importance** to determine which variables contributed most.
- **Predicted on test data** and computed evaluation metrics:

#### **Results from Random Forest:**

- **Accuracy:** 0.9442
- **Precision:** 0.9645
- **Recall:** 0.9588

---

## **Evaluation Summary**

- **The Random Forest model performed better overall**, with **higher accuracy and precision** while maintaining similar recall.
- The improvements suggest **better decision boundary refinement** in the Random Forest model, possibly due to **ensemble learning reducing variance**.
- If **false positives are costly**, the Random Forest model is the **better choice** due to its **higher precision**.

---

## **Limitations**

- **Decision Trees can easily overfit**, but pruning and cross-validation can help.
- **Random Forest provides better accuracy**, but interpretability is lower compared to a single tree.
- **Feature importance analysis** helps understand key predictors of `Private` classification.

---

## **Next Steps**

- Implement **hyperparameter tuning** to optimize tree depth (`cp` in `rpart`) and the number of trees (`ntree` in `randomForest`).
- Try **alternative models** (e.g., Support Vector Machines, Gradient Boosting).
- Explore **cross-validation** to improve model stability.
