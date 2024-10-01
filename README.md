# How does high tempuratures affect mental health in Baltimore City?


Step 1. Install necessary packages.

``` r
install.packages("tidyverse")
```

    Installing package into '/cloud/lib/x86_64-pc-linux-gnu-library/4.4'
    (as 'lib' is unspecified)

``` r
install.packages("kableExtra")
```

    Installing package into '/cloud/lib/x86_64-pc-linux-gnu-library/4.4'
    (as 'lib' is unspecified)

Step 2. Declare that you will use these packages in this session.

``` r
library("tidyverse")
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
    ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
    ✔ purrr     1.0.2     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library("kableExtra")
```


    Attaching package: 'kableExtra'

    The following object is masked from 'package:dplyr':

        group_rows

Step 3. Upload the dataframe that you have created in Spring 2024 into
the repository.

Step 4. Open the dataframe into the RStudio Environment.

``` r
df<-read.csv("panel.csv")
```

Step 5. Use the **head** and **kable** function showcase the first 10
rows of the dataframe to the reader.

``` r
kable(head(df))
```

| daytime | policeDistrict | date | actual_date | year | doy | temp_K | callscount | temp_F |
|---:|:---|:---|---:|---:|---:|---:|---:|---:|
| 0 | Central | 2021-06-06 | 2021156 | 2021 | 156 | 294.5450 | 0 | 70.51100 |
| 0 | Central | 2021-06-07 | 2021157 | 2021 | 157 | 296.9489 | 0 | 74.83800 |
| 0 | Central | 2021-06-08 | 2021158 | 2021 | 158 | 298.5400 | 0 | 77.70200 |
| 0 | Central | 2021-06-17 | 2021167 | 2021 | 167 | 293.4029 | 0 | 68.45514 |
| 0 | Central | 2021-06-19 | 2021169 | 2021 | 169 | 292.4600 | 0 | 66.75800 |
| 0 | Central | 2021-06-26 | 2021176 | 2021 | 176 | 292.9914 | 0 | 67.71457 |

## Question 1: What is the frequency of this data frame?

Answer: Daily- day and night

## Question 2: What is the cross-sectional (geographical) unit of this data frame?

Answer: Police district

Step 6. Use the **names** function to display all the variables (column)
in the dataframe.

``` r
names(df)
```

    [1] "daytime"        "policeDistrict" "date"           "actual_date"   
    [5] "year"           "doy"            "temp_K"         "callscount"    
    [9] "temp_F"        

## Question 3: Which column represents the treatment variable of interest?

Answer: temp_F

## Question 4: Which column represents the outcome variable of interest?

Answer: callscount

Step 7: Create a boxplot to visualize the distribution of the outcome
variable under treatment and no treatment.

``` r
ggplot(df, aes(x=nox_emit)) +
  geom_histogram() +
  facet_wrap(~nbp)
```

Step 8: Fit a regression model $y=\beta_0 + \beta_1 x + \epsilon$ where
$y$ is the outcome variable and $x$ is the treatment variable. Use the
**summary** function to display the results.

``` r
model1<-lm(callscount ~ temp_F, data=df)

summary(model1)
```


    Call:
    lm(formula = callscount ~ temp_F, data = df)

    Residuals:
        Min      1Q  Median      3Q     Max 
    -0.0958 -0.0897 -0.0864 -0.0831  4.9135 

    Coefficients:
                  Estimate Std. Error t value Pr(>|t|)    
    (Intercept)  0.0970396  0.0099890   9.715   <2e-16 ***
    temp_F      -0.0001636  0.0001526  -1.072    0.284    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 0.3106 on 8450 degrees of freedom
    Multiple R-squared:  0.000136,  Adjusted R-squared:  1.767e-05 
    F-statistic: 1.149 on 1 and 8450 DF,  p-value: 0.2837

## Question 5: What is the predicted value of the outcome variable when treatment=0?

Answer: N/A

## Question 6: What is predicted value of the outcome variable when treatment=1?

Answer: N/A

## Question 7: What is the equation that describes the linear regression above? Please include an explanation of the variables and subscripts.

Answer:

$$
callscount = \beta_0 + \beta_1 temp_F + \epsilon
$$

## Question 8: What fixed effects can be included in the regression? What does each fixed effects control for? Please include a new equation that incorporates the fixed effects.

Answer: add fix_fx for every police district

Police district: controls for better or worse conditions in the city

Daytime:

Year:

## Question 9: What is the impact of the treatment effect once fixed effects are included?

Answer:

``` r
install.packages("lfe")
```

    Installing package into '/cloud/lib/x86_64-pc-linux-gnu-library/4.4'
    (as 'lib' is unspecified)

``` r
library("lfe")
```

    Loading required package: Matrix


    Attaching package: 'Matrix'

    The following objects are masked from 'package:tidyr':

        expand, pack, unpack

``` r
#model2<-lm(temp_F ~ callscount | policeDistrict + daytime + year, data=df)
```

# Questions for Week 5

## Question 10: In a difference-in-differences (DiD) model, what is the treatment GROUP?

Answer:

## Question 11: In a DiD model, what are the control groups?

Answer:

## Question 12: What is the DiD regression equation that will answer your research question?

## Question 13: Run your DiD regressions below. What are the results of the DiD regression?

## Question 14: What are the next steps of your research?

Step 9: Change the document format to gfm

Step 10: Save this document as README.qmd

Step 11: Render the document. README.md file should be created after
this process.

Step 12: Push the document back to GitHub and observe your beautiful
document in your repository!

Step 13: If your team has a complete dataframe that includes both the
treated and outcome variable, you are done with the assignment. If not,
make a research plan in Notion to collect data on the outcome and
treatment variable and combine it into one dataframe.
