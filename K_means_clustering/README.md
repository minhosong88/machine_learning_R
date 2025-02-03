# **Wine Quality K-Means Clustering**

## **Project Overview**

This project applies **K-Means Clustering** to a **wine quality dataset** containing both **red and white wines**. The objective is to cluster the wines based on key chemical properties and evaluate whether the clustering aligns with actual wine types.

The key objectives of this project are:

- **Data preprocessing**, including merging red and white wine datasets.
- **Exploratory Data Analysis (EDA)** with visualizations.
- **Applying K-Means clustering** to group wines based on chemical composition.
- **Evaluating clustering performance** by comparing clusters to actual wine labels.

---

## **Dataset Description**

The dataset contains the following key features:

- **fixed.acidity** – Fixed acids in wine (e.g., tartaric acid).
- **volatile.acidity** – Volatile acids that affect aroma.
- **citric.acid** – Citric acid levels in wine.
- **residual.sugar** – Remaining sugar after fermentation.
- **chlorides** – Salt content.
- **free.sulfur.dioxide** – Free SO₂ levels in wine.
- **total.sulfur.dioxide** – Total SO₂ levels in wine.
- **density** – Wine density.
- **pH** – Acidity of the wine.
- **sulphates** – Sulfate levels that affect stability.
- **alcohol** – Alcohol percentage.
- **quality** – Wine quality score.
- **label** – **Wine type (Red or White)**, manually assigned.

---

## **How to Run the Code**

### **1. Install Required Libraries**

Before running the script, install the necessary R packages:

```r
install.packages("dplyr")
install.packages("ggplot2")
install.packages("cluster")
```

## **Key Findings**

### **1. Data Preprocessing**

- Loaded **red and white wine datasets** separately.
- Added a **label column** to distinguish between **red and white wines**.
- Merged both datasets into a **single data frame** for clustering.
- Verified the dataset structure using `str(wine)`.

### **2. Exploratory Data Analysis (EDA)**

#### **Histogram of Residual Sugar**

- **White wines have a much wider range of residual sugar values**, including many high values.
- **Red wines typically have lower residual sugar**, making them drier.

#### **Histogram of Citric Acid**

- **White wines show more variability in citric acid**, while **red wines are concentrated at lower levels**.
- **Observation:** White wines often contain **added citric acid** for taste balance.

#### **Histogram of Alcohol**

- Red wines tend to have **slightly higher alcohol content** than white wines.

#### **Scatter Plot of Citric Acid vs. Residual Sugar**

- **White wines have more sugar and higher citric acid variability**.
- **Red wines are drier and show lower citric acid levels**.

#### **Scatter Plot of Volatile Acidity vs. Residual Sugar**

- **Red wines tend to have higher volatile acidity**.
- **White wines have lower volatile acidity and a wider sugar range**.

---

## **3. Data Preparation for Clustering**

- Removed the **label column** since clustering is **unsupervised**.
- The dataset used all numerical features for clustering.

---

## **4. K-Means Clustering**

- Applied **K-Means clustering** with `k=2` (since we expect two wine types).
- Used **20 random starts (`nstart=20`)** to find a stable clustering solution.

### **Cluster Results**

- The **confusion matrix** between actual labels and clusters was computed using:

```r
table(wine$label, wine.cluster$cluster)
```

- **Observations:**
  - The clustering **roughly aligns** with actual red and white wine labels.
  - Some **misclassification** occurs, likely due to overlap in chemical properties.

---

## **Key Observations**

- **Residual sugar and citric acid are strong indicators of wine type.**
- **Volatile acidity is a distinguishing factor, with red wines having higher values.**

- **K-Means clustering successfully differentiates most wines, but some overlap exists.**

---

## **Limitations**

- **Cluster purity is not perfect**, as some red and white wines share similar chemical properties.
- **Feature scaling might improve clustering performance.**
- **K-Means assumes spherical clusters**, which might not fully capture the true wine separation.

---

## **Next Steps**

- Apply **Principal Component Analysis (PCA)** to reduce dimensionality before clustering.
- Try **hierarchical clustering** for a different approach.
- Tune the **number of clusters (k)** using the **elbow method**.
