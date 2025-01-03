# How does high tempuratures affect mental health in Baltimore City?


This code segment is for installing packages:

``` r
install.packages("tidyverse")
install.packages("kableExtra")

install.packages("terra")
```

These are the packages we will be using:

``` r
library("tidyverse")
library("kableExtra")
library("terra")
```

This code segment is for opening the csv file and storing the contents
in a dataframe df. 4 additional columns are created for call_bin, date,
month. dow.

``` r
df<-read.csv("panel.csv")
df2<-df %>%
  mutate(call_bin = ifelse(callscount>0, 1, 0)) %>%
  mutate(date = as.Date(date)) %>%
  mutate(year = year(date)) %>%
  mutate(month = month(date)) %>%
  mutate(dow = weekdays(date))
```

The table below shows the first ten observations of our data frame.

``` r
kable(head(df2))
```

| policeDistrict | date | temp_K | callscount | temp_F | call_bin | year | month | dow |
|:---|:---|---:|---:|---:|---:|---:|---:|:---|
| Central | 2021-06-06 | 302.3536 | 0 | 84.56650 | 0 | 2021 | 6 | Sunday |
| Central | 2021-06-07 | 306.9233 | 0 | 92.79200 | 0 | 2021 | 6 | Monday |
| Central | 2021-06-08 | 298.5400 | 0 | 77.70200 | 0 | 2021 | 6 | Tuesday |
| Central | 2021-06-14 | 308.7900 | 0 | 96.15200 | 0 | 2021 | 6 | Monday |
| Central | 2021-06-16 | 310.7467 | 0 | 99.67400 | 0 | 2021 | 6 | Wednesday |
| Central | 2021-06-17 | 300.3714 | 0 | 80.99857 | 0 | 2021 | 6 | Thursday |

## Introduction & Literature Review:

Understanding how temperature affects mental health is crucial for
society. With rising global temperatures, we will have to be prepared
for any impacts that may cause. The years from 2013 to 2023 have been
the warmest to date, with 2023 having the highest surface temperature
ever recorded (NASA, n.d). High temperatures were studied in Baltimore
city through in depth interviews where it was found that at higher heats
people were more prone to mental health problems such as depression and
anxiety. Especially disadvantaged individuals such as people who are
low-income, have disabilities, are homeless, pregnant, elderly people
and children (Diallo et al., 2024). If we were to discover more impacts
that temperature has on individuals, it could guide urban planners to
plan future cities so that they would include public spaces throughout
the city. Additionally, by understanding the psychological effects of
temperature, governments and healthcare providers can better prepare
interventions, such as improving access to mental health services during
extreme temperatures. This research could also lead to targeted policies
that aim to mitigate the mental health impacts of climate change,
ultimately improving societal well-being.

This research project aims to provide the most concentrated area example
of the impacts of temperature on mental health. While existing studies
have found links between mental health worsening and high temperatures,
most have done so for the whole country of the US by county, which makes
it more difficult to definitively control for other factors (Burke et
al., 2018; Srivastava & Mullins., 2024). The data used by Burke et
al. (2018) is based on suicide rates and is from 1968–2004 in the US and
1990-2010 in Mexico by county and analyzed monthly. They found a 0.7%
suicide rate increase in the US per 1.8 degrees Fahrenheit increase in
monthly temperature. 

Srivastava & Mullins (2024) compared the daily frequencies of crisis
line conversations from each county with local average daily
temperatures. They found an 8% increase in crisis line conversations on
days exceeding 86 degrees Fahrenheit compared to days between 64.4 to
69.8 degrees Fahrenheit. 

Besides existing studies on the link between temperatures and mental
health, there are many studies that looked at the impact of temperature
on crime rates. Heilmann et al. (2021) discovered that crime rates in
Los Angeles police districts increase 1.72% when daily temperature
exceeds 75 and 1.90% when daily temperature exceeds 75 and 90 degrees
Fahrenheit. 

Our study will differ from existing studies on temperature and mental
health on several key points. We will be analyzing a more controlled
location and group, focussing on Baltimore City, allowing us to control
for factors specific to the police district. We will be using some of
the same strategies as other studies (Burke et al., 2018; Srivastava &
Mullins., 2024; Heilmann et al., 2021) such as controlling for factors
of precipitation, air quality, and holidays. As well as adding an extra
factor of our own, greenspace. Our data will be more modern mental
health crisis call data from 2021-2023 and analyzed daily to account for
factors such as day of week.

