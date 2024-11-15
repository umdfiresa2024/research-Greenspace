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

| policeDistrict | date       |   temp_K | callscount |   temp_F | call_bin | year | month | dow       |
|:---------------|:-----------|---------:|-----------:|---------:|---------:|-----:|------:|:----------|
| Central        | 2021-06-06 | 302.3536 |          0 | 84.56650 |        0 | 2021 |     6 | Sunday    |
| Central        | 2021-06-07 | 306.9233 |          0 | 92.79200 |        0 | 2021 |     6 | Monday    |
| Central        | 2021-06-08 | 298.5400 |          0 | 77.70200 |        0 | 2021 |     6 | Tuesday   |
| Central        | 2021-06-14 | 308.7900 |          0 | 96.15200 |        0 | 2021 |     6 | Monday    |
| Central        | 2021-06-16 | 310.7467 |          0 | 99.67400 |        0 | 2021 |     6 | Wednesday |
| Central        | 2021-06-17 | 300.3714 |          0 | 80.99857 |        0 | 2021 |     6 | Thursday  |

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

**Bibliography:** 

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

Heilmann, K., Kahn, M. E., & Tang, C. K. (2021). The urban crime and
heat gradient in high and low poverty areas. Journal of Public
Economics, 197, 104408. <https://doi.org/10.1016/j.jpubeco.2021.104408>

Srivastava, S., & Mullins, J. T. (2024). Temperature, Mental Health, and
Individual Crises: Evidence from Crisis Text Line. American Journal of
Health Economics. <https://doi.org/10.1086/730332> 

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

``` r
#----------------------------------------------------------------------------------------------
# We will not be using these graphs (I think so)


# for winter
df_winter <- df2 %>%
  filter(seasons == 1) %>%
  group_by(policeDistrict, tempCatagories) %>%
  summarize(total_callscount = sum(callscount))

# for summer
df_summer <- df2 %>%
  filter(seasons == 0) %>%
  group_by(policeDistrict, tempCatagories) %>%
  summarize(total_callscount = sum(callscount))

# Grouped bar graph -winter
ggplot(df_winter, aes(x = tempCatagories, y = total_callscount)) + 
    geom_bar(stat="identity") +
    facet_wrap((~ as.character(policeDistrict))) +
    labs(title = "Total Number of Calls per Police District (Winter 11-2)",
       x = "Temperature Range (F)", 
       y = "Total Number of Calls") +
  theme_bw()
```

![](README_files/figure-commonmark/unnamed-chunk-6-3.png)

``` r
# Grouped bar graph -summer
ggplot(df_summer, aes(x = tempCatagories, y = total_callscount)) + 
    geom_bar(stat="identity") +
    facet_wrap((~ as.character(policeDistrict))) +
    labs(title = "Total Number of Calls per Police District (Summer 4-9)",
       x = "Temperature Range (F)", 
       y = "Total Number of Calls") +
  theme_bw()
```

![](README_files/figure-commonmark/unnamed-chunk-6-4.png)

  
  

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAaCAYAAADFTB7LAAAAcElEQVR4Xu3OwQmAQAxE0bClWYCW5N06tM6V2YPg5CjoF/JhLoHAi6iqn9eOefUbqrYvHY0cQDLyAlKRNyARmYA0ZMLRkAlGQyaU72tkAtlim7r/vJqDUDjlKBROOQyFU2icQuMUGqfQuBEaV1XPOwEx96nYACK8+wAAAABJRU5ErkJggg== "Run Current Chunk")

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


