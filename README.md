# Customer Segmentation: Multivariate Analysis Mini-Project 📊

![R](https://img.shields.io/badge/Language-R-276DC3?style=for-the-badge&logo=r)
![Data Science](https://img.shields.io/badge/Field-Data%20Science-FF9900?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

## 📌 Project Overview
This repository contains an end-to-end data science mini-project focused on **Multivariate Statistical Analysis**. The primary objective is to take raw, multidimensional B2B financial data and translate it into clear, actionable customer profiles using dimensionality reduction and unsupervised machine learning techniques.

## 🎯 Key Objectives
1. **Dimensionality Reduction:** Compress multidimensional spending behavior into an interpretable 2D space using **Principal Component Analysis (PCA)**.
2. **Customer Segmentation:** Identify distinct purchasing archetypes using **K-Means Clustering**.
3. **Business Intelligence:** Translate statistical math into actionable business strategies for marketing and supply chain optimization.

---

## 🗄️ The Dataset
We utilize the **Wholesale Customers Dataset** from the [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/wholesale+customers).
- **Size:** 440 Customers (Rows) $\times$ 8 Variables (Columns).
- **Features:** Annual spending (in monetary units) across 6 continuous categories: `Fresh`, `Milk`, `Grocery`, `Frozen`, `Detergents_Paper`, and `Delicassen`.

---

## ⚙️ Tech Stack & Packages
- **Language:** R
- **Data Manipulation:** `tidyverse` (dplyr, tidyr)
- **Multivariate Analysis:** `FactoMineR` (PCA)
- **Visualization:** `factoextra` (ggplot2 backend), `corrplot`
- **Machine Learning:** `cluster` (K-Means, Silhouette, Elbow Method)
- **Reporting:** R Markdown (`knitr`, `rmarkdown`)

---

## 🚀 Analytical Pipeline

### 1. Data Preprocessing
- **Skewness Correction:** Applied a $Log(x+1)$ transformation to normalize highly right-skewed financial data.
- **Standardization:** Applied $Z$-score scaling (`scale()`) to ensure variables with naturally massive numerical ranges (e.g., Fresh food) do not artificially dominate distance-based algorithms.

### 2. Exploratory Data Analysis (EDA)
- Generated a Correlation Heatmap revealing a strong "Retail Basket" (Groceries + Detergents) vs. an independent "Perishables Basket" (Fresh + Frozen).

### 3. Factor Analysis (PCA)
- Extracted Principal Components, successfully reducing 6 variables to 2 dimensions while retaining **~71.2%** of the total variance.
- Identified Dim 1 as the **"Retail Axis"** and Dim 2 as the **"Restaurant Axis"**.

### 4. K-Means Clustering
- Utilized the **Elbow Method** on the Within-Cluster Sum of Squares (WSS) to mathematically determine the optimal number of clusters ($K = 3$).
- Projected the K-Means clusters onto the 2D PCA space to visually validate the robust separation of the segments.

---

## 💡 Key Business Insights

By calculating the centroid averages of the original unscaled data, we identified 3 highly actionable customer archetypes:

| Cluster | Profile Name | Dominant Variables | Business Recommendation |
| :---: | :--- | :--- | :--- |
| **1** | **Retail Supermarkets** | `Grocery`, `Detergents_Paper` | Offer long-term bulk contracts on non-perishables. |
| **2** | **Premium Wholesale** | High spend across *all* categories | Assign dedicated account managers for premium B2B upselling. |
| **3** | **Restaurants / Cafés** | `Fresh`, `Frozen` | Deploy dynamic daily logistics for perishable deliveries. |

---

## 📂 Repository Structure
* `main.R`: The core, heavily-commented R script containing the entire analytical pipeline from data fetching to plotting.
* `report.Rmd`: The professional R Markdown report combining the code, statistical justifications, and business insights.
* `presentation.md`: The structured outline and speaker notes for the final slide deck presentation.

## 🛠️ How to Run
1. Clone this repository to your local machine.
2. Open `main.R` in **RStudio**.
3. Select all code (`Ctrl + A` / `Cmd + A`) and click **Run**. The script will automatically fetch the dataset via URL, install missing packages, and generate the plots in your viewer.
4. Open `report.Rmd` and click **"Knit to HTML"** to generate the final formatted consulting report.

---
*Created for the Statistical Methods and Data Analysis (Multivariate Analysis) Module.*