## Methods:

The frequency of this data frame is Daily.

The cross-sectional unit of this data frame is the Police district.

The column the treatment variable of interest in temp_F.

The column that represents the outcome variable of interest is call_bin.

This code block displays all of the variables in df2.

``` r
names(df2)
```

    [1] "policeDistrict" "date"           "temp_K"         "callscount"    
    [5] "temp_F"         "call_bin"       "year"           "month"         
    [9] "dow"           

Shows 2 scatter plots split by winter and summer. Compares the average
number of calls received with the temperature by police district.

First scatter plot represents the relationship between the temperature
and the amount of calls received based on the police districts during
winter. Second scatter plot represents the same relationship but for the
summer.

``` r
# histogram or scatterplots
# total number of calls
# x -> temp_F, y -> callscount (avg for scatterplot)
# groupBy policeDistrict

#----------------------------------------------------------------------------------------------
df2 <- df2 %>%
  mutate(tempCatagories = ifelse(temp_F < 10, 0,
                          ifelse(temp_F >= 10 & temp_F < 20, 10,
                          ifelse(temp_F >= 20 & temp_F < 30, 20,
                          ifelse(temp_F >= 30 & temp_F < 40, 30,
                          ifelse(temp_F >= 40 & temp_F < 50, 40,
                          ifelse(temp_F >= 50 & temp_F < 60, 50,
                          ifelse(temp_F >= 60 & temp_F < 65, 60,
                          ifelse(temp_F >= 65 & temp_F < 70, 65,
                          ifelse(temp_F >= 70 & temp_F < 75, 70,
                          ifelse(temp_F >= 75 & temp_F < 80, 75,
                          ifelse(temp_F >= 80 & temp_F < 85, 80,
                          ifelse(temp_F >= 85 & temp_F < 90, 85,
                          ifelse(temp_F >= 90 & temp_F < 95, 90,
                          ifelse(temp_F >= 95 & temp_F < 100, 95, 
                          100)))))))))))))))

# if 0 -> summer (4 - 9)
# if 1 -> winter (11 - 2)
# if 2 -> march and october
df2 <- df2 %>%
  mutate(seasons = ifelse(month >= 4 & month <= 9, 0,
                      ifelse(month <= 2 | month >= 11, 1,
                             2)))
         
# for winter
winter_df <- df2 %>%
  filter(seasons == 1) %>%
  group_by(policeDistrict, tempCatagories) %>%
  summarise(avg_calls = mean(callscount, na.rm = TRUE))

# for summer
summer_df <- df2 %>%
  filter(seasons == 0) %>%
  group_by(policeDistrict, tempCatagories) %>%
  summarise(avg_calls = mean(callscount, na.rm = TRUE))

# Scatter plot -winter
greenPalette <- c("#003300", "#004d00", "#006600", "#008000", "#009900", "#00b300", "#00cc00", "#33cc33", "#66ff66")

ggplot(winter_df, aes(x = tempCatagories, y = avg_calls, color = policeDistrict)) + 
  geom_point(size = 2) + 
  geom_smooth(se = FALSE) +
  scale_color_manual(values = greenPalette) +
  labs(title = "Average Number of Calls vs Temperature (F) by Police District (Winter 11-2)",
       x = "Temperature Range (F)", 
       y = "Average Number of Calls") +
  theme_bw()
```

![](README_files/figure-commonmark/unnamed-chunk-6-1.png)

``` r
# Scatter plot -summer
ggplot(summer_df, aes(x = tempCatagories, y = avg_calls, color = policeDistrict)) + 
  geom_point(size = 2) + 
  geom_smooth(se = FALSE) +
  scale_color_manual(values = greenPalette) +
  #scale_color_manual(values = c("#006400", "#228B22", "#32CD32", "#7FFF00", "#ADFF2F")) +
  labs(title = "Average Number of Calls vs Temperature (F) by Police District (Summer 4-9)",
       x = "Temperature Range (F)", 
       y = "Average Number of Calls") +
  theme_bw()
```

