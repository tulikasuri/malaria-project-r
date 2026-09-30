# WHO Malaria Data Analysis in R

Statistical comparison of malaria case burden across countries, using WHO data
and non-parametric hypothesis tests in R.

## Question
Are differences in average malaria cases between countries statistically
significant, or just random variation?

## Data
WHO malaria dataset (`who_malaria_data.csv`): 822 records covering 92 countries,
(2015-2024). Key fields: region, country, year, reported value, and confidence
interval bounds.

## Method
1. **Cleaning (tidyverse):** selected and renamed key columns, removed missing values.
2. **Visualisation (ggplot2):** average cases by country (`malaria_plot.png`).
3. **Testing:** Shapiro-Wilk showed the data is not normally distributed, so I used
   a Kruskal-Wallis test, followed by pairwise Wilcoxon tests with Holm correction
   to control for multiple comparisons.

## Findings
Used the Shapiro Test to determine if the data is normally distributed, found the p-value to be less than 0.05 so reject H0 (The data is normally distributed), so the data is not normally distributed, it's skewed. 
Since the data is skewed, we then used the Kruskal test - we found the p-value to be less than 0.05, we reject H0, so at least one country has a significantly different distribution of malaria cases.
We then used the pairwise Wilcox test to summarise the significant pairs.

## How to run
Requires R and the `tidyverse` package. Open `MalariaProject.R` and run it from
the top; the dataset is loaded from the CSV in this folder.

## Limitations
Values are raw RDT-positive case counts, not population-adjusted rates, so results reflect country size as well as malaria burden. Countries contribute between 1 and 10 yearly records, and reporting may not be random. Repeated yearly observations for a country are treated as independent, and WHO confidence intervals were not used. Results show that countries differ, not why, and should be read as exploratory.