model3<-felm(call_bin ~ temp_over_100:as.factor(policeDistrict) + 
               temp_95_100:as.factor(policeDistrict) + 
               temp_90_95:as.factor(policeDistrict) + 
               temp_85_90:as.factor(policeDistrict) + 
               temp_80_85:as.factor(policeDistrict) +
               temp_75_80:as.factor(policeDistrict) + 
               temp_70_75:as.factor(policeDistrict) + 
               temp_65_70:as.factor(policeDistrict) + 
               temp_60_65:as.factor(policeDistrict) + 
               temp_50_55:as.factor(policeDistrict) + 
               temp_45_50:as.factor(policeDistrict) + 
               temp_40_45:as.factor(policeDistrict) + 
               temp_35_40:as.factor(policeDistrict) + 
               temp_30_35:as.factor(policeDistrict) + 
               temp_25_30:as.factor(policeDistrict) + 
               temp_20_25:as.factor(policeDistrict) + 
               temp_15_20:as.factor(policeDistrict) + 
               temp_10_15:as.factor(policeDistrict) + 
               temp_5_10:as.factor(policeDistrict) + 
               temp_0_5:as.factor(policeDistrict) + 
               temp_under_0:as.factor(policeDistrict) + 
               holiday_bin | year + month + dow, data=df4w)

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
summary(model3)
```


    Call:
       felm(formula = call_bin ~ temp_over_100:as.factor(policeDistrict) +      temp_95_100:as.factor(policeDistrict) + temp_90_95:as.factor(policeDistrict) +      temp_85_90:as.factor(policeDistrict) + temp_80_85:as.factor(policeDistrict) +      temp_75_80:as.factor(policeDistrict) + temp_70_75:as.factor(policeDistrict) +      temp_65_70:as.factor(policeDistrict) + temp_60_65:as.factor(policeDistrict) +      temp_50_55:as.factor(policeDistrict) + temp_45_50:as.factor(policeDistrict) +      temp_40_45:as.factor(policeDistrict) + temp_35_40:as.factor(policeDistrict) +      temp_30_35:as.factor(policeDistrict) + temp_25_30:as.factor(policeDistrict) +      temp_20_25:as.factor(policeDistrict) + temp_15_20:as.factor(policeDistrict) +      temp_10_15:as.factor(policeDistrict) + temp_5_10:as.factor(policeDistrict) +      temp_0_5:as.factor(policeDistrict) + temp_under_0:as.factor(policeDistrict) +      holiday_bin | year + month + dow, data = df4w) 

    Residuals:
         Min       1Q   Median       3Q      Max 
    -0.54676 -0.17257 -0.09842 -0.02121  1.00682 

    Coefficients:
                                                         Estimate Std. Error
    holiday_bin                                          0.001311   0.023102
    temp_over_100:as.factor(policeDistrict)Central            NaN         NA
    temp_over_100:as.factor(policeDistrict)Eastern            NaN         NA
    temp_over_100:as.factor(policeDistrict)Northeastern       NaN         NA
    temp_over_100:as.factor(policeDistrict)Northern           NaN         NA
    temp_over_100:as.factor(policeDistrict)Northwestern       NaN         NA
    temp_over_100:as.factor(policeDistrict)Southeastern       NaN         NA
    temp_over_100:as.factor(policeDistrict)Southern           NaN         NA
    temp_over_100:as.factor(policeDistrict)Southwestern       NaN         NA
    temp_over_100:as.factor(policeDistrict)Western            NaN         NA
    as.factor(policeDistrict)Central:temp_95_100              NaN         NA
    as.factor(policeDistrict)Eastern:temp_95_100              NaN         NA
    as.factor(policeDistrict)Northeastern:temp_95_100         NaN         NA
    as.factor(policeDistrict)Northern:temp_95_100             NaN         NA
    as.factor(policeDistrict)Northwestern:temp_95_100         NaN         NA
    as.factor(policeDistrict)Southeastern:temp_95_100         NaN         NA
    as.factor(policeDistrict)Southern:temp_95_100             NaN         NA
    as.factor(policeDistrict)Southwestern:temp_95_100         NaN         NA
    as.factor(policeDistrict)Western:temp_95_100              NaN         NA
    as.factor(policeDistrict)Central:temp_90_95               NaN         NA
    as.factor(policeDistrict)Eastern:temp_90_95               NaN         NA
    as.factor(policeDistrict)Northeastern:temp_90_95          NaN         NA
    as.factor(policeDistrict)Northern:temp_90_95              NaN         NA
    as.factor(policeDistrict)Northwestern:temp_90_95          NaN         NA
    as.factor(policeDistrict)Southeastern:temp_90_95          NaN         NA
    as.factor(policeDistrict)Southern:temp_90_95              NaN         NA
    as.factor(policeDistrict)Southwestern:temp_90_95          NaN         NA
    as.factor(policeDistrict)Western:temp_90_95               NaN         NA
    as.factor(policeDistrict)Central:temp_85_90               NaN         NA
    as.factor(policeDistrict)Eastern:temp_85_90               NaN         NA
    as.factor(policeDistrict)Northeastern:temp_85_90          NaN         NA
    as.factor(policeDistrict)Northern:temp_85_90              NaN         NA
    as.factor(policeDistrict)Northwestern:temp_85_90          NaN         NA
    as.factor(policeDistrict)Southeastern:temp_85_90          NaN         NA
    as.factor(policeDistrict)Southern:temp_85_90              NaN         NA
    as.factor(policeDistrict)Southwestern:temp_85_90          NaN         NA
    as.factor(policeDistrict)Western:temp_85_90               NaN         NA
    as.factor(policeDistrict)Central:temp_80_85               NaN         NA
    as.factor(policeDistrict)Eastern:temp_80_85               NaN         NA
    as.factor(policeDistrict)Northeastern:temp_80_85          NaN         NA
    as.factor(policeDistrict)Northern:temp_80_85              NaN         NA
    as.factor(policeDistrict)Northwestern:temp_80_85          NaN         NA
    as.factor(policeDistrict)Southeastern:temp_80_85          NaN         NA
    as.factor(policeDistrict)Southern:temp_80_85              NaN         NA
    as.factor(policeDistrict)Southwestern:temp_80_85          NaN         NA
    as.factor(policeDistrict)Western:temp_80_85               NaN         NA
    as.factor(policeDistrict)Central:temp_75_80               NaN         NA
    as.factor(policeDistrict)Eastern:temp_75_80               NaN         NA
    as.factor(policeDistrict)Northeastern:temp_75_80     0.843176   0.346502
    as.factor(policeDistrict)Northern:temp_75_80              NaN         NA
    as.factor(policeDistrict)Northwestern:temp_75_80          NaN         NA
    as.factor(policeDistrict)Southeastern:temp_75_80    -0.156824   0.346502
    as.factor(policeDistrict)Southern:temp_75_80              NaN         NA
    as.factor(policeDistrict)Southwestern:temp_75_80          NaN         NA
    as.factor(policeDistrict)Western:temp_75_80               NaN         NA
    as.factor(policeDistrict)Central:temp_70_75          0.044055   0.158310
    as.factor(policeDistrict)Eastern:temp_70_75          0.179083   0.202082
    as.factor(policeDistrict)Northeastern:temp_70_75     0.094274   0.175899
    as.factor(policeDistrict)Northern:temp_70_75        -0.160364   0.246338
    as.factor(policeDistrict)Northwestern:temp_70_75     0.339636   0.246338
    as.factor(policeDistrict)Southeastern:temp_70_75    -0.154250   0.202082
    as.factor(policeDistrict)Southern:temp_70_75              NaN         NA
    as.factor(policeDistrict)Southwestern:temp_70_75     0.062607   0.157792
    as.factor(policeDistrict)Western:temp_70_75          0.021460   0.144616
    as.factor(policeDistrict)Central:temp_65_70               NaN         NA
    as.factor(policeDistrict)Eastern:temp_65_70         -0.160151   0.346360
    as.factor(policeDistrict)Northeastern:temp_65_70    -0.184277   0.346379
    as.factor(policeDistrict)Northern:temp_65_70        -0.151087   0.246207
    as.factor(policeDistrict)Northwestern:temp_65_70    -0.162150   0.201882
    as.factor(policeDistrict)Southeastern:temp_65_70          NaN         NA
    as.factor(policeDistrict)Southern:temp_65_70        -0.137393   0.157792
    as.factor(policeDistrict)Southwestern:temp_65_70          NaN         NA
    as.factor(policeDistrict)Western:temp_65_70         -0.156824   0.346502
    as.factor(policeDistrict)Central:temp_60_65         -0.139807   0.201821
    as.factor(policeDistrict)Eastern:temp_60_65         -0.138386   0.157728
    as.factor(policeDistrict)Northeastern:temp_60_65    -0.117549   0.157631
    as.factor(policeDistrict)Northern:temp_60_65         0.067105   0.157628
    as.factor(policeDistrict)Northwestern:temp_60_65     0.364739   0.175355
    as.factor(policeDistrict)Southeastern:temp_60_65    -0.138460   0.175362
    as.factor(policeDistrict)Southern:temp_60_65        -0.156824   0.346502
    as.factor(policeDistrict)Southwestern:temp_60_65     0.071636   0.157503
    as.factor(policeDistrict)Western:temp_60_65         -0.121686   0.157526
    as.factor(policeDistrict)Central:temp_50_55         -0.074820   0.082796
    as.factor(policeDistrict)Eastern:temp_50_55          0.027704   0.084601
    as.factor(policeDistrict)Northeastern:temp_50_55     0.074905   0.084532
    as.factor(policeDistrict)Northern:temp_50_55         0.120624   0.084561
    as.factor(policeDistrict)Northwestern:temp_50_55     0.071389   0.077016
    as.factor(policeDistrict)Southeastern:temp_50_55     0.103979   0.081260
    as.factor(policeDistrict)Southern:temp_50_55        -0.030088   0.082566
    as.factor(policeDistrict)Southwestern:temp_50_55     0.026081   0.084497
    as.factor(policeDistrict)Western:temp_50_55          0.009713   0.095928
    as.factor(policeDistrict)Central:temp_45_50         -0.021606   0.067602
    as.factor(policeDistrict)Eastern:temp_45_50         -0.109027   0.064848
    as.factor(policeDistrict)Northeastern:temp_45_50     0.065669   0.067551
    as.factor(policeDistrict)Northern:temp_45_50        -0.036986   0.070886
    as.factor(policeDistrict)Northwestern:temp_45_50     0.250731   0.075981
    as.factor(policeDistrict)Southeastern:temp_45_50    -0.106600   0.069683
    as.factor(policeDistrict)Southern:temp_45_50        -0.041851   0.069281
    as.factor(policeDistrict)Southwestern:temp_45_50    -0.015283   0.067504
    as.factor(policeDistrict)Western:temp_45_50          0.057458   0.066260
    as.factor(policeDistrict)Central:temp_40_45         -0.039928   0.068816
    as.factor(policeDistrict)Eastern:temp_40_45         -0.092764   0.070242
    as.factor(policeDistrict)Northeastern:temp_40_45     0.147966   0.064727
    as.factor(policeDistrict)Northern:temp_40_45        -0.042609   0.065840
    as.factor(policeDistrict)Northwestern:temp_40_45     0.137823   0.065457
    as.factor(policeDistrict)Southeastern:temp_40_45    -0.068884   0.067433
    as.factor(policeDistrict)Southern:temp_40_45         0.087601   0.069361
    as.factor(policeDistrict)Southwestern:temp_40_45     0.182149   0.070352
    as.factor(policeDistrict)Western:temp_40_45         -0.006861   0.069350
    as.factor(policeDistrict)Central:temp_35_40         -0.006940   0.064913
    as.factor(policeDistrict)Eastern:temp_35_40         -0.012264   0.064223
    as.factor(policeDistrict)Northeastern:temp_35_40    -0.011012   0.064551
    as.factor(policeDistrict)Northern:temp_35_40         0.089981   0.065093
    as.factor(policeDistrict)Northwestern:temp_35_40     0.181752   0.066538
    as.factor(policeDistrict)Southeastern:temp_35_40    -0.019783   0.062673
    as.factor(policeDistrict)Southern:temp_35_40        -0.022978   0.063018
    as.factor(policeDistrict)Southwestern:temp_35_40     0.047222   0.065864
    as.factor(policeDistrict)Western:temp_35_40         -0.107601   0.071116
    as.factor(policeDistrict)Central:temp_30_35          0.088452   0.070447
    as.factor(policeDistrict)Eastern:temp_30_35         -0.029838   0.065927
    as.factor(policeDistrict)Northeastern:temp_30_35     0.255075   0.066211
    as.factor(policeDistrict)Northern:temp_30_35        -0.079547   0.065279
    as.factor(policeDistrict)Northwestern:temp_30_35     0.017187   0.069181
    as.factor(policeDistrict)Southeastern:temp_30_35    -0.024113   0.067308
    as.factor(policeDistrict)Southern:temp_30_35        -0.078982   0.064824
    as.factor(policeDistrict)Southwestern:temp_30_35    -0.048635   0.067598
    as.factor(policeDistrict)Western:temp_30_35          0.119737   0.067591
    as.factor(policeDistrict)Central:temp_25_30          0.034865   0.086478
    as.factor(policeDistrict)Eastern:temp_25_30         -0.057488   0.086701
    as.factor(policeDistrict)Northeastern:temp_25_30     0.114479   0.090332
    as.factor(policeDistrict)Northern:temp_25_30        -0.111736   0.088053
    as.factor(policeDistrict)Northwestern:temp_25_30     0.142547   0.087407
    as.factor(policeDistrict)Southeastern:temp_25_30     0.049905   0.079418
    as.factor(policeDistrict)Southern:temp_25_30        -0.081364   0.073647
    as.factor(policeDistrict)Southwestern:temp_25_30    -0.052640   0.096585
    as.factor(policeDistrict)Western:temp_25_30          0.096986   0.087916
    as.factor(policeDistrict)Central:temp_20_25         -0.099650   0.159332
    as.factor(policeDistrict)Eastern:temp_20_25         -0.115630   0.176769
    as.factor(policeDistrict)Northeastern:temp_20_25    -0.111569   0.202767
    as.factor(policeDistrict)Northern:temp_20_25        -0.107446   0.176953
    as.factor(policeDistrict)Northwestern:temp_20_25    -0.106879   0.121670
    as.factor(policeDistrict)Southeastern:temp_20_25    -0.133307   0.176803
    as.factor(policeDistrict)Southern:temp_20_25        -0.119092   0.176641
    as.factor(policeDistrict)Southwestern:temp_20_25     0.036031   0.136328
    as.factor(policeDistrict)Western:temp_20_25         -0.100139   0.159288
    as.factor(policeDistrict)Central:temp_15_20         -0.106428   0.203395
    as.factor(policeDistrict)Eastern:temp_15_20         -0.095734   0.247836
    as.factor(policeDistrict)Northeastern:temp_15_20    -0.087459   0.203657
    as.factor(policeDistrict)Northern:temp_15_20        -0.087459   0.203657
    as.factor(policeDistrict)Northwestern:temp_15_20    -0.082993   0.247330
    as.factor(policeDistrict)Southeastern:temp_15_20     0.209547   0.203140
    as.factor(policeDistrict)Southern:temp_15_20        -0.118399   0.159121
    as.factor(policeDistrict)Southwestern:temp_15_20    -0.096603   0.159460
    as.factor(policeDistrict)Western:temp_15_20         -0.087459   0.203657
    as.factor(policeDistrict)Central:temp_10_15          0.207433   0.202955
    as.factor(policeDistrict)Eastern:temp_10_15         -0.142439   0.247675
    as.factor(policeDistrict)Northeastern:temp_10_15     0.357561   0.247675
    as.factor(policeDistrict)Northern:temp_10_15        -0.140776   0.347469
    as.factor(policeDistrict)Northwestern:temp_10_15    -0.096390   0.347562
    as.factor(policeDistrict)Southeastern:temp_10_15    -0.116800   0.246827
    as.factor(policeDistrict)Southern:temp_10_15         0.859224   0.347469
    as.factor(policeDistrict)Southwestern:temp_10_15     0.357561   0.247675
    as.factor(policeDistrict)Western:temp_10_15          0.859224   0.347469
    as.factor(policeDistrict)Central:temp_5_10                NaN         NA
    as.factor(policeDistrict)Eastern:temp_5_10                NaN         NA
    as.factor(policeDistrict)Northeastern:temp_5_10           NaN         NA
    as.factor(policeDistrict)Northern:temp_5_10               NaN         NA
    as.factor(policeDistrict)Northwestern:temp_5_10     -0.140776   0.347469
    as.factor(policeDistrict)Southeastern:temp_5_10     -0.129496   0.346878
    as.factor(policeDistrict)Southern:temp_5_10               NaN         NA
    as.factor(policeDistrict)Southwestern:temp_5_10           NaN         NA
    as.factor(policeDistrict)Western:temp_5_10                NaN         NA
    as.factor(policeDistrict)Central:temp_0_5                 NaN         NA
    as.factor(policeDistrict)Eastern:temp_0_5                 NaN         NA
    as.factor(policeDistrict)Northeastern:temp_0_5            NaN         NA
    as.factor(policeDistrict)Northern:temp_0_5                NaN         NA
    as.factor(policeDistrict)Northwestern:temp_0_5            NaN         NA
    as.factor(policeDistrict)Southeastern:temp_0_5            NaN         NA
    as.factor(policeDistrict)Southern:temp_0_5                NaN         NA
    as.factor(policeDistrict)Southwestern:temp_0_5            NaN         NA
    as.factor(policeDistrict)Western:temp_0_5                 NaN         NA
    as.factor(policeDistrict)Central:temp_under_0             NaN         NA
    as.factor(policeDistrict)Eastern:temp_under_0             NaN         NA
    as.factor(policeDistrict)Northeastern:temp_under_0        NaN         NA
    as.factor(policeDistrict)Northern:temp_under_0            NaN         NA
    as.factor(policeDistrict)Northwestern:temp_under_0        NaN         NA
    as.factor(policeDistrict)Southeastern:temp_under_0        NaN         NA
    as.factor(policeDistrict)Southern:temp_under_0            NaN         NA
    as.factor(policeDistrict)Southwestern:temp_under_0        NaN         NA
    as.factor(policeDistrict)Western:temp_under_0             NaN         NA
                                                        t value Pr(>|t|)    
    holiday_bin                                           0.057 0.954746    
    temp_over_100:as.factor(policeDistrict)Central          NaN      NaN    
    temp_over_100:as.factor(policeDistrict)Eastern          NaN      NaN    
    temp_over_100:as.factor(policeDistrict)Northeastern     NaN      NaN    
    temp_over_100:as.factor(policeDistrict)Northern         NaN      NaN    
    temp_over_100:as.factor(policeDistrict)Northwestern     NaN      NaN    
    temp_over_100:as.factor(policeDistrict)Southeastern     NaN      NaN    
    temp_over_100:as.factor(policeDistrict)Southern         NaN      NaN    
    temp_over_100:as.factor(policeDistrict)Southwestern     NaN      NaN    
    temp_over_100:as.factor(policeDistrict)Western          NaN      NaN    
    as.factor(policeDistrict)Central:temp_95_100            NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_95_100            NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_95_100       NaN      NaN    
    as.factor(policeDistrict)Northern:temp_95_100           NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_95_100       NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_95_100       NaN      NaN    
    as.factor(policeDistrict)Southern:temp_95_100           NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_95_100       NaN      NaN    
    as.factor(policeDistrict)Western:temp_95_100            NaN      NaN    
    as.factor(policeDistrict)Central:temp_90_95             NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_90_95             NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_90_95        NaN      NaN    
    as.factor(policeDistrict)Northern:temp_90_95            NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_90_95        NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_90_95        NaN      NaN    
    as.factor(policeDistrict)Southern:temp_90_95            NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_90_95        NaN      NaN    
    as.factor(policeDistrict)Western:temp_90_95             NaN      NaN    
    as.factor(policeDistrict)Central:temp_85_90             NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_85_90             NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_85_90        NaN      NaN    
    as.factor(policeDistrict)Northern:temp_85_90            NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_85_90        NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_85_90        NaN      NaN    
    as.factor(policeDistrict)Southern:temp_85_90            NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_85_90        NaN      NaN    
    as.factor(policeDistrict)Western:temp_85_90             NaN      NaN    
    as.factor(policeDistrict)Central:temp_80_85             NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_80_85             NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_80_85        NaN      NaN    
    as.factor(policeDistrict)Northern:temp_80_85            NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_80_85        NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_80_85        NaN      NaN    
    as.factor(policeDistrict)Southern:temp_80_85            NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_80_85        NaN      NaN    
    as.factor(policeDistrict)Western:temp_80_85             NaN      NaN    
    as.factor(policeDistrict)Central:temp_75_80             NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_75_80             NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_75_80      2.433 0.015053 *  
    as.factor(policeDistrict)Northern:temp_75_80            NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_75_80        NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_75_80     -0.453 0.650896    
    as.factor(policeDistrict)Southern:temp_75_80            NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_75_80        NaN      NaN    
    as.factor(policeDistrict)Western:temp_75_80             NaN      NaN    
    as.factor(policeDistrict)Central:temp_70_75           0.278 0.780828    
    as.factor(policeDistrict)Eastern:temp_70_75           0.886 0.375630    
    as.factor(policeDistrict)Northeastern:temp_70_75      0.536 0.592054    
    as.factor(policeDistrict)Northern:temp_70_75         -0.651 0.515133    
    as.factor(policeDistrict)Northwestern:temp_70_75      1.379 0.168143    
    as.factor(policeDistrict)Southeastern:temp_70_75     -0.763 0.445378    
    as.factor(policeDistrict)Southern:temp_70_75            NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_70_75      0.397 0.691581    
    as.factor(policeDistrict)Western:temp_70_75           0.148 0.882049    
    as.factor(policeDistrict)Central:temp_65_70             NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_65_70          -0.462 0.643861    
    as.factor(policeDistrict)Northeastern:temp_65_70     -0.532 0.594784    
    as.factor(policeDistrict)Northern:temp_65_70         -0.614 0.539516    
    as.factor(policeDistrict)Northwestern:temp_65_70     -0.803 0.421966    
    as.factor(policeDistrict)Southeastern:temp_65_70        NaN      NaN    
    as.factor(policeDistrict)Southern:temp_65_70         -0.871 0.384019    
    as.factor(policeDistrict)Southwestern:temp_65_70        NaN      NaN    
    as.factor(policeDistrict)Western:temp_65_70          -0.453 0.650896    
    as.factor(policeDistrict)Central:temp_60_65          -0.693 0.488568    
    as.factor(policeDistrict)Eastern:temp_60_65          -0.877 0.380401    
    as.factor(policeDistrict)Northeastern:temp_60_65     -0.746 0.455929    
    as.factor(policeDistrict)Northern:temp_60_65          0.426 0.670365    
    as.factor(policeDistrict)Northwestern:temp_60_65      2.080 0.037664 *  
    as.factor(policeDistrict)Southeastern:temp_60_65     -0.790 0.429883    
    as.factor(policeDistrict)Southern:temp_60_65         -0.453 0.650896    
    as.factor(policeDistrict)Southwestern:temp_60_65      0.455 0.649291    
    as.factor(policeDistrict)Western:temp_60_65          -0.772 0.439929    
    as.factor(policeDistrict)Central:temp_50_55          -0.904 0.366286    
    as.factor(policeDistrict)Eastern:temp_50_55           0.327 0.743355    
    as.factor(policeDistrict)Northeastern:temp_50_55      0.886 0.375672    
    as.factor(policeDistrict)Northern:temp_50_55          1.426 0.153900    
    as.factor(policeDistrict)Northwestern:temp_50_55      0.927 0.354083    
    as.factor(policeDistrict)Southeastern:temp_50_55      1.280 0.200853    
    as.factor(policeDistrict)Southern:temp_50_55         -0.364 0.715592    
    as.factor(policeDistrict)Southwestern:temp_50_55      0.309 0.757610    
    as.factor(policeDistrict)Western:temp_50_55           0.101 0.919358    
    as.factor(policeDistrict)Central:temp_45_50          -0.320 0.749308    
    as.factor(policeDistrict)Eastern:temp_45_50          -1.681 0.092881 .  
    as.factor(policeDistrict)Northeastern:temp_45_50      0.972 0.331106    
    as.factor(policeDistrict)Northern:temp_45_50         -0.522 0.601893    
    as.factor(policeDistrict)Northwestern:temp_45_50      3.300 0.000986 ***
    as.factor(policeDistrict)Southeastern:temp_45_50     -1.530 0.126241    
    as.factor(policeDistrict)Southern:temp_45_50         -0.604 0.545872    
    as.factor(policeDistrict)Southwestern:temp_45_50     -0.226 0.820920    
    as.factor(policeDistrict)Western:temp_45_50           0.867 0.385971    
    as.factor(policeDistrict)Central:temp_40_45          -0.580 0.561843    
    as.factor(policeDistrict)Eastern:temp_40_45          -1.321 0.186787    
    as.factor(policeDistrict)Northeastern:temp_40_45      2.286 0.022366 *  
    as.factor(policeDistrict)Northern:temp_40_45         -0.647 0.517607    
    as.factor(policeDistrict)Northwestern:temp_40_45      2.106 0.035379 *  
    as.factor(policeDistrict)Southeastern:temp_40_45     -1.022 0.307148    
    as.factor(policeDistrict)Southern:temp_40_45          1.263 0.206760    
    as.factor(policeDistrict)Southwestern:temp_40_45      2.589 0.009698 ** 
    as.factor(policeDistrict)Western:temp_40_45          -0.099 0.921204    
    as.factor(policeDistrict)Central:temp_35_40          -0.107 0.914873    
    as.factor(policeDistrict)Eastern:temp_35_40          -0.191 0.848574    
    as.factor(policeDistrict)Northeastern:temp_35_40     -0.171 0.864558    
    as.factor(policeDistrict)Northern:temp_35_40          1.382 0.167032    
    as.factor(policeDistrict)Northwestern:temp_35_40      2.732 0.006364 ** 
    as.factor(policeDistrict)Southeastern:temp_35_40     -0.316 0.752297    
    as.factor(policeDistrict)Southern:temp_35_40         -0.365 0.715435    
    as.factor(policeDistrict)Southwestern:temp_35_40      0.717 0.473485    
    as.factor(policeDistrict)Western:temp_35_40          -1.513 0.130441    
    as.factor(policeDistrict)Central:temp_30_35           1.256 0.209423    
    as.factor(policeDistrict)Eastern:temp_30_35          -0.453 0.650892    
    as.factor(policeDistrict)Northeastern:temp_30_35      3.852 0.000121 ***
    as.factor(policeDistrict)Northern:temp_30_35         -1.219 0.223164    
    as.factor(policeDistrict)Northwestern:temp_30_35      0.248 0.803819    
    as.factor(policeDistrict)Southeastern:temp_30_35     -0.358 0.720203    
    as.factor(policeDistrict)Southern:temp_30_35         -1.218 0.223228    
    as.factor(policeDistrict)Southwestern:temp_30_35     -0.719 0.471946    
    as.factor(policeDistrict)Western:temp_30_35           1.771 0.076644 .  
    as.factor(policeDistrict)Central:temp_25_30           0.403 0.686872    
    as.factor(policeDistrict)Eastern:temp_25_30          -0.663 0.507378    
    as.factor(policeDistrict)Northeastern:temp_25_30      1.267 0.205203    
    as.factor(policeDistrict)Northern:temp_25_30         -1.269 0.204615    
    as.factor(policeDistrict)Northwestern:temp_25_30      1.631 0.103094    
    as.factor(policeDistrict)Southeastern:temp_25_30      0.628 0.529831    
    as.factor(policeDistrict)Southern:temp_25_30         -1.105 0.269401    
    as.factor(policeDistrict)Southwestern:temp_25_30     -0.545 0.585810    
    as.factor(policeDistrict)Western:temp_25_30           1.103 0.270096    
    as.factor(policeDistrict)Central:temp_20_25          -0.625 0.531770    
    as.factor(policeDistrict)Eastern:temp_20_25          -0.654 0.513108    
    as.factor(policeDistrict)Northeastern:temp_20_25     -0.550 0.582227    
    as.factor(policeDistrict)Northern:temp_20_25         -0.607 0.543792    
    as.factor(policeDistrict)Northwestern:temp_20_25     -0.878 0.379823    
    as.factor(policeDistrict)Southeastern:temp_20_25     -0.754 0.450953    
    as.factor(policeDistrict)Southern:temp_20_25         -0.674 0.500267    
    as.factor(policeDistrict)Southwestern:temp_20_25      0.264 0.791580    
    as.factor(policeDistrict)Western:temp_20_25          -0.629 0.529646    
    as.factor(policeDistrict)Central:temp_15_20          -0.523 0.600860    
    as.factor(policeDistrict)Eastern:temp_15_20          -0.386 0.699334    
    as.factor(policeDistrict)Northeastern:temp_15_20     -0.429 0.667653    
    as.factor(policeDistrict)Northern:temp_15_20         -0.429 0.667653    
    as.factor(policeDistrict)Northwestern:temp_15_20     -0.336 0.737244    
    as.factor(policeDistrict)Southeastern:temp_15_20      1.032 0.302422    
    as.factor(policeDistrict)Southern:temp_15_20         -0.744 0.456922    
    as.factor(policeDistrict)Southwestern:temp_15_20     -0.606 0.544715    
    as.factor(policeDistrict)Western:temp_15_20          -0.429 0.667653    
    as.factor(policeDistrict)Central:temp_10_15           1.022 0.306886    
    as.factor(policeDistrict)Eastern:temp_10_15          -0.575 0.565290    
    as.factor(policeDistrict)Northeastern:temp_10_15      1.444 0.149002    
    as.factor(policeDistrict)Northern:temp_10_15         -0.405 0.685417    
    as.factor(policeDistrict)Northwestern:temp_10_15     -0.277 0.781557    
    as.factor(policeDistrict)Southeastern:temp_10_15     -0.473 0.636123    
    as.factor(policeDistrict)Southern:temp_10_15          2.473 0.013495 *  
    as.factor(policeDistrict)Southwestern:temp_10_15      1.444 0.149002    
    as.factor(policeDistrict)Western:temp_10_15           2.473 0.013495 *  
    as.factor(policeDistrict)Central:temp_5_10              NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_5_10              NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_5_10         NaN      NaN    
    as.factor(policeDistrict)Northern:temp_5_10             NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_5_10      -0.405 0.685417    
    as.factor(policeDistrict)Southeastern:temp_5_10      -0.373 0.708956    
    as.factor(policeDistrict)Southern:temp_5_10             NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_5_10         NaN      NaN    
    as.factor(policeDistrict)Western:temp_5_10              NaN      NaN    
    as.factor(policeDistrict)Central:temp_0_5               NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_0_5               NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_0_5          NaN      NaN    
    as.factor(policeDistrict)Northern:temp_0_5              NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_0_5          NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_0_5          NaN      NaN    
    as.factor(policeDistrict)Southern:temp_0_5              NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_0_5          NaN      NaN    
    as.factor(policeDistrict)Western:temp_0_5               NaN      NaN    
    as.factor(policeDistrict)Central:temp_under_0           NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_under_0           NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_under_0      NaN      NaN    
    as.factor(policeDistrict)Northern:temp_under_0          NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_under_0      NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_under_0      NaN      NaN    
    as.factor(policeDistrict)Southern:temp_under_0          NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_under_0      NaN      NaN    
    as.factor(policeDistrict)Western:temp_under_0           NaN      NaN    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 0.3439 on 1842 degrees of freedom
    Multiple R-squared(full model): 0.09552   Adjusted R-squared: 0.0361 
    Multiple R-squared(proj model): 0.08348   Adjusted R-squared: 0.02328 
    F-statistic(full model):1.608 on 121 and 1842 DF, p-value: 5.34e-05 
    F-statistic(proj model): 0.8831 on 190 and 1842 DF, p-value: 0.8654 
    *** Standard errors may be too high due to more than 2 groups and exactDOF=FALSE

``` r
#-------#