![](README_files/figure-commonmark/unnamed-chunk-6-2.png)

  
The following shows our regression model
$y=\beta_0 + \beta_1 x + \epsilon$ where $y$ is the outcome variable and
$x$ is the treatment variable.

``` r
model1<-lm(call_bin ~ temp_F, data=df2)

summary(model1)
```


    Call:
    lm(formula = call_bin ~ temp_F, data = df2)

    Residuals:
        Min      1Q  Median      3Q     Max 
    -0.1706 -0.1611 -0.1548 -0.1489  0.8579 

    Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
    (Intercept) 0.1389938  0.0148053   9.388   <2e-16 ***
    temp_F      0.0002887  0.0002267   1.274    0.203    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 0.3637 on 5762 degrees of freedom
    Multiple R-squared:  0.0002814, Adjusted R-squared:  0.0001079 
    F-statistic: 1.622 on 1 and 5762 DF,  p-value: 0.2029

Our linear regression equation.

$$
callscount_{pdt} = \beta_0 + \beta_1 temp_{pdt} + \gamma_p + \eta_d + \theta_{dayofweek} + \omega_{month} + \pi_{year}+\epsilon_{pdt}
$$

Where $callscount$ represents the outcome variable that shows whether
there a call from police district \$p\$, on day \$d\$, at time of day
\$t\$.

Where $temp$ determines the temperature in Fahrenheit.

Data Description:

- Outcome variable: whether there was a call or not per day.

- Treatment variable: temperature

- Frequency and geographical Unit: daily day and night and police
  district

- Treated Group: \# of call on a hot weekday in a specific month in a
  police district

- Untreated Group:# of call on a cool weekday in a specific month in a
  police district

Fixed effects:

- Police district: controls for better or worse conditions in the city

- DOW: controls any differences that might have occurred one day to
  another

- Month: controls any differences that might have occurred one month to
  another

- Year: controls any differences that might have occurred one year to
  another

## 

The following code segments create new column holiday_bin is created
which represents whether there was a school holiday or or not.
Additionally, they create 4 regression models which help us understand
the effect temperature and holidays play on mental health calls. We
split these models for the winter and summer.

``` r
#install.packages("lfe")
library("lfe")

model2<-felm(call_bin ~ temp_F + temp_F| 
               policeDistrict + year + month + dow, data=df2)

summary(model2)
```


    Call:
       felm(formula = call_bin ~ temp_F + temp_F | policeDistrict +      year + month + dow, data = df2) 

    Residuals:
         Min       1Q   Median       3Q      Max 
    -0.31499 -0.17658 -0.13669 -0.09145  0.95254 

    Coefficients:
             Estimate Std. Error t value Pr(>|t|)
    temp_F -0.0002933  0.0004761  -0.616    0.538

    Residual standard error: 0.3605 on 5734 degrees of freedom
    Multiple R-squared(full model): 0.02211   Adjusted R-squared: 0.01716 
    Multiple R-squared(proj model): 6.621e-05   Adjusted R-squared: -0.004991 
    F-statistic(full model): 4.47 on 29 and 5734 DF, p-value: 1.747e-14 
    F-statistic(proj model): 0.3797 on 1 and 5734 DF, p-value: 0.5378 
    *** Standard errors may be too high due to more than 2 groups and exactDOF=FALSE

