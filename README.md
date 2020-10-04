# Project Data Analysis for Finance: Branch Performances in R PART-1

<h3>>    BACKGROUND ──</h3>

<sup><b>DQLab</b></sup> Project, illustrating about a finance company that distributes financing to the community through branches of its company spread across various regions, there are agents in charge of finding and listing potential partners who will apply for loans to the company.

this <b>project focuses on the performance of each branch of the company.</b>

───────────────────────────────────────────────────────────────────────────────────

<h3>>    A SIMPLE GUIDE STEP-BY-STEP DATASET PROCESSING (1) ──</h3>

<h4>→   filtering the dataset, focused on the May 2020 time period</h4>

<h4>→   Create a summary per branch to see the best and worst five branches of data</h4>

<h4>→   As branches increase each month, it is necessary to check the age & performance each of it</h4>

<h4>→   Looking for the worst branches for each age group</h4>

───────────────────────────────────────────────────────────────────────────────────

<h3>>    IMPLEMENTATION R PACKAGES ──</h3>

<b>⋈</b>  <strong>DPLYR ─ suitable for data manipulating & analytic </strong>

* `select()`    ⍽ variable selection

* `filter()`    ⍽ variable value filtration
						
* `mutate()`    ⍽ new variable creation based on the existed variable
						
* `summarise()` ⍽ variable value summarization
						
* `arrange()`   ⍽ variable arrangement based on it values

<b>⋈</b>   <strong>GGPLOT2 ─ suitable for data visualization using plot function </strong>

            	⌐ syntax :> ggplot(data) + geom_type(aes(x,y,fill,color)) 

<b>⋈</b> <strong>SCALES ─ suitable for supporting the process of data exploration </strong>

* `comma()`   ⍽ variable format conversion (numerical format + separators)
						
* `percent()` ⍽ variable format conversion (numerical format + percent symbol)

───────────────────────────────────────────────────────────────────────────────────

<h3>>    LOAN DISBURSEMENT DATASET ──</h3>

<b>⋈</b>   <strong>Load <sup><b>DQLab</b></sup> Dataset :: </strong>

			⌐ df_loan <- read.csv('https://dqlab-dataset.s3-ap-southeast-1.amazonaws.com/loan_disbursement.csv', stringsAsFactors = F)
	
* `stringAsFactors` ⍽ to make the char. data type don't reformat to factor

───────────────────────────────────────────────────────────────────────────────────

<h3>>    ADDITIONAL INFORMATION ──</h3>

<b>⋈</b>   <strong>R Vers. 4.0.2</strong>

<b>⋈</b>   <strong>Rstudio Vers. 1.3.1073</strong>

───────────────────────────────────────────────────────────────────────────────────
