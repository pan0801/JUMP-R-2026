# 01_import.R
library(haven)
library(dplyr)

demo <- read_xpt("DEMO_J.XPT")
bmx <- read_xpt("BMX_J.XPT")
bpq <- read_xpt("BPQ_J.XPT")
smq <- read_xpt("SMQ_J.XPT")

merged <- demo %>%
  select(SEQN, RIDAGEYR, RIAGENDR, RIDRETH3) %>%
  left_join(bmx %>% select(SEQN, BMXBMI), by = "SEQN") %>%
  left_join(bpq %>% select(SEQN, BPQ020), by = "SEQN") %>%
  left_join(smq %>% select(SEQN, SMQ020, SMQ040), by = "SEQN")

saveRDS(merged, "merged_raw.rds")
