# Presentation Outline: Multivariate Analysis Mini-Project

**Title:** Uncovering Customer Segments through Multivariate Analysis
**Audience:** Jury / Business Stakeholders
**Target Length:** 10-12 Slides

---

## Slide 1: Title Slide
- **Title:** Customer Segmentation using PCA and K-Means
- **Subtitle:** Identifying Actionable Purchasing Profiles in Wholesale Data
- **Presenter:** [Your Name / Team Name]
- **Visual:** A clean, abstract graphic representing clustering.

---

## Slide 2: Project Objectives
- **Goal:** Analyze multidimensional wholesale customer data to extract interpretable profiles.
- **Why it matters:** Understanding purchasing behavior allows for targeted marketing, optimized supply chains, and increased ROI.
- **Methods:** Principal Component Analysis (PCA) & K-Means Clustering.
- **Speaker Notes:** "Welcome. Today we will walk through an end-to-end data science pipeline, translating raw wholesale purchasing data into actionable business intelligence."

---

## Slide 3: Dataset Overview (Phase 1)
- **Dataset:** UCI Wholesale Customers.
- **Dimensions:** 440 Customers $\times$ 8 Variables.
- **Key Features:** Annual spending (m.u.) on Fresh, Milk, Grocery, Frozen, Detergents_Paper, and Delicassen.
- **Visual:** A small snippet of the raw data table.

---

## Slide 4: Data Preparation & Preprocessing (Phase 2)
- **Challenges:** Spending data is heavily right-skewed.
- **Solutions:** 
  1. Applied a $Log(x+1)$ transformation to normalize variance.
  2. Applied Standard Scaling ($Z$-score) to ensure equal weight for PCA and distance-metrics.
- **Speaker Notes:** "Standardization is a mandatory step before PCA. Without it, variables with larger absolute numbers (like Fresh food) would artificially dominate our analysis."

---

## Slide 5: Exploratory Data Analysis (Phase 3)
- **Key Findings:** Strong correlations exist between Grocery, Milk, and Detergents. Fresh and Frozen operate independently.
- **Visual:** The Correlation Heatmap.
- **Speaker Notes:** "The heatmap immediately reveals two macro-categories: a 'Retail' basket (groceries/detergents) and a 'Perishables' basket. We expect our PCA to capture this dichotomy."

---

## Slide 6: Principal Component Analysis - Dimensionality (Phase 4)
- **Scree Plot Analysis:** First two dimensions capture ~72% of total variance.
- **Decision:** Reduced 6 continuous dimensions down to 2 principal components.
- **Visual:** Scree Plot (`fviz_eig`).
- **Speaker Notes:** "By retaining just two components, we compress 72% of the information into a 2D space, making visualization and clustering mathematically efficient."

---

## Slide 7: Principal Component Analysis - Variables (Phase 4)
- **Interpreting the Axes:**
  - *Dimension 1:* The "Retail Axis" (Grocery, Detergents, Milk).
  - *Dimension 2:* The "Fresh/Restaurant Axis" (Fresh, Frozen).
- **Visual:** PCA Variables Factor Map (`fviz_pca_var`).

---

## Slide 8: Clustering Methodology (Phase 5)
- **Algorithm:** K-Means Clustering.
- **Finding K:** Used the Elbow Method to determine optimal number of clusters.
- **Decision:** Selected $K=3$ for distinct, interpretable segments.
- **Visual:** Elbow Method Plot (`fviz_nbclust`).

---

## Slide 9: PCA + Cluster Integration (Phase 6)
- **Result:** Projecting the 3 clusters onto our 2D PCA map.
- **Visual:** The `fviz_cluster` scatter plot showing the 3 convex hulls.
- **Speaker Notes:** "As you can see, the clusters separate beautifully along our principal axes, proving that our K-Means model successfully captured the underlying structure of the data."

---

## Slide 10: Business Interpretation - Cluster Profiles (Phase 7)
- **Cluster 1: Small/Medium Restaurants** (High % Fresh/Frozen).
- **Cluster 2: Supermarkets / Bulk Retailers** (Massive Grocery/Detergents spend).
- **Cluster 3: Premium Fresh Buyers** (Extremely high Fresh & Delicassen).
- **Visual:** A clean table or bar chart showing average spend per cluster.

---

## Slide 11: Actionable Recommendations
- **For Cluster 1:** Offer dynamic logistics for daily fresh deliveries.
- **For Cluster 2:** Negotiate long-term bulk contracts and dedicated account management.
- **For Cluster 3:** Upsell premium, high-margin specialized products.
- **Speaker Notes:** "Analytics is only useful if it drives action. Here is how our sales team can immediately leverage these three profiles..."

---

## Slide 12: Q&A and Conclusion
- **Summary:** Successfully mapped multidimensional behavior into 3 actionable segments.
- **Next Steps:** Integrate pipeline with live CRM data.
- **Visual:** "Thank You - Questions?"