``` r
# for the temperature range
df3<-df2 %>%
  mutate(temp_over_100=ifelse(temp_F>100, 1, 0)) %>%
  mutate(temp_95_100=ifelse(temp_F> 95 & temp_F<=100, 1, 0)) %>%
  mutate(temp_90_95=ifelse(temp_F> 90 & temp_F<=95, 1, 0)) %>%
  mutate(temp_85_90=ifelse(temp_F> 85 & temp_F<=90, 1, 0)) %>%
  mutate(temp_80_85=ifelse(temp_F> 80 & temp_F<=85, 1, 0)) %>%
  mutate(temp_75_80=ifelse(temp_F> 75 & temp_F<=80, 1, 0)) %>%
  mutate(temp_70_75=ifelse(temp_F> 70 & temp_F<=75, 1, 0)) %>%
  mutate(temp_65_70=ifelse(temp_F> 65 & temp_F<=70, 1, 0)) %>%
  mutate(temp_60_65=ifelse(temp_F> 60 & temp_F<=65, 1, 0)) %>%
  mutate(temp_55_60=ifelse(temp_F> 55 & temp_F<=60, 1, 0)) %>%
  mutate(temp_50_55=ifelse(temp_F> 50 & temp_F<=55, 1, 0)) %>%
  mutate(temp_45_50=ifelse(temp_F> 45 & temp_F<=50, 1, 0)) %>%
  mutate(temp_40_45=ifelse(temp_F> 40 & temp_F<=45, 1, 0)) %>%
  mutate(temp_35_40=ifelse(temp_F> 35 & temp_F<=40, 1, 0)) %>%
  mutate(temp_30_35=ifelse(temp_F> 30 & temp_F<=35, 1, 0)) %>%
  mutate(temp_25_30=ifelse(temp_F> 25 & temp_F<=30, 1, 0)) %>%
  mutate(temp_20_25=ifelse(temp_F> 20 & temp_F<=25, 1, 0)) %>%
  mutate(temp_15_20=ifelse(temp_F> 15 & temp_F<=20, 1, 0)) %>%
  mutate(temp_10_15=ifelse(temp_F> 10 & temp_F<=15, 1, 0)) %>%
  mutate(temp_5_10=ifelse(temp_F> 5 & temp_F<=10, 1, 0)) %>%
  mutate(temp_0_5=ifelse(temp_F> 0 & temp_F<=5, 1, 0)) %>%
  mutate(temp_under_0=ifelse(temp_F<= 0, 1, 0))

#-------#

#2021 - 2022 (from the website: https://patch.com/maryland/baltimore/back-school-baltimore-city #-2021-22-school-calendar) (Not full but )
#2022 - 2023
#2023 - 2024 (upto Dec 31)

holidays <- as.Date(c(
"2021-5-31", "2021-6-19", "2021-7-4",

"2021-9-6", "2021-11-2", "2021-11-25", "2021-11-26", "2021-12-24", "2021-12-25", "2021-12-26", "2021-12-27", "2021-12-28", "2021-12-29", "2021-12-30", "2021-12-31", "2022-1-1", "2022-1-2", "2022-1-17", "2022-2-18", "2022-2-21", "2022-3-18", "2022-4-11", "2022-4-12", "2022-4-13", "2022-4-14", "2022-4-15", "2022-4-16", "2022-4-17", "2022-4-18", "2022-5-30", "2022-6-19", "2022-7-4",

"2022-9-5", "2022-10-5", "2022-10-21", "2022-11-8", "2022-11-9", "2022-11-23", "2022-11-24", "2022-11-25", "2022-12-23", "2022-12-24", "2022-12-25", "2021-12-26", "2022-12-27", "2022-12-28", "2022-12-29", "2022-12-30", "2022-12-31", "2023-01-01", "2023-1-2", "2023-1-16", "2023-1-23", "2023-2-17", "2023-2-20", "2023-3-8", "2023-3-17", "2023-4-3", "2023-4-4", "2023-4-5", "2023-4-6", "2023-4-7", "2023-4-8", "2023-4-9", "2023-4-10", "2023-4-21", "2023-5-29",  "2023-6-19", "2023-7-4", 

"2023-9-4", "2023-10-20", "2023-11-22", "2023-11-23", "2023-11-24", "2023-12-22", "2023-12-23", "2023-12-24", "2023-12-25", "2023-12-26", "2023-12-27", "2023-12-28", "2023-12-29", "2023-12-30", "2023-12-31"))

#For adding the holidays column into the data frame
df3 <- df3 %>%
  mutate(holiday_bin = ifelse(date %in% holidays, 1, 0))

#-------#
# split these into 2 for winter non winter months


# This is for the winter months

# We should focus on the tempurature range 45- 50 as it the most significant
df4w<-df3 %>%
  filter(seasons == 1)

model2<-felm(call_bin ~ temp_over_100 + temp_95_100 + temp_90_95 + temp_85_90 + temp_80_85 +
               temp_75_80 + temp_70_75 + temp_65_70 + temp_60_65 + temp_55_60 + temp_50_55 +                  temp_45_50 + temp_40_45 + temp_35_40 + temp_30_35 + temp_25_30 + temp_20_25 +                  temp_15_20 + temp_10_15 + temp_5_10 + temp_0_5 + temp_under_0  +
               holiday_bin |
               policeDistrict + year + month + dow, data=df4w)

summary(model2)
```


    Call:
       felm(formula = call_bin ~ temp_over_100 + temp_95_100 + temp_90_95 +      temp_85_90 + temp_80_85 + temp_75_80 + temp_70_75 + temp_65_70 +      temp_60_65 + temp_55_60 + temp_50_55 + temp_45_50 + temp_40_45 +      temp_35_40 + temp_30_35 + temp_25_30 + temp_20_25 + temp_15_20 +      temp_10_15 + temp_5_10 + temp_0_5 + temp_under_0 + holiday_bin |      policeDistrict + year + month + dow, data = df4w) 

    Residuals:
         Min       1Q   Median       3Q      Max 
    -0.43581 -0.16850 -0.11614 -0.05802  1.01332 

    Coefficients:
                    Estimate Std. Error t value Pr(>|t|)  
    temp_over_100        NaN         NA     NaN      NaN  
    temp_95_100          NaN         NA     NaN      NaN  
    temp_90_95           NaN         NA     NaN      NaN  
    temp_85_90           NaN         NA     NaN      NaN  
    temp_80_85           NaN         NA     NaN      NaN  
    temp_75_80           NaN         NA     NaN      NaN  
    temp_70_75    -0.2789767  0.2530253  -1.103   0.2704  
    temp_65_70    -0.4800848  0.2631810  -1.824   0.0683 .
    temp_60_65    -0.3456167  0.2520320  -1.371   0.1704  
    temp_55_60    -0.3183266  0.2480381  -1.283   0.1995  
    temp_50_55    -0.2843420  0.2471783  -1.150   0.2501  
    temp_45_50    -0.3196665  0.2464080  -1.297   0.1947  
    temp_40_45    -0.2885319  0.2463205  -1.171   0.2416  
    temp_35_40    -0.3042975  0.2463253  -1.235   0.2169  
    temp_30_35    -0.2976369  0.2466040  -1.207   0.2276  
    temp_25_30    -0.3045917  0.2470367  -1.233   0.2177  
    temp_20_25    -0.4198794  0.2513296  -1.671   0.0950 .
    temp_15_20    -0.3819878  0.2549112  -1.499   0.1342  
    temp_10_15    -0.1207773  0.2616363  -0.462   0.6444  
    temp_5_10     -0.4871404  0.3464731  -1.406   0.1599  
    temp_0_5             NaN         NA     NaN      NaN  
    temp_under_0         NaN         NA     NaN      NaN  
    holiday_bin    0.0006408  0.0228495   0.028   0.9776  
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 0.3449 on 1928 degrees of freedom
    Multiple R-squared(full model): 0.04744   Adjusted R-squared: 0.03015 
    Multiple R-squared(proj model): 0.009452   Adjusted R-squared: -0.00853 
    F-statistic(full model):2.743 on 35 and 1928 DF, p-value: 2.262e-07 
    F-statistic(proj model): 0.7998 on 23 and 1928 DF, p-value: 0.735 
    *** Standard errors may be too high due to more than 2 groups and exactDOF=FALSE

