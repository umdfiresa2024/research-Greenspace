# How does high tempuratures affect mental health in Baltimore City?


Step 1. Install necessary packages.

``` r
install.packages("tidyverse")
install.packages("kableExtra")
```

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
df2<-df %>%
  mutate(call_bin = ifelse(callscount>0, 1, 0)) %>%
  mutate(date = as.Date(date)) %>%
  mutate(month = month(date)) %>%
  mutate(dow = weekdays(date))
```

Step 5. Use the **head** and **kable** function showcase the first 10
rows of the dataframe to the reader.

``` r
kable(head(df2))
```

| daytime | policeDistrict | date       | actual_date | year | doy |   temp_K | callscount |   temp_F | call_bin | month | dow      |
|--------:|:---------------|:-----------|------------:|-----:|----:|---------:|-----------:|---------:|---------:|------:|:---------|
|       0 | Central        | 2021-06-06 |     2021156 | 2021 | 156 | 294.5450 |          0 | 70.51100 |        0 |     6 | Sunday   |
|       0 | Central        | 2021-06-07 |     2021157 | 2021 | 157 | 296.9489 |          0 | 74.83800 |        0 |     6 | Monday   |
|       0 | Central        | 2021-06-08 |     2021158 | 2021 | 158 | 298.5400 |          0 | 77.70200 |        0 |     6 | Tuesday  |
|       0 | Central        | 2021-06-17 |     2021167 | 2021 | 167 | 293.4029 |          0 | 68.45514 |        0 |     6 | Thursday |
|       0 | Central        | 2021-06-19 |     2021169 | 2021 | 169 | 292.4600 |          0 | 66.75800 |        0 |     6 | Saturday |
|       0 | Central        | 2021-06-26 |     2021176 | 2021 | 176 | 292.9914 |          0 | 67.71457 |        0 |     6 | Saturday |

## Question 1: What is the frequency of this data frame?

Answer: Daily- day and night

## Question 2: What is the cross-sectional (geographical) unit of this data frame?

Answer: Police district

Step 6. Use the **names** function to display all the variables (column)
in the dataframe.

``` r
names(df2)
```

     [1] "daytime"        "policeDistrict" "date"           "actual_date"   
     [5] "year"           "doy"            "temp_K"         "callscount"    
     [9] "temp_F"         "call_bin"       "month"          "dow"           

## Question 3: Which column represents the treatment variable of interest?

Answer: temp_F

## Question 4: Which column represents the outcome variable of interest?

Answer: call_bin

Step 7: Create a boxplot to visualize the distribution of the outcome
variable under treatment and no treatment.

``` r
ggplot(df2, aes(x=temp_F)) +
  geom_boxplot() +
  facet_wrap(~call_bin)
```

![](README_files/figure-commonmark/unnamed-chunk-6-1.png)

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAaCAYAAADFTB7LAAAAcElEQVR4Xu3OwQmAQAxE0bClWYCW5N06tM6V2YPg5CjoF/JhLoHAi6iqn9eOefUbqrYvHY0cQDLyAlKRNyARmYA0ZMLRkAlGQyaU72tkAtlim7r/vJqDUDjlKBROOQyFU2icQuMUGqfQuBEaV1XPOwEx96nYACK8+wAAAABJRU5ErkJggg== "Run Current Chunk")

Step 8: Fit a regression model $y=\beta_0 + \beta_1 x + \epsilon$ where
$y$ is the outcome variable and $x$ is the treatment variable. Use the
**summary** function to display the results.

``` r
model1<-lm(call_bin ~ temp_F, data=df2)

summary(model1)
```


    Call:
    lm(formula = call_bin ~ temp_F, data = df2)

    Residuals:
         Min       1Q   Median       3Q      Max 
    -0.09024 -0.08269 -0.07875 -0.07461  0.92955 

    Coefficients:
                  Estimate Std. Error t value Pr(>|t|)    
    (Intercept)  0.0917032  0.0086954  10.546   <2e-16 ***
    temp_F      -0.0001999  0.0001329  -1.505    0.132    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 0.2703 on 8450 degrees of freedom
    Multiple R-squared:  0.0002679, Adjusted R-squared:  0.0001496 
    F-statistic: 2.264 on 1 and 8450 DF,  p-value: 0.1324

## Question 7: What is the equation that describes the linear regression above? Please include an explanation of the variables and subscripts.

Answer:

$$
callscount_{pdt} = \beta_0 + \beta_1 temp_{pdt} + \gamma_p + \eta_d + \theta_{dayofweek} + \omega_{month} + \pi_year+\epsilon_{pdt}
$$

Where $callscount$ represents the outcome variable that shows whether
there a call from police district \$p\$, on day \$d\$, at time of day
\$t\$.

Where $temp$ determines the temperature in Fahrenheit.

## Question 8: What fixed effects can be included in the regression? What does each fixed effects control for? Please include a new equation that incorporates the fixed effects.

Answer:

Police district: controls for better or worse conditions in the city

Daytime: controls the differences that might occur based on the time of
day

Year: controls any differences that might have occurred one year to
another

## Question 9: What is the impact of the treatment effect once fixed effects are included?

Answer:

``` r
#install.packages("lfe")
library("lfe")
```

    Loading required package: Matrix


    Attaching package: 'Matrix'

    The following objects are masked from 'package:tidyr':

        expand, pack, unpack

``` r
model2<-felm(call_bin ~ temp_F + daytime + temp_F:daytime| 
               policeDistrict + year + month + dow, data=df2)

