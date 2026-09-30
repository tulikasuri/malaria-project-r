# WHO Malaria Data Analysis in R

Statistical comparison of malaria case burden across countries, using WHO data
and non-parametric hypothesis tests in R.

## Question
Are differences in average malaria cases between countries statistically
significant, or just random variation?

## Data
WHO malaria dataset ('WHO Malaria Data'): 821 records covering 92 countries
(2015-2024). There are 6 WHO regions, the indicator is RDT-positive case counts, and  the data came from WHO Global Health Observatory. Key fields: region, country, year, reported value, and confidence interval bounds.

## Method
1. **Cleaning (tidyverse):** selected and renamed key columns, removed missing values.
2. **Visualisation (ggplot2):** average cases by country (`malaria_plot.png`).
3. **Testing:** Shapiro-Wilk showed the data is not normally distributed, so I used
   a Kruskal-Wallis test, followed by pairwise Wilcoxon tests with Holm correction
   to control for multiple comparisons.

## Findings
- A Shapiro-Wilk test rejected normality (p < 0.05), so the data is skewed and
  non-parametric tests were used.
- A Kruskal-Wallis test rejected the null hypothesis (p < 0.05): at least one
  country has a significantly different distribution of malaria cases.
- Pairwise Wilcoxon tests with Holm correction were used to identify which
  country pairs differ; the significant pairs are listed by the final step of
  the script.
![Average malaria cases by country](malaria_plot.png)
## How to run
Requires R and the `tidyverse` package. Download the repo, open MalariaProject.R in RStudio, and set the working directory to the source file's location (Session → Set Working Directory → To Source File Location).
## Limitations
Values are raw RDT-positive case counts, not population-adjusted rates, so results reflect country size as well as malaria burden. Countries contribute between 1 and 10 yearly records, and reporting may not be random. Repeated yearly observations for a country are treated as independent, and WHO confidence intervals were not used. Results show that countries differ, not why, and should be read as exploratory.
