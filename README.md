# Project Data Analysis for Finance: Branch Performances in R PART-1

## > BACKGROUND ──

<sup><b>DQLab</b></sup> Project, illustrating about a finance company that distributes financing to the community through branches of its company spread across various regions, there are agents in charge of finding and listing potential partners who will apply for loans to the company.

this <b>project focuses on the performance of each branch of the company.</b>



## A SIMPLE GUIDE STEP-BY-STEP DATASET PROCESSING (1) ──

#### →   filtering the dataset, focused on the May 2020 time period

#### →   Create a summary per branch to see the best and worst five branches of data

#### →   As branches increase each month, it is necessary to check the age & performance each of it</h4>

#### →   Looking for the worst branches for each age group</h4>



## > IMPLEMENTATION R PACKAGES ──

#### ⋈ DPLYR ─ suitable for data manipulating & analytic

* `select()`    ⍽ variable selection

* `filter()`    ⍽ variable value filtration
						
* `mutate()`    ⍽ new variable creation based on the existed variable
						
* `summarise()` ⍽ variable value summarization
						
* `arrange()`   ⍽ variable arrangement based on it values

#### ⋈ GGPLOT2 ─ suitable for data visualization using plot function

            	⌐ syntax :> ggplot(data) + geom_type(aes(x,y,fill,color)) 

#### ⋈ SCALES ─ suitable for supporting the process of data exploration

* `comma()`   ⍽ variable format conversion (numerical format + separators)
						
* `percent()` ⍽ variable format conversion (numerical format + percent symbol)



## > LOAN DISBURSEMENT DATASET ──

### ⋈ Load <sup><b>DQLab</b></sup> Dataset ::

			⌐ df_loan <- read.csv('https://dqlab-dataset.s3-ap-southeast-1.amazonaws.com/loan_disbursement.csv', stringsAsFactors = F)
	
* `stringAsFactors` ⍽ to make the char. data type don't reformat to factor



## > ADDITIONAL INFORMATION ──

#### ⋈ R Vers. 4.0.2

#### ⋈ Rstudio Vers. 1.3.1073

───────────────────────────────────────────────────────────────────────────────────