``` r
# This is for the summer months
df4s<-df3 %>%
  filter(seasons == 0)

model4<-felm(call_bin ~ temp_over_100 + temp_95_100 + temp_90_95 + temp_85_90 + temp_80_85 +
               temp_75_80 + temp_70_75 + temp_65_70 + temp_60_65 + temp_55_60 + temp_50_55 +                  temp_45_50 + temp_40_45 + temp_35_40 + temp_30_35 + temp_25_30 + temp_20_25 +                  temp_15_20 + temp_10_15 + temp_5_10 + temp_0_5 + temp_under_0  +
               holiday_bin |
               policeDistrict + year + month + dow, data=df4s)

summary(model4)
```


    Call:
       felm(formula = call_bin ~ temp_over_100 + temp_95_100 + temp_90_95 +      temp_85_90 + temp_80_85 + temp_75_80 + temp_70_75 + temp_65_70 +      temp_60_65 + temp_55_60 + temp_50_55 + temp_45_50 + temp_40_45 +      temp_35_40 + temp_30_35 + temp_25_30 + temp_20_25 + temp_15_20 +      temp_10_15 + temp_5_10 + temp_0_5 + temp_under_0 + holiday_bin |      policeDistrict + year + month + dow, data = df4s) 

    Residuals:
        Min      1Q  Median      3Q     Max 
    -0.4446 -0.1888 -0.1252 -0.0628  1.0078 

    Coefficients:
                  Estimate Std. Error t value Pr(>|t|)   
    temp_over_100 -0.77630    0.36452  -2.130  0.03328 * 
    temp_95_100   -0.84148    0.36351  -2.315  0.02069 * 
    temp_90_95    -0.85016    0.36313  -2.341  0.01929 * 
    temp_85_90    -0.86499    0.36279  -2.384  0.01718 * 
    temp_80_85    -0.86365    0.36288  -2.380  0.01738 * 
    temp_75_80    -0.85245    0.36285  -2.349  0.01887 * 
    temp_70_75    -0.79005    0.36285  -2.177  0.02954 * 
    temp_65_70    -0.84465    0.36295  -2.327  0.02003 * 
    temp_60_65    -0.80136    0.36300  -2.208  0.02735 * 
    temp_55_60    -0.85282    0.36332  -2.347  0.01898 * 
    temp_50_55    -0.85031    0.36535  -2.327  0.02002 * 
    temp_45_50    -0.86365    0.36827  -2.345  0.01909 * 
    temp_40_45    -0.88765    0.37021  -2.398  0.01656 * 
    temp_35_40    -0.80421    0.37567  -2.141  0.03238 * 
    temp_30_35    -1.01605    0.39011  -2.605  0.00925 **
    temp_25_30    -0.73156    0.40350  -1.813  0.06993 . 
    temp_20_25         NaN         NA     NaN      NaN   
    temp_15_20    -0.96762    0.40391  -2.396  0.01666 * 
    temp_10_15         NaN         NA     NaN      NaN   
    temp_5_10          NaN         NA     NaN      NaN   
    temp_0_5           NaN         NA     NaN      NaN   
    temp_under_0       NaN         NA     NaN      NaN   
    holiday_bin    0.05034    0.03037   1.658  0.09749 . 
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 0.3605 on 2818 degrees of freedom
    Multiple R-squared(full model): 0.05091   Adjusted R-squared: 0.03778 
    Multiple R-squared(proj model): 0.009611   Adjusted R-squared: -0.004095 
    F-statistic(full model):3.876 on 39 and 2818 DF, p-value: 1.225e-14 
    F-statistic(proj model): 1.189 on 23 and 2818 DF, p-value: 0.2427 
    *** Standard errors may be too high due to more than 2 groups and exactDOF=FALSE