# This is for the summer months
df4s<-df3 %>%
  filter(seasons == 0)

model4<-felm(call_bin ~ temp_over_100 + temp_95_100 + temp_90_95 + temp_85_90 + temp_80_85 +
               temp_75_80 + temp_70_75 + temp_65_70 + temp_60_65 + temp_55_60 + temp_50_55 +                  temp_45_50 + temp_40_45 + temp_35_40 + temp_30_35 + temp_25_30 + temp_20_25 +                  temp_15_20 + temp_10_15 + temp_5_10 + temp_0_5 + temp_under_0  +
               holiday_bin |
               policeDistrict + year + month + dow, data=df4s)


model5<-felm(call_bin ~ temp_over_100:as.factor(policeDistrict) + 
               temp_95_100:as.factor(policeDistrict) + 
               temp_90_95:as.factor(policeDistrict) + 
               temp_85_90:as.factor(policeDistrict) + 
               temp_80_85:as.factor(policeDistrict) +
               temp_75_80:as.factor(policeDistrict) + 
               temp_70_75:as.factor(policeDistrict) + 
               temp_65_70:as.factor(policeDistrict) + 
               temp_60_65:as.factor(policeDistrict) + 
               temp_50_55:as.factor(policeDistrict) + 
               temp_45_50:as.factor(policeDistrict) + 
               temp_40_45:as.factor(policeDistrict) + 
               temp_35_40:as.factor(policeDistrict) + 
               temp_30_35:as.factor(policeDistrict) + 
               temp_25_30:as.factor(policeDistrict) + 
               temp_20_25:as.factor(policeDistrict) + 
               temp_15_20:as.factor(policeDistrict) + 
               temp_10_15:as.factor(policeDistrict) + 
               temp_5_10:as.factor(policeDistrict) + 
               temp_0_5:as.factor(policeDistrict) + 
               temp_under_0:as.factor(policeDistrict) + 
               holiday_bin | year + month + dow, data=df4s)

