library(dplyr)

merged <- readRDS("merged_raw.rds")

clean_data <- merged %>%
  filter(RIDAGEYR >= 20) %>%
  filter(!is.na(SMQ020)) %>%
  filter(BPQ020 %in% c(1,2)) %>%
  filter(!is.na(BMXBMI)) %>%
  mutate(
    smoking = if_else(SMQ020 == 1, 1, 0),
    hypertension = if_else(BPQ020 == 1, 1, 0),
    gender = if_else(RIAGENDR == 1, "Male", "Female"),
    race = case_when(
      RIDRETH3 == 1 ~ "Mexican American",
      RIDRETH3 == 2 ~ "Other Hispanic",
      RIDRETH3 == 3 ~ "Non-Hispanic White",
      RIDRETH3 == 4 ~ "Non-Hispanic Black",
      RIDRETH3 == 5 ~ "Non-Hispanic Asian",
      TRUE ~ "Other" ),
    age_group = case_when(
      RIDAGEYR < 40 ~ "20-39",
      RIDAGEYR < 60 ~ "40-59",
      TRUE ~ "60+" ),
    bmi_group = case_when(
      BMXBMI < 18.5 ~ "Underweight",
      BMXBMI < 25 ~ "Normal",
      BMXBMI < 30 ~ "Overweight",
      TRUE ~ "Obese" ) )

saveRDS(clean_data, "clean_data.rds")

dim(clean_data)
table(clean_data$smoking, clean_data$hypertension)