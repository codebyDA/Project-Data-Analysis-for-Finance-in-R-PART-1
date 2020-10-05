## install required packages
install.packages("dplyr")
install.packages("ggplot2")
install.packages("scales")


### running the library functions
library(dplyr)
library(ggplot2)
library(scales)

#---------------------------------------------------------------------------------------------

## LOAN DISBURSEMENT DATASET ── READ FILE (rds format)
### dataset extracted into df_loan var.
df_loan <- read.csv('https://dqlab-dataset.s3-ap-southeast-1.amazonaws.com/loan_disbursement.csv', stringsAsFactors = F)

## print dataset var.
dplyr::glimpse(df_loan)

#---------------------------------------------------------------------------------------------

## STEP (01) || Data summary for Mei 2020 time period ──

### → Filter May 2020 data & data summation per branch
df_loan_mei <- df_loan %>%
  filter(tanggal_cair >= '2020-05-01', tanggal_cair <= '2020-05-31') %>%
  group_by(cabang) %>%
  summarise(total_amount = sum(amount))

### → Show the data of five branches with the thest total amount
df_loan_mei %>% 
  arrange(desc(total_amount)) %>% 
  mutate(total_amount = comma(total_amount)) %>% 
  head(5)

### → Show the data of five branches with the least total amount
df_loan_mei %>% 
  arrange(total_amount) %>% 
  mutate(total_amount = comma(total_amount)) %>% 
  head(5)

### → CONCLUSION ::
#### It shows significance gap values between the least-thest total amounts
#### as it caused by the exponential branch growth each month periodically.

#---------------------------------------------------------------------------------------------

## STEP (02) || The insight of the relation between age branch & total amount ──

### → Branch age calculation (month format)
df_cabang_umur <- df_loan %>% 
  group_by(cabang) %>%
  summarise(pertama_cair = min(tanggal_cair)) %>% 
  mutate(umur = as.numeric(as.Date('2020-05-15') - as.Date(pertama_cair)) %/% 30)

### → Combination of branch age & performance (total amount) data (May)
df_loan_mei_umur <- df_cabang_umur %>% 
  inner_join(df_loan_mei, by = 'cabang') 

### → relation between branch age & performance (total amount) data (May) plot visualization
###   *(scatter-plot graphic)
ggplot(df_loan_mei_umur, aes(x = umur, y = total_amount)) +
  geom_point() +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "As it Gets Older, The Performance of The Branch Gets Better",
       x = "Age (month)", y = "Total Amount")

### → CONCLUSION ::
#### It shows the positive result of a linear relationship
#### between branch age and performance data.
#### But there's bad performance data in each age occurred.

#---------------------------------------------------------------------------------------------

## STEP (03) || Low performance (total amount) branch based on the age of branch ──

### → Searching the low branch performance (total amount) for every age
df_loan_mei_flag <- df_loan_mei_umur %>% 
  group_by(umur) %>% 
  mutate(Q1 = quantile(total_amount, 0.25),
         Q3 = quantile(total_amount, 0.75), 
         IQR = (Q3 - Q1)) %>% 
  mutate(flag = ifelse(total_amount < (Q1 - IQR), 'Bad Performance', 'Good Performance')) 

df_loan_mei_flag %>% 
  filter(flag == 'Bad Performance') %>% 
  mutate_if(is.numeric, list(comma))

### → Branch performance (total amount) scatter-plot visualization
ggplot(df_loan_mei_flag, aes(x = umur, y = total_amount)) +
  geom_point(aes(color = flag)) +
  scale_color_manual(breaks = c("Good Performance", "Bad Performance"),
                     values = c("green", "red")) +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Visualization of Bad Performance Branch in Particular Age Periodic",
       color = "", x = "Age (month)", y = "Total Amount")


#---------------------------------------------------------------------------------------------

## STEP (04) || Low performance (total amount) branch analytics ──

### → Branch performance (total amount) comparison at the same age (at 3 months age)
df_loan_mei_flag %>% 
  filter(umur == 3) %>% 
  inner_join(df_loan, by = 'cabang') %>% 
  filter(tanggal_cair >= '2020-05-01', tanggal_cair <= '2020-05-31') %>% 
  group_by(cabang, flag)  %>% 
  summarise(jumlah_hari = n_distinct(tanggal_cair),
            agen_aktif = n_distinct(agen),
            total_loan_cair = n_distinct(loan_id),
            avg_amount = mean(amount), 
            total_amount = sum(amount)) %>% 
  arrange(total_amount) %>% 
  mutate_if(is.numeric, list(comma))

### → Low branch performance (total amount) comparison
df_loan_mei_flag %>% 
  filter(umur == 3, flag == 'Bad Performance') %>% 
  inner_join(df_loan, by = 'cabang') %>% 
  filter(tanggal_cair >= '2020-05-01', tanggal_cair <= '2020-05-31') %>% 
  group_by(cabang, agen) %>% 
  summarise(jumlah_hari = n_distinct(tanggal_cair),
            total_loan_cair = n_distinct(loan_id),
            avg_amount = mean(amount), 
            total_amount = sum(amount)) %>% 
  arrange(total_amount) %>% 
  mutate_if(is.numeric, list(comma))

### → The agents of branch performance (total amount) comparison at three months consecutive
df_loan %>% 
  filter(cabang == 'AH') %>% 
  filter(tanggal_cair >= '2020-05-01', tanggal_cair <= '2020-05-31') %>% 
  group_by(cabang, agen) %>% 
  summarise(jumlah_hari = n_distinct(tanggal_cair),
            total_loan_cair = n_distinct(loan_id),
            avg_amount = mean(amount), 
            total_amount = sum(amount)) %>% 
  arrange(total_amount) %>% 
  mutate_if(is.numeric, list(comma))

### → CONCLUSION ::
#### The low performance of the 'AE' branch is because one of the agents that
#### perform disbursement only four days in 1 month when the other agent can be active 21 days.
####
#### This makes the total amount of the agent, only 20% compared to other agents.
####
#### While in the 'AH' branch, the performance is outstanding because all three agents do
#### disbursement almost /always every weekday. 2 people full 21 days one person 19 days.
####
#### So the performance is well maintained.