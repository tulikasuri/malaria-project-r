library(tidyverse)
malaria_data <- read_csv("WHO Malaria Data")
#1. Clean and subset the WHO dataset


malaria_clean <- malaria_data %>%
#Select and rename only the columns we need
select(
    Region = ParentLocation,
    Country = Location,
    Year = Period,
    Value = FactValueNumeric,
    Lower_CI = FactValueNumericLow,
    Upper_CI = FactValueNumericHigh
    ) %>%
#Filter out rows where the main numeric Value is missing
filter(!is.na(Value)) %>%
#Sort chronologically by Country and Year
arrange(Country, Year)
# Inspect your clean dataset
head(malaria_clean)

#2. Visualise the data

#Visualise the data
options(scipen = 999)
malaria_clean %>%
  group_by(Country) %>%
  summarise(Avg_Cases = mean(Value, na.rm = TRUE)) %>%
  arrange(desc(Avg_Cases)) %>%
  ggplot(aes(x = Avg_Cases, y = fct_reorder(Country, Avg_Cases))) + 
  geom_col() +
  labs(
    y = "Country",                             
    x = "Average Malaria Cases",               
    title = "Average Malaria Cases by Country" 
  )

#3.Analyse the data to find out if the differences in average cases between countries is statistically significant or just random variation
#3. a) Find out if it's normally distributed, H0: The data is normally distributed, H1: The data is not normally distributed
shapiro.test(malaria_clean$Value)
#p-value is <0.05 so reject H0, so the data is not normally distributed, it's skewed
#3. b) Since the data is skewed, use the Kruskal test - H0: Any differences in the avg cases between countries is due to random chance
kruskal.test(Value ~ Country, data = malaria_clean)
#since the p-value is less than 0.05, we reject H0, so at least one country has a significantly different distribution of malaria cases 
#3. c) Find out which specific pairs of countries differ from eachother using pairwise wilcox test
pairwise.wilcox.test(malaria_clean$Value, malaria_clean$Country, p.adjust.method = "holm")
#3. d) Summarise the significant pairs
test_result <- pairwise.wilcox.test(malaria_clean$Value, malaria_clean$Country, p.adjust.method = "holm")
(as.data.frame.table(test_result$p.value) %>%
  rename(Country1 = Var1, Country2 = Var2, p_value = Freq) %>%
  filter(!is.na(p_value), p_value < 0.05) %>%
  arrange(p_value)
)
