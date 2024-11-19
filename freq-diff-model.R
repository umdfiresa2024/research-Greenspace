library("tidyverse")

panel<-read.csv("panel.csv");

f = function(x) function(v) length(v[v==x])
df<-panel %>%
    mutate(temp=5*floor(temp_F/5), call_bin=(as.numeric(callscount>0)))
temp_freq<-df %>%
    group_by(policeDistrict, temp) %>%
    summarise(freq=n())
df<-left_join(df, temp_freq)

# model to predict probabilty of call occuring for a given temperture taking into account frequency of that temperature alone
m1 = lm(call_bin ~ freq, df)
m1_apply<-function(n) (function(v) v[1]+n*v[2])(as.numeric(m1$coefficients))

# model to predict probability of call occurring taking into account both temperature value and frequency
m2 = lm(call_bin ~ freq + temp, df)
m2_apply<-function(n,t) (function(v) v[1]+n*v[2]+t*v[3])(as.numeric(m2$coefficients))

result<-select(.data=df, policeDistrict, date, call_bin, temp, freq) %>%
    mutate(cht_freq=m1_apply(freq),
           er2_freq=(cht_freq-call_bin)**2,
           cht_freqtemp=m2_apply(freq,temp),
           er2_freqtemp=(cht_freqtemp-call_bin)**2)

sprintf("MSE for model 1 (freq alone): %f", mean(result$er2_freq))
sprintf("MSE for model 2 (frq & temp): %f", mean(result$er2_freqtemp))
summary(m1)
summary(m2)

t.test(x=result$er2_freq-result$er2_freqtemp,
       mu=0,
       alternative="greater")
