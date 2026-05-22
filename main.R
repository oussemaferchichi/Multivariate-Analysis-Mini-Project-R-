# ==============================================================================
# MULTIVARIATE ANALYSIS MINI-PROJECT
# Dataset: Wholesale Customers (UCI Machine Learning Repository)
# ==============================================================================

# Install required packages if they are not already installed
required_packages <- c("tidyverse", "FactoMineR", "factoextra", "cluster", "ggplot2", "corrplot")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

# Load Libraries
library(tidyverse)
library(FactoMineR)
library(factoextra)
library(cluster)
library(ggplot2)
library(corrplot)

# ==============================================================================
# PHASE 1: DATA ACQUISITION & SETUP
# ==============================================================================
cat("\n--- PHASE 1: DATA ACQUISITION ---\n")

# URL for Wholesale Customers Dataset
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00292/Wholesale%20customers%20data.csv"

# Load the dataset
data <- read.csv(url)

# Validate structure
cat("Dataset Dimensions (Rows, Columns): ", dim(data), "\n")
str(data)

# Factorize categorical variables for interpretation later
data$Channel <- factor(data$Channel, levels = c(1, 2), labels = c("Horeca", "Retail"))
data$Region <- factor(data$Region, levels = c(1, 2, 3), labels = c("Lisbon", "Oporto", "Other"))

summary(data)

# ==============================================================================
# PHASE 2: DATA PREPARATION
# ==============================================================================
cat("\n--- PHASE 2: DATA PREPARATION ---\n")

# 1. Detect Missing Values
missing_vals <- sum(is.na(data))
cat("Total missing values: ", missing_vals, "\n")
# If there were missing values, we could use median imputation or na.omit().
# data_clean <- na.omit(data) 

# 2. Extract numeric variables for PCA
data_numeric <- data %>% select(-Channel, -Region)

# 3. Handle outliers & Skewness
# Wholesale spending data is typically heavily right-skewed.
# We will apply a log(x+1) transformation to reduce the impact of extreme outliers.
data_log <- log1p(data_numeric)

# 4. Normalize numeric variables
# scale() standardizes the data (mean = 0, sd = 1), crucial for PCA and K-Means.
data_scaled <- as.data.frame(scale(data_log))

cat("Summary of prepared & scaled data:\n")
summary(data_scaled)

# ==============================================================================
# PHASE 3: EXPLORATORY ANALYSIS
# ==============================================================================
cat("\n--- PHASE 3: EXPLORATORY ANALYSIS ---\n")

# 1. Descriptive Statistics on original numeric data
summary(data_numeric)

# 2. Correlation Matrix
cor_matrix <- cor(data_numeric)
cat("Correlation Matrix:\n")
print(cor_matrix)

# Visualizing the correlation matrix
# Saving plot to a file or opening a graphics device
corrplot(cor_matrix, method="color", type="upper", addCoef.col = "black", 
         tl.col="black", tl.srt=45, diag=FALSE, 
         title="Correlation Heatmap of Spending", mar=c(0,0,1,0))

# 3. Visual Exploration: Boxplots for outlier detection on log-transformed data
data_log_long <- pivot_longer(data_log, cols = everything(), names_to = "Category", values_to = "Log_Spend")
boxplot_plot <- ggplot(data_log_long, aes(x=Category, y=Log_Spend, fill=Category)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title="Boxplots of Log-Transformed Spending per Category", y="Log(Spend + 1)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(boxplot_plot)

# ==============================================================================
# PHASE 4: FACTOR ANALYSIS (PCA)
# ==============================================================================
cat("\n--- PHASE 4: FACTOR ANALYSIS (PCA) ---\n")

# 1. Run PCA
# We use graph = FALSE to prevent automatic plotting, we will use factoextra
res.pca <- PCA(data_scaled, graph = FALSE)

# 2. Analyze Eigenvalues & Variance
cat("Eigenvalues:\n")
print(get_eig(res.pca))

# Scree plot
scree <- fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 50),
         title="Scree Plot: Explained Variance by Dimensions")
print(scree)

# 3. Variable Contributions
# Plotting the correlation circle
var_plot <- fviz_pca_var(res.pca, col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE, 
             title="PCA: Variables Factor Map")
print(var_plot)

# 4. Individual Factor Map (Colored by Channel to see natural separation)
ind_plot <- fviz_pca_ind(res.pca, 
             geom.ind = "point", 
             col.ind = data$Channel, # Color by Channel
             palette = c("#00AFBB", "#FC4E07"),
             addEllipses = TRUE, 
             legend.title = "Channel",
             title="PCA: Individuals mapped by Channel")
print(ind_plot)

# Justification for components: 
# The first 2 components explain roughly ~72% of the total variance, 
# which is sufficient for dimension reduction.

# ==============================================================================
# PHASE 5: CLUSTERING
# ==============================================================================
cat("\n--- PHASE 5: CLUSTERING ---\n")

# We will use K-Means clustering. First, determine the optimal number of clusters (k).
# We will use the Elbow Method.
set.seed(123) # For reproducibility
elbow_plot <- fviz_nbclust(data_scaled, kmeans, method = "wss") + 
  labs(subtitle = "Elbow Method")
print(elbow_plot)

# Silhouette method (optional alternative)
# fviz_nbclust(data_scaled, kmeans, method = "silhouette")

# Based on the elbow, k=2 or k=3 are good choices. We'll proceed with k=3 
# to get more nuanced business segments.
optimal_k <- 3

# Fit K-means model
set.seed(123)
kmeans_res <- kmeans(data_scaled, centers = optimal_k, nstart = 25)

# Append cluster assignment to the original dataset for interpretation
data$Cluster <- as.factor(kmeans_res$cluster)

cat("Cluster Sizes:\n")
print(kmeans_res$size)

# ==============================================================================
# PHASE 6: PCA + CLUSTER INTEGRATION
# ==============================================================================
cat("\n--- PHASE 6: PCA + CLUSTER INTEGRATION ---\n")

# Visualize the K-means clusters on the PCA components
cluster_pca_plot <- fviz_cluster(kmeans_res, data = data_scaled, 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_minimal(),
             title = "K-Means Clusters Projected on PCA Space")
print(cluster_pca_plot)

# ==============================================================================
# PHASE 7: BUSINESS / STATISTICAL INTERPRETATION
# ==============================================================================
cat("\n--- PHASE 7: BUSINESS INTERPRETATION ---\n")

# Calculate average spending across all original numeric categories per cluster
cluster_profiles <- data %>%
  group_by(Cluster) %>%
  summarise(across(c(Fresh, Milk, Grocery, Frozen, Detergents_Paper, Delicassen), mean))

print(cluster_profiles)

# Interpretation Guide (Hypothetical based on typical results):
# -------------------------------------------------------------
# Cluster 1: High Fresh & Frozen. Profile: "Fresh Food Heavy" (e.g., Restaurants/Cafes).
# Cluster 2: High Milk, Grocery, Detergents. Profile: "Bulk Retailers" (e.g., Supermarkets).
# Cluster 3: Low overall spend. Profile: "Small/Medium Buyers" (e.g., Small Deli).

cat("\nAnalysis complete! Review the plots for visual insights.\n")