summary(model2)
```


    Call:
       felm(formula = call_bin ~ temp_F + daytime + temp_F:daytime |      policeDistrict + year + month + dow, data = df2) 

    Residuals:
         Min       1Q   Median       3Q      Max 
    -0.17312 -0.09836 -0.07288 -0.04830  0.98544 

    Coefficients:
                     Estimate Std. Error t value Pr(>|t|)
    temp_F          1.930e-04  4.406e-04   0.438    0.661
    daytime        -2.704e-02  2.037e-02  -1.327    0.184
    temp_F:daytime -3.456e-05  3.188e-04  -0.108    0.914

    Residual standard error: 0.2689 on 8421 degrees of freedom
    Multiple R-squared(full model): 0.0145   Adjusted R-squared: 0.01099 
    Multiple R-squared(proj model): 0.002268   Adjusted R-squared: -0.001287 
    F-statistic(full model): 4.13 on 30 and 8421 DF, p-value: 2.94e-13 
    F-statistic(proj model):  6.38 on 3 and 8421 DF, p-value: 0.0002584 
    *** Standard errors may be too high due to more than 2 groups and exactDOF=FALSE

``` r
df3<-df2 %>%
  mutate(temp_over_100=ifelse(temp_F>100, 1, 0)) %>%
  mutate(temp_90_100=ifelse(temp_F>90 & temp_F<=100, 1, 0)) %>%
  mutate(temp_85_90=ifelse(temp_F> 85 & temp_F<=90, 1, 0)) %>%
  mutate(temp_80_85=ifelse(temp_F>80 & temp_F<=85, 1, 0)) %>%
  mutate(temp_70_80=ifelse(temp_F>70 & temp_F<=80, 1, 0)) %>%
  mutate(temp_60_70=ifelse(temp_F>60 & temp_F<=70, 1, 0)) %>%
  mutate(temp_under_60=ifelse(temp_F<= 60, 1, 0))

model2<-felm(call_bin ~ temp_over_100 + temp_90_100 + temp_85_90 + temp_80_85 + temp_70_80 + temp_60_70 + temp_under_60 +
               daytime + 
               temp_over_100:daytime + temp_90_100:daytime + temp_85_90:daytime + temp_80_85:daytime + temp_70_80:daytime + temp_60_70:daytime + temp_under_60:daytime| 
               policeDistrict + year + month + dow, data=df3)
```

    Warning in chol.default(mat, pivot = TRUE, tol = tol): the matrix is either
    rank-deficient or not positive definite

``` r
summary(model2)
```

    Warning in chol.default(mat, pivot = TRUE, tol = tol): the matrix is either
    rank-deficient or not positive definite


    Call:
       felm(formula = call_bin ~ temp_over_100 + temp_90_100 + temp_85_90 +      temp_80_85 + temp_70_80 + temp_60_70 + temp_under_60 + daytime +      temp_over_100:daytime + temp_90_100:daytime + temp_85_90:daytime +      temp_80_85:daytime + temp_70_80:daytime + temp_60_70:daytime +      temp_under_60:daytime | policeDistrict + year + month + dow,      data = df3) 

    Residuals:
         Min       1Q   Median       3Q      Max 
    -0.17697 -0.09818 -0.07249 -0.04738  1.00262 

    Coefficients:
                            Estimate Std. Error t value Pr(>|t|)
    temp_over_100                NaN         NA     NaN      NaN
    temp_90_100           -0.0206669  0.0208660  -0.990    0.322
    temp_85_90            -0.0085362  0.0229053  -0.373    0.709
    temp_80_85            -0.0424379  0.0547127  -0.776    0.438
    temp_70_80             0.0182557  0.0177363   1.029    0.303
    temp_60_70             0.0124341  0.0147016   0.846    0.398
    temp_under_60                NaN         NA     NaN      NaN
    daytime                0.0019254  0.0237888   0.081    0.935
    temp_over_100:daytime        NaN         NA     NaN      NaN
    temp_90_100:daytime          NaN         NA     NaN      NaN
    temp_85_90:daytime           NaN         NA     NaN      NaN
    temp_80_85:daytime    -0.0002367  0.0613340  -0.004    0.997
    temp_70_80:daytime    -0.0310445  0.0353878  -0.877    0.380
    temp_60_70:daytime    -0.0434896  0.0340055  -1.279    0.201
    temp_under_60:daytime -0.0253033  0.0253106  -1.000    0.317

    Residual standard error: 0.2689 on 8414 degrees of freedom
    Multiple R-squared(full model): 0.01537   Adjusted R-squared: 0.01104 
    Multiple R-squared(proj model): 0.003143   Adjusted R-squared: -0.001241 
    F-statistic(full model):3.549 on 37 and 8414 DF, p-value: 2.313e-12 
    F-statistic(proj model): 1.769 on 15 and 8414 DF, p-value: 0.03302 
    *** Standard errors may be too high due to more than 2 groups and exactDOF=FALSE

## Question 10: What are the next steps of your research?

- Identify factors that impacts temperature and number of calls at the
  same time.

  - precipitation

  - trees

  - air quality

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