There are 2 different maps. The summer map represents the regressions in
the summer per police district in Baltimore city. The winter map
represents the regression in the winter per police district in Baltimore
city.

``` r
# for summer
#model6<-felm(call_bin ~ temp_F:as.factor(policeDistrict) +
               #holiday_bin |
               #year + month + dow, data=df4s)
               #policeDistrict + year + month + dow, data=df4s)

#summary(model6)

# for winter
#model7<-felm(call_bin ~ temp_F:as.factor(policeDistrict) +
               #holiday_bin |
               #year + month + dow, data=df4w)
               #policeDistrict + year + month + dow, data=df4w)

#summary(model7)
```

``` r
library("terra")


police_districts<-vect("Police_Districts_2023/Police_Districts_2023.shp")

# for summer
police_districts$trt_summer <- 0

police_districts$trt_summer[police_districts$Dist_Name=="Central"] <- -0.09550
police_districts$trt_summer[police_districts$Dist_Name=="Eastern"] <- 0.01648
police_districts$trt_summer[police_districts$Dist_Name=="Northeastern"] <- -0.01467
police_districts$trt_summer[police_districts$Dist_Name=="Northern"] <- -0.07753
police_districts$trt_summer[police_districts$Dist_Name=="Northwestern"] <- 0.18702
police_districts$trt_summer[police_districts$Dist_Name=="Southeastern"] <- -0.06940
police_districts$trt_summer[police_districts$Dist_Name=="Southern"] <- 0.06162
police_districts$trt_summer[police_districts$Dist_Name=="Southwestern"] <- -0.03609
police_districts$trt_summer[police_districts$Dist_Name=="Western"] <- -0.09668

png("map_summer.png", width=6, height=4, unit="in", res=500)
plot(police_districts, "trt_summer", col=map.pal("greens"))
dev.off()
```

    png 
      2 