summary(model4)
```


    Call:
       felm(formula = call_bin ~ temp_over_100 + temp_95_100 + temp_90_95 +      temp_85_90 + temp_80_85 + temp_75_80 + temp_70_75 + temp_65_70 +      temp_60_65 + temp_55_60 + temp_50_55 + temp_45_50 + temp_40_45 +      temp_35_40 + temp_30_35 + temp_25_30 + temp_20_25 + temp_15_20 +      temp_10_15 + temp_5_10 + temp_0_5 + temp_under_0 + holiday_bin |      policeDistrict + year + month + dow, data = df4s) 

    Residuals:
        Min      1Q  Median      3Q     Max 
    -0.4446 -0.1888 -0.1252 -0.0628  1.0078 

    Coefficients:
                  Estimate Std. Error t value Pr(>|t|)  
    temp_over_100  0.19132    0.18643   1.026   0.3049  
    temp_95_100    0.12614    0.18427   0.685   0.4937  
    temp_90_95     0.11746    0.18353   0.640   0.5222  
    temp_85_90     0.10263    0.18285   0.561   0.5747  
    temp_80_85     0.10397    0.18288   0.568   0.5697  
    temp_75_80     0.11517    0.18290   0.630   0.5289  
    temp_70_75     0.17757    0.18274   0.972   0.3313  
    temp_65_70     0.12298    0.18317   0.671   0.5020  
    temp_60_65     0.16626    0.18328   0.907   0.3644  
    temp_55_60     0.11480    0.18388   0.624   0.5325  
    temp_50_55     0.11731    0.18776   0.625   0.5321  
    temp_45_50     0.10397    0.19359   0.537   0.5913  
    temp_40_45     0.07998    0.19721   0.406   0.6851  
    temp_35_40     0.16341    0.20750   0.788   0.4310  
    temp_30_35    -0.04843    0.23317  -0.208   0.8355  
    temp_25_30     0.23606    0.25527   0.925   0.3552  
    temp_20_25     0.96762    0.40391   2.396   0.0167 *
    temp_15_20         NaN         NA     NaN      NaN  
    temp_10_15         NaN         NA     NaN      NaN  
    temp_5_10          NaN         NA     NaN      NaN  
    temp_0_5           NaN         NA     NaN      NaN  
    temp_under_0       NaN         NA     NaN      NaN  
    holiday_bin    0.05034    0.03037   1.658   0.0975 .
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 0.3605 on 2818 degrees of freedom
    Multiple R-squared(full model): 0.05091   Adjusted R-squared: 0.03778 
    Multiple R-squared(proj model): 0.009611   Adjusted R-squared: -0.004095 
    F-statistic(full model):3.876 on 39 and 2818 DF, p-value: 1.225e-14 
    F-statistic(proj model): 1.189 on 23 and 2818 DF, p-value: 0.2427 
    *** Standard errors may be too high due to more than 2 groups and exactDOF=FALSE

``` r
summary(model5)
```


    Call:
       felm(formula = call_bin ~ temp_over_100:as.factor(policeDistrict) +      temp_95_100:as.factor(policeDistrict) + temp_90_95:as.factor(policeDistrict) +      temp_85_90:as.factor(policeDistrict) + temp_80_85:as.factor(policeDistrict) +      temp_75_80:as.factor(policeDistrict) + temp_70_75:as.factor(policeDistrict) +      temp_65_70:as.factor(policeDistrict) + temp_60_65:as.factor(policeDistrict) +      temp_50_55:as.factor(policeDistrict) + temp_45_50:as.factor(policeDistrict) +      temp_40_45:as.factor(policeDistrict) + temp_35_40:as.factor(policeDistrict) +      temp_30_35:as.factor(policeDistrict) + temp_25_30:as.factor(policeDistrict) +      temp_20_25:as.factor(policeDistrict) + temp_15_20:as.factor(policeDistrict) +      temp_10_15:as.factor(policeDistrict) + temp_5_10:as.factor(policeDistrict) +      temp_0_5:as.factor(policeDistrict) + temp_under_0:as.factor(policeDistrict) +      holiday_bin | year + month + dow, data = df4s) 

    Residuals:
         Min       1Q   Median       3Q      Max 
    -0.76246 -0.18741 -0.12203 -0.03706  1.03619 

    Coefficients:
                                                          Estimate Std. Error
    holiday_bin                                          0.0486357  0.0308707
    temp_over_100:as.factor(policeDistrict)Central       0.0775254  0.0828865
    temp_over_100:as.factor(policeDistrict)Eastern       0.0413062  0.0913134
    temp_over_100:as.factor(policeDistrict)Northeastern  0.6611443  0.1529218
    temp_over_100:as.factor(policeDistrict)Northern      0.1344537  0.2129130
    temp_over_100:as.factor(policeDistrict)Northwestern  0.2766712  0.2592890
    temp_over_100:as.factor(policeDistrict)Southeastern -0.1163919  0.1007540
    temp_over_100:as.factor(policeDistrict)Southern     -0.1499813  0.3644909
    temp_over_100:as.factor(policeDistrict)Southwestern  0.2026404  0.1664597
    temp_over_100:as.factor(policeDistrict)Western      -0.0616206  0.0932455
    as.factor(policeDistrict)Central:temp_95_100        -0.0472704  0.0816147
    as.factor(policeDistrict)Eastern:temp_95_100        -0.1272017  0.0816589
    as.factor(policeDistrict)Northeastern:temp_95_100    0.1701766  0.0874223
    as.factor(policeDistrict)Northern:temp_95_100       -0.1677576  0.0954501
    as.factor(policeDistrict)Northwestern:temp_95_100    0.1578144  0.1007344
    as.factor(policeDistrict)Southeastern:temp_95_100    0.0381590  0.0771498
    as.factor(policeDistrict)Southern:temp_95_100        0.0908775  0.0982071
    as.factor(policeDistrict)Southwestern:temp_95_100   -0.0373173  0.0813845
    as.factor(policeDistrict)Western:temp_95_100         0.0206686  0.0874657
    as.factor(policeDistrict)Central:temp_90_95          0.0342032  0.0740669
    as.factor(policeDistrict)Eastern:temp_90_95         -0.0951515  0.0772434
    as.factor(policeDistrict)Northeastern:temp_90_95     0.0563334  0.0750764
    as.factor(policeDistrict)Northern:temp_90_95         0.0473522  0.0780567
    as.factor(policeDistrict)Northwestern:temp_90_95     0.0992862  0.0792396
    as.factor(policeDistrict)Southeastern:temp_90_95    -0.1075091  0.0726713
    as.factor(policeDistrict)Southern:temp_90_95        -0.0106312  0.0829476
    as.factor(policeDistrict)Southwestern:temp_90_95    -0.0147678  0.0803496
    as.factor(policeDistrict)Western:temp_90_95          0.0007747  0.0732538
    as.factor(policeDistrict)Central:temp_85_90         -0.0055877  0.0658977
    as.factor(policeDistrict)Eastern:temp_85_90         -0.1016347  0.0635349
    as.factor(policeDistrict)Northeastern:temp_85_90     0.1397893  0.0646318
    as.factor(policeDistrict)Northern:temp_85_90         0.0645760  0.0659488
    as.factor(policeDistrict)Northwestern:temp_85_90    -0.0396813  0.0607921
    as.factor(policeDistrict)Southeastern:temp_85_90    -0.0688565  0.0623823
    as.factor(policeDistrict)Southern:temp_85_90        -0.0979721  0.0621520
    as.factor(policeDistrict)Southwestern:temp_85_90    -0.0211536  0.0628144
    as.factor(policeDistrict)Western:temp_85_90          0.0165434  0.0651580
    as.factor(policeDistrict)Central:temp_80_85         -0.0810371  0.0643251
    as.factor(policeDistrict)Eastern:temp_80_85         -0.0387725  0.0638566
    as.factor(policeDistrict)Northeastern:temp_80_85     0.0104655  0.0621721
    as.factor(policeDistrict)Northern:temp_80_85         0.0678471  0.0675630
    as.factor(policeDistrict)Northwestern:temp_80_85     0.0565173  0.0658645
    as.factor(policeDistrict)Southeastern:temp_80_85    -0.0188020  0.0615110
    as.factor(policeDistrict)Southern:temp_80_85        -0.0907239  0.0591038
    as.factor(policeDistrict)Southwestern:temp_80_85    -0.0015804  0.0613142
    as.factor(policeDistrict)Western:temp_80_85         -0.0119843  0.0652410
    as.factor(policeDistrict)Central:temp_75_80          0.0401318  0.0662416
    as.factor(policeDistrict)Eastern:temp_75_80         -0.0873105  0.0687362
    as.factor(policeDistrict)Northeastern:temp_75_80     0.1652992  0.0686286
    as.factor(policeDistrict)Northern:temp_75_80        -0.1045985  0.0628738
    as.factor(policeDistrict)Northwestern:temp_75_80     0.0709454  0.0667408
    as.factor(policeDistrict)Southeastern:temp_75_80     0.0236184  0.0695753
    as.factor(policeDistrict)Southern:temp_75_80        -0.0175552  0.0645346
    as.factor(policeDistrict)Southwestern:temp_75_80    -0.0840542  0.0741351
    as.factor(policeDistrict)Western:temp_75_80         -0.0228661  0.0665003
    as.factor(policeDistrict)Central:temp_70_75          0.0380139  0.0729191
    as.factor(policeDistrict)Eastern:temp_70_75         -0.0277751  0.0703767
    as.factor(policeDistrict)Northeastern:temp_70_75     0.2183997  0.0631356
    as.factor(policeDistrict)Northern:temp_70_75         0.0673482  0.0591688
    as.factor(policeDistrict)Northwestern:temp_70_75     0.1053703  0.0614723
    as.factor(policeDistrict)Southeastern:temp_70_75    -0.0218283  0.0657311
    as.factor(policeDistrict)Southern:temp_70_75        -0.0050545  0.0603254
    as.factor(policeDistrict)Southwestern:temp_70_75     0.0589819  0.0641864
    as.factor(policeDistrict)Western:temp_70_75          0.1139283  0.0728699
    as.factor(policeDistrict)Central:temp_65_70         -0.0166310  0.0815137
    as.factor(policeDistrict)Eastern:temp_65_70         -0.1003160  0.0846889
    as.factor(policeDistrict)Northeastern:temp_65_70     0.0477209  0.0727117
    as.factor(policeDistrict)Northern:temp_65_70         0.0015787  0.0702583
    as.factor(policeDistrict)Northwestern:temp_65_70     0.0440188  0.0707719
    as.factor(policeDistrict)Southeastern:temp_65_70     0.1382450  0.0920984
    as.factor(policeDistrict)Southern:temp_65_70        -0.0623831  0.0717947
    as.factor(policeDistrict)Southwestern:temp_65_70     0.0477824  0.0778112
    as.factor(policeDistrict)Western:temp_65_70          0.0336470  0.0756899
    as.factor(policeDistrict)Central:temp_60_65          0.0994487  0.0838468
    as.factor(policeDistrict)Eastern:temp_60_65         -0.0877543  0.0838807
    as.factor(policeDistrict)Northeastern:temp_60_65     0.2400256  0.0858143
    as.factor(policeDistrict)Northern:temp_60_65         0.1841470  0.0859515
    as.factor(policeDistrict)Northwestern:temp_60_65    -0.0318545  0.0941127
    as.factor(policeDistrict)Southeastern:temp_60_65     0.0140558  0.0856107
    as.factor(policeDistrict)Southern:temp_60_65        -0.0101828  0.0938949
    as.factor(policeDistrict)Southwestern:temp_60_65     0.0792335  0.0893294
    as.factor(policeDistrict)Western:temp_60_65         -0.0712817  0.0913881
    as.factor(policeDistrict)Central:temp_50_55          0.3626571  0.2583376
    as.factor(policeDistrict)Eastern:temp_50_55         -0.1407501  0.2116648
    as.factor(policeDistrict)Northeastern:temp_50_55     0.1199389  0.1319410
    as.factor(policeDistrict)Northern:temp_50_55         0.0108877  0.1406439
    as.factor(policeDistrict)Northwestern:temp_50_55    -0.0420654  0.1093821
    as.factor(policeDistrict)Southeastern:temp_50_55     0.0318492  0.1513814
    as.factor(policeDistrict)Southern:temp_50_55        -0.0306296  0.1251528
    as.factor(policeDistrict)Southwestern:temp_50_55     0.0402052  0.1514462
    as.factor(policeDistrict)Western:temp_50_55         -0.1299032  0.2581309
    as.factor(policeDistrict)Central:temp_45_50          0.0563817  0.1652553
    as.factor(policeDistrict)Eastern:temp_45_50          0.0568920  0.1652356
    as.factor(policeDistrict)Northeastern:temp_45_50    -0.1204071  0.2584410
    as.factor(policeDistrict)Northern:temp_45_50         0.1173452  0.1840849
    as.factor(policeDistrict)Northwestern:temp_45_50           NaN         NA
    as.factor(policeDistrict)Southeastern:temp_45_50    -0.1360279  0.1653099
    as.factor(policeDistrict)Southern:temp_45_50        -0.1281960  0.1841436
    as.factor(policeDistrict)Southwestern:temp_45_50    -0.1515014  0.3639659
    as.factor(policeDistrict)Western:temp_45_50         -0.1232863  0.2588347
    as.factor(policeDistrict)Central:temp_40_45         -0.0995825  0.2581823
    as.factor(policeDistrict)Eastern:temp_40_45         -0.1233342  0.2582055
    as.factor(policeDistrict)Northeastern:temp_40_45     0.1962307  0.2116183
    as.factor(policeDistrict)Northern:temp_40_45        -0.1233342  0.2582055
    as.factor(policeDistrict)Northwestern:temp_40_45    -0.1459522  0.2584550
    as.factor(policeDistrict)Southeastern:temp_40_45    -0.1289013  0.2582209
    as.factor(policeDistrict)Southern:temp_40_45         0.0534749  0.1652980
    as.factor(policeDistrict)Southwestern:temp_40_45    -0.1233342  0.2582055
    as.factor(policeDistrict)Western:temp_40_45         -0.1272650  0.3638579
    as.factor(policeDistrict)Central:temp_35_40                NaN         NA
    as.factor(policeDistrict)Eastern:temp_35_40         -0.0686274  0.3639393
    as.factor(policeDistrict)Northeastern:temp_35_40     0.9313726  0.3639393
    as.factor(policeDistrict)Northern:temp_35_40        -0.0686274  0.3639393
    as.factor(policeDistrict)Northwestern:temp_35_40    -0.1183226  0.2116929
    as.factor(policeDistrict)Southeastern:temp_35_40    -0.0686274  0.3639393
    as.factor(policeDistrict)Southern:temp_35_40        -0.0686274  0.3639393
    as.factor(policeDistrict)Southwestern:temp_35_40    -0.1183226  0.2116929
    as.factor(policeDistrict)Western:temp_35_40          0.3777360  0.2583349
    as.factor(policeDistrict)Central:temp_30_35         -0.1172929  0.3640726
    as.factor(policeDistrict)Eastern:temp_30_35         -0.1515014  0.3639659
    as.factor(policeDistrict)Northeastern:temp_30_35    -0.1515014  0.3639659
    as.factor(policeDistrict)Northern:temp_30_35        -0.1515014  0.3639659
    as.factor(policeDistrict)Northwestern:temp_30_35    -0.1515014  0.3639659
    as.factor(policeDistrict)Southeastern:temp_30_35           NaN         NA
    as.factor(policeDistrict)Southern:temp_30_35               NaN         NA
    as.factor(policeDistrict)Southwestern:temp_30_35    -0.1515014  0.3639659
    as.factor(policeDistrict)Western:temp_30_35                NaN         NA
    as.factor(policeDistrict)Central:temp_25_30          0.8484986  0.3639659
    as.factor(policeDistrict)Eastern:temp_25_30                NaN         NA
    as.factor(policeDistrict)Northeastern:temp_25_30           NaN         NA
    as.factor(policeDistrict)Northern:temp_25_30               NaN         NA
    as.factor(policeDistrict)Northwestern:temp_25_30           NaN         NA
    as.factor(policeDistrict)Southeastern:temp_25_30    -0.1515014  0.3639659
    as.factor(policeDistrict)Southern:temp_25_30        -0.1515014  0.3639659
    as.factor(policeDistrict)Southwestern:temp_25_30           NaN         NA
    as.factor(policeDistrict)Western:temp_25_30         -0.1515014  0.3639659
    as.factor(policeDistrict)Central:temp_20_25                NaN         NA
    as.factor(policeDistrict)Eastern:temp_20_25                NaN         NA
    as.factor(policeDistrict)Northeastern:temp_20_25           NaN         NA
    as.factor(policeDistrict)Northern:temp_20_25               NaN         NA
    as.factor(policeDistrict)Northwestern:temp_20_25           NaN         NA
    as.factor(policeDistrict)Southeastern:temp_20_25           NaN         NA
    as.factor(policeDistrict)Southern:temp_20_25               NaN         NA
    as.factor(policeDistrict)Southwestern:temp_20_25           NaN         NA
    as.factor(policeDistrict)Western:temp_20_25          0.8484986  0.3639659
    as.factor(policeDistrict)Central:temp_15_20         -0.1515014  0.3639659
    as.factor(policeDistrict)Eastern:temp_15_20                NaN         NA
    as.factor(policeDistrict)Northeastern:temp_15_20           NaN         NA
    as.factor(policeDistrict)Northern:temp_15_20               NaN         NA
    as.factor(policeDistrict)Northwestern:temp_15_20           NaN         NA
    as.factor(policeDistrict)Southeastern:temp_15_20    -0.0985352  0.3640692
    as.factor(policeDistrict)Southern:temp_15_20        -0.1515014  0.3639659
    as.factor(policeDistrict)Southwestern:temp_15_20    -0.1515014  0.3639659
    as.factor(policeDistrict)Western:temp_15_20                NaN         NA
    as.factor(policeDistrict)Central:temp_10_15                NaN         NA
    as.factor(policeDistrict)Eastern:temp_10_15                NaN         NA
    as.factor(policeDistrict)Northeastern:temp_10_15           NaN         NA
    as.factor(policeDistrict)Northern:temp_10_15               NaN         NA
    as.factor(policeDistrict)Northwestern:temp_10_15           NaN         NA
    as.factor(policeDistrict)Southeastern:temp_10_15           NaN         NA
    as.factor(policeDistrict)Southern:temp_10_15               NaN         NA
    as.factor(policeDistrict)Southwestern:temp_10_15           NaN         NA
    as.factor(policeDistrict)Western:temp_10_15                NaN         NA
    as.factor(policeDistrict)Central:temp_5_10                 NaN         NA
    as.factor(policeDistrict)Eastern:temp_5_10                 NaN         NA
    as.factor(policeDistrict)Northeastern:temp_5_10            NaN         NA
    as.factor(policeDistrict)Northern:temp_5_10                NaN         NA
    as.factor(policeDistrict)Northwestern:temp_5_10            NaN         NA
    as.factor(policeDistrict)Southeastern:temp_5_10            NaN         NA
    as.factor(policeDistrict)Southern:temp_5_10                NaN         NA
    as.factor(policeDistrict)Southwestern:temp_5_10            NaN         NA
    as.factor(policeDistrict)Western:temp_5_10                 NaN         NA
    as.factor(policeDistrict)Central:temp_0_5                  NaN         NA
    as.factor(policeDistrict)Eastern:temp_0_5                  NaN         NA
    as.factor(policeDistrict)Northeastern:temp_0_5             NaN         NA
    as.factor(policeDistrict)Northern:temp_0_5                 NaN         NA
    as.factor(policeDistrict)Northwestern:temp_0_5             NaN         NA
    as.factor(policeDistrict)Southeastern:temp_0_5             NaN         NA
    as.factor(policeDistrict)Southern:temp_0_5                 NaN         NA
    as.factor(policeDistrict)Southwestern:temp_0_5             NaN         NA
    as.factor(policeDistrict)Western:temp_0_5                  NaN         NA
    as.factor(policeDistrict)Central:temp_under_0              NaN         NA
    as.factor(policeDistrict)Eastern:temp_under_0              NaN         NA
    as.factor(policeDistrict)Northeastern:temp_under_0         NaN         NA
    as.factor(policeDistrict)Northern:temp_under_0             NaN         NA
    as.factor(policeDistrict)Northwestern:temp_under_0         NaN         NA
    as.factor(policeDistrict)Southeastern:temp_under_0         NaN         NA
    as.factor(policeDistrict)Southern:temp_under_0             NaN         NA
    as.factor(policeDistrict)Southwestern:temp_under_0         NaN         NA
    as.factor(policeDistrict)Western:temp_under_0              NaN         NA
                                                        t value Pr(>|t|)    
    holiday_bin                                           1.575  0.11527    
    temp_over_100:as.factor(policeDistrict)Central        0.935  0.34971    
    temp_over_100:as.factor(policeDistrict)Eastern        0.452  0.65105    
    temp_over_100:as.factor(policeDistrict)Northeastern   4.323 1.59e-05 ***
    temp_over_100:as.factor(policeDistrict)Northern       0.631  0.52777    
    temp_over_100:as.factor(policeDistrict)Northwestern   1.067  0.28605    
    temp_over_100:as.factor(policeDistrict)Southeastern  -1.155  0.24811    
    temp_over_100:as.factor(policeDistrict)Southern      -0.411  0.68075    
    temp_over_100:as.factor(policeDistrict)Southwestern   1.217  0.22358    
    temp_over_100:as.factor(policeDistrict)Western       -0.661  0.50877    
    as.factor(policeDistrict)Central:temp_95_100         -0.579  0.56251    
    as.factor(policeDistrict)Eastern:temp_95_100         -1.558  0.11942    
    as.factor(policeDistrict)Northeastern:temp_95_100     1.947  0.05169 .  
    as.factor(policeDistrict)Northern:temp_95_100        -1.758  0.07894 .  
    as.factor(policeDistrict)Northwestern:temp_95_100     1.567  0.11732    
    as.factor(policeDistrict)Southeastern:temp_95_100     0.495  0.62092    
    as.factor(policeDistrict)Southern:temp_95_100         0.925  0.35486    
    as.factor(policeDistrict)Southwestern:temp_95_100    -0.459  0.64661    
    as.factor(policeDistrict)Western:temp_95_100          0.236  0.81321    
    as.factor(policeDistrict)Central:temp_90_95           0.462  0.64427    
    as.factor(policeDistrict)Eastern:temp_90_95          -1.232  0.21812    
    as.factor(policeDistrict)Northeastern:temp_90_95      0.750  0.45311    
    as.factor(policeDistrict)Northern:temp_90_95          0.607  0.54414    
    as.factor(policeDistrict)Northwestern:temp_90_95      1.253  0.21032    
    as.factor(policeDistrict)Southeastern:temp_90_95     -1.479  0.13915    
    as.factor(policeDistrict)Southern:temp_90_95         -0.128  0.89803    
    as.factor(policeDistrict)Southwestern:temp_90_95     -0.184  0.85419    
    as.factor(policeDistrict)Western:temp_90_95           0.011  0.99156    
    as.factor(policeDistrict)Central:temp_85_90          -0.085  0.93243    
    as.factor(policeDistrict)Eastern:temp_85_90          -1.600  0.10979    
    as.factor(policeDistrict)Northeastern:temp_85_90      2.163  0.03064 *  
    as.factor(policeDistrict)Northern:temp_85_90          0.979  0.32758    
    as.factor(policeDistrict)Northwestern:temp_85_90     -0.653  0.51398    
    as.factor(policeDistrict)Southeastern:temp_85_90     -1.104  0.26979    
    as.factor(policeDistrict)Southern:temp_85_90         -1.576  0.11507    
    as.factor(policeDistrict)Southwestern:temp_85_90     -0.337  0.73632    
    as.factor(policeDistrict)Western:temp_85_90           0.254  0.79959    
    as.factor(policeDistrict)Central:temp_80_85          -1.260  0.20785    
    as.factor(policeDistrict)Eastern:temp_80_85          -0.607  0.54378    
    as.factor(policeDistrict)Northeastern:temp_80_85      0.168  0.86634    
    as.factor(policeDistrict)Northern:temp_80_85          1.004  0.31537    
    as.factor(policeDistrict)Northwestern:temp_80_85      0.858  0.39092    
    as.factor(policeDistrict)Southeastern:temp_80_85     -0.306  0.75988    
    as.factor(policeDistrict)Southern:temp_80_85         -1.535  0.12490    
    as.factor(policeDistrict)Southwestern:temp_80_85     -0.026  0.97944    
    as.factor(policeDistrict)Western:temp_80_85          -0.184  0.85427    
    as.factor(policeDistrict)Central:temp_75_80           0.606  0.54467    
    as.factor(policeDistrict)Eastern:temp_75_80          -1.270  0.20411    
    as.factor(policeDistrict)Northeastern:temp_75_80      2.409  0.01608 *  
    as.factor(policeDistrict)Northern:temp_75_80         -1.664  0.09630 .  
    as.factor(policeDistrict)Northwestern:temp_75_80      1.063  0.28788    
    as.factor(policeDistrict)Southeastern:temp_75_80      0.339  0.73429    
    as.factor(policeDistrict)Southern:temp_75_80         -0.272  0.78562    
    as.factor(policeDistrict)Southwestern:temp_75_80     -1.134  0.25698    
    as.factor(policeDistrict)Western:temp_75_80          -0.344  0.73099    
    as.factor(policeDistrict)Central:temp_70_75           0.521  0.60219    
    as.factor(policeDistrict)Eastern:temp_70_75          -0.395  0.69312    
    as.factor(policeDistrict)Northeastern:temp_70_75      3.459  0.00055 ***
    as.factor(policeDistrict)Northern:temp_70_75          1.138  0.25512    
    as.factor(policeDistrict)Northwestern:temp_70_75      1.714  0.08662 .  
    as.factor(policeDistrict)Southeastern:temp_70_75     -0.332  0.73985    
    as.factor(policeDistrict)Southern:temp_70_75         -0.084  0.93323    
    as.factor(policeDistrict)Southwestern:temp_70_75      0.919  0.35822    
    as.factor(policeDistrict)Western:temp_70_75           1.563  0.11806    
    as.factor(policeDistrict)Central:temp_65_70          -0.204  0.83835    
    as.factor(policeDistrict)Eastern:temp_65_70          -1.185  0.23631    
    as.factor(policeDistrict)Northeastern:temp_65_70      0.656  0.51169    
    as.factor(policeDistrict)Northern:temp_65_70          0.022  0.98207    
    as.factor(policeDistrict)Northwestern:temp_65_70      0.622  0.53401    
    as.factor(policeDistrict)Southeastern:temp_65_70      1.501  0.13346    
    as.factor(policeDistrict)Southern:temp_65_70         -0.869  0.38497    
    as.factor(policeDistrict)Southwestern:temp_65_70      0.614  0.53921    
    as.factor(policeDistrict)Western:temp_65_70           0.445  0.65669    
    as.factor(policeDistrict)Central:temp_60_65           1.186  0.23570    
    as.factor(policeDistrict)Eastern:temp_60_65          -1.046  0.29557    
    as.factor(policeDistrict)Northeastern:temp_60_65      2.797  0.00519 ** 
    as.factor(policeDistrict)Northern:temp_60_65          2.142  0.03225 *  
    as.factor(policeDistrict)Northwestern:temp_60_65     -0.338  0.73503    
    as.factor(policeDistrict)Southeastern:temp_60_65      0.164  0.86960    
    as.factor(policeDistrict)Southern:temp_60_65         -0.108  0.91365    
    as.factor(policeDistrict)Southwestern:temp_60_65      0.887  0.37517    
    as.factor(policeDistrict)Western:temp_60_65          -0.780  0.43547    
    as.factor(policeDistrict)Central:temp_50_55           1.404  0.16049    
    as.factor(policeDistrict)Eastern:temp_50_55          -0.665  0.50613    
    as.factor(policeDistrict)Northeastern:temp_50_55      0.909  0.36341    
    as.factor(policeDistrict)Northern:temp_50_55          0.077  0.93830    
    as.factor(policeDistrict)Northwestern:temp_50_55     -0.385  0.70058    
    as.factor(policeDistrict)Southeastern:temp_50_55      0.210  0.83338    
    as.factor(policeDistrict)Southern:temp_50_55         -0.245  0.80668    
    as.factor(policeDistrict)Southwestern:temp_50_55      0.265  0.79066    
    as.factor(policeDistrict)Western:temp_50_55          -0.503  0.61483    
    as.factor(policeDistrict)Central:temp_45_50           0.341  0.73300    
    as.factor(policeDistrict)Eastern:temp_45_50           0.344  0.73064    
    as.factor(policeDistrict)Northeastern:temp_45_50     -0.466  0.64133    
    as.factor(policeDistrict)Northern:temp_45_50          0.637  0.52388    
    as.factor(policeDistrict)Northwestern:temp_45_50        NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_45_50     -0.823  0.41066    
    as.factor(policeDistrict)Southern:temp_45_50         -0.696  0.48638    
    as.factor(policeDistrict)Southwestern:temp_45_50     -0.416  0.67726    
    as.factor(policeDistrict)Western:temp_45_50          -0.476  0.63389    
    as.factor(policeDistrict)Central:temp_40_45          -0.386  0.69974    
    as.factor(policeDistrict)Eastern:temp_40_45          -0.478  0.63293    
    as.factor(policeDistrict)Northeastern:temp_40_45      0.927  0.35386    
    as.factor(policeDistrict)Northern:temp_40_45         -0.478  0.63293    
    as.factor(policeDistrict)Northwestern:temp_40_45     -0.565  0.57232    
    as.factor(policeDistrict)Southeastern:temp_40_45     -0.499  0.61769    
    as.factor(policeDistrict)Southern:temp_40_45          0.324  0.74634    
    as.factor(policeDistrict)Southwestern:temp_40_45     -0.478  0.63293    
    as.factor(policeDistrict)Western:temp_40_45          -0.350  0.72654    
    as.factor(policeDistrict)Central:temp_35_40             NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_35_40          -0.189  0.85045    
    as.factor(policeDistrict)Northeastern:temp_35_40      2.559  0.01055 *  
    as.factor(policeDistrict)Northern:temp_35_40         -0.189  0.85045    
    as.factor(policeDistrict)Northwestern:temp_35_40     -0.559  0.57625    
    as.factor(policeDistrict)Southeastern:temp_35_40     -0.189  0.85045    
    as.factor(policeDistrict)Southern:temp_35_40         -0.189  0.85045    
    as.factor(policeDistrict)Southwestern:temp_35_40     -0.559  0.57625    
    as.factor(policeDistrict)Western:temp_35_40           1.462  0.14380    
    as.factor(policeDistrict)Central:temp_30_35          -0.322  0.74735    
    as.factor(policeDistrict)Eastern:temp_30_35          -0.416  0.67726    
    as.factor(policeDistrict)Northeastern:temp_30_35     -0.416  0.67726    
    as.factor(policeDistrict)Northern:temp_30_35         -0.416  0.67726    
    as.factor(policeDistrict)Northwestern:temp_30_35     -0.416  0.67726    
    as.factor(policeDistrict)Southeastern:temp_30_35        NaN      NaN    
    as.factor(policeDistrict)Southern:temp_30_35            NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_30_35     -0.416  0.67726    
    as.factor(policeDistrict)Western:temp_30_35             NaN      NaN    
    as.factor(policeDistrict)Central:temp_25_30           2.331  0.01981 *  
    as.factor(policeDistrict)Eastern:temp_25_30             NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_25_30        NaN      NaN    
    as.factor(policeDistrict)Northern:temp_25_30            NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_25_30        NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_25_30     -0.416  0.67726    
    as.factor(policeDistrict)Southern:temp_25_30         -0.416  0.67726    
    as.factor(policeDistrict)Southwestern:temp_25_30        NaN      NaN    
    as.factor(policeDistrict)Western:temp_25_30          -0.416  0.67726    
    as.factor(policeDistrict)Central:temp_20_25             NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_20_25             NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_20_25        NaN      NaN    
    as.factor(policeDistrict)Northern:temp_20_25            NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_20_25        NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_20_25        NaN      NaN    
    as.factor(policeDistrict)Southern:temp_20_25            NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_20_25        NaN      NaN    
    as.factor(policeDistrict)Western:temp_20_25           2.331  0.01981 *  
    as.factor(policeDistrict)Central:temp_15_20          -0.416  0.67726    
    as.factor(policeDistrict)Eastern:temp_15_20             NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_15_20        NaN      NaN    
    as.factor(policeDistrict)Northern:temp_15_20            NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_15_20        NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_15_20     -0.271  0.78668    
    as.factor(policeDistrict)Southern:temp_15_20         -0.416  0.67726    
    as.factor(policeDistrict)Southwestern:temp_15_20     -0.416  0.67726    
    as.factor(policeDistrict)Western:temp_15_20             NaN      NaN    
    as.factor(policeDistrict)Central:temp_10_15             NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_10_15             NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_10_15        NaN      NaN    
    as.factor(policeDistrict)Northern:temp_10_15            NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_10_15        NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_10_15        NaN      NaN    
    as.factor(policeDistrict)Southern:temp_10_15            NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_10_15        NaN      NaN    
    as.factor(policeDistrict)Western:temp_10_15             NaN      NaN    
    as.factor(policeDistrict)Central:temp_5_10              NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_5_10              NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_5_10         NaN      NaN    
    as.factor(policeDistrict)Northern:temp_5_10             NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_5_10         NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_5_10         NaN      NaN    
    as.factor(policeDistrict)Southern:temp_5_10             NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_5_10         NaN      NaN    
    as.factor(policeDistrict)Western:temp_5_10              NaN      NaN    
    as.factor(policeDistrict)Central:temp_0_5               NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_0_5               NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_0_5          NaN      NaN    
    as.factor(policeDistrict)Northern:temp_0_5              NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_0_5          NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_0_5          NaN      NaN    
    as.factor(policeDistrict)Southern:temp_0_5              NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_0_5          NaN      NaN    
    as.factor(policeDistrict)Western:temp_0_5               NaN      NaN    
    as.factor(policeDistrict)Central:temp_under_0           NaN      NaN    
    as.factor(policeDistrict)Eastern:temp_under_0           NaN      NaN    
    as.factor(policeDistrict)Northeastern:temp_under_0      NaN      NaN    
    as.factor(policeDistrict)Northern:temp_under_0          NaN      NaN    
    as.factor(policeDistrict)Northwestern:temp_under_0      NaN      NaN    
    as.factor(policeDistrict)Southeastern:temp_under_0      NaN      NaN    
    as.factor(policeDistrict)Southern:temp_under_0          NaN      NaN    
    as.factor(policeDistrict)Southwestern:temp_under_0      NaN      NaN    
    as.factor(policeDistrict)Western:temp_under_0           NaN      NaN    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Residual standard error: 0.3617 on 2713 degrees of freedom
    Multiple R-squared(full model): 0.08016   Adjusted R-squared: 0.03133 
    Multiple R-squared(proj model): 0.0633   Adjusted R-squared: 0.01359 
    F-statistic(full model):1.642 on 144 and 2713 DF, p-value: 4.161e-06 
    F-statistic(proj model): 0.965 on 190 and 2713 DF, p-value: 0.6191 
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


police_districts<-vect("/Users/roshan/Downloads/UMD/Fall-2024/FIRE298/research-Greenspace/Police_Districts_2023/Police_Districts_2023.shp")

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

    quartz_off_screen 
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

    quartz_off_screen 
                    2 

Future Plans:

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