``` r
# for winter
police_districts$trt_winter <- 0

police_districts$trt_winter[police_districts$Dist_Name=="Central"] <- -0.10398
police_districts$trt_winter[police_districts$Dist_Name=="Eastern"] <- -0.01305
police_districts$trt_winter[police_districts$Dist_Name=="Northeastern"] <- -0.22759
police_districts$trt_winter[police_districts$Dist_Name=="Northern"] <- 0.23277
police_districts$trt_winter[police_districts$Dist_Name=="Northwestern"] <- 0.36696
police_districts$trt_winter[police_districts$Dist_Name=="Southeastern"] <- -0.13753
police_districts$trt_winter[police_districts$Dist_Name=="Southern"] <- 0.19048
police_districts$trt_winter[police_districts$Dist_Name=="Southwestern"] <- 0.18269
police_districts$trt_winter[police_districts$Dist_Name=="Western"] <- -0.32152

png("map_winter.png", width=6, height=4, unit="in", res=500)
plot(police_districts, "trt_winter", col=map.pal("greens"))
dev.off()
```

    png 
      2 

## Discussion:

Our findings showed that during the winter months, there is an increase
in mental health related calls as the temperature becomes either hotter
or significantly colder. Similarly, during summer months, there is an
increase in mental health related calls as the temperature rises. These
results correlated with our initial scatter plots which showed more
mental health related calls associated with extreme temperatures. After
running regressions per each police district in Baltimore City, they
showed that both in the summer and winter for every 1% of increase in
temperature there are some police districts where there is some amount
of increase in the number of calls received while in others there is a
decrease. A related study, Burke et al. (2018) found a similar
relationship between temperature and the amount of suicides that occur.
They found that there is an increase by 0.7% in suicide rate per 1.8
degrees Fahrenheit rise in temperature. Additionally, Janzen (2022)
stated that cold weather forces people to have more alone time leading
to feelings of sadness. The feeling of sadness causes poor mental health
thus leading to more distress calls explaining why colder temperatures
lead to a greater amount of calls.

There are still the ways to improve our research. We plan to use data
about the human comfort index instead of using ground temperature. We
also plan to taken into the frequency of extreme temperature into
account.

## Future Plans:

- Alter the graph so that it shows the relationship between specific
  temperature periods to the number of calls

- Incorporate methods and strategies from official articles into our
  research paper.

- Control for trees, precipitation and air quality

- Identify factors that impacts temperature and number of calls at the
  same time.

  - precipitation

  - trees

  - air quality

## **Bibliography:** 

Burke, M., González, F., Baylis, P., Heft-Neal, S., Baysan, C., Basu,
S., & Hsiang, S. (2018). Higher temperatures increase suicide rates in
the United States and Mexico. Nature Climate Change, 8(8), 723–729.
<https://doi.org/10.1038/s41558-018-0222-x> 

Change, N. G. C. (n.d.). Global Surface Temperature \| NASA Global
Climate Change. Climate Change: Vital Signs of the Planet. Retrieved
October 22, 2024, from
<https://climate.nasa.gov/vital-signs/global-temperature/?intent=121> 

Diallo, I., He, L., Koehler, K., Spira, A. P., Kale, R., Ou, J., Smith,
G., Linton, S. L., & Augustinavicius, J. (2024). Community perspectives
on heat and health in Baltimore City. Urban Climate, 54, 101841.
<https://doi.org/10.1016/j.uclim.2024.101841> 

Evans, M., Gazze, L., & Schaller, J. (2023). Temperature and
maltreatment of young children. <https://doi.org/10.3386/w31522>).

Heilmann, K., Kahn, M. E., & Tang, C. K. (2021). The urban crime and
heat gradient in high and low poverty areas. Journal of Public
Economics, 197, 104408. <https://doi.org/10.1016/j.jpubeco.2021.104408>

Janzen, B. (2022). Temperature and Mental Health: Evidence from Helpline
Calls. ArXiv. <https://arxiv.org/abs/2207.04992>

Srivastava, S., & Mullins, J. T. (2024). Temperature, Mental Health, and
Individual Crises: Evidence from Crisis Text Line. American Journal of
Health Economics. <https://doi.org/10.1086/730332> 
