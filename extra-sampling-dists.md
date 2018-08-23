---
title: "CONJ620: CM 3.5- Extra Extra"
subtitle: "Explainer on Sampling Distributions"
author: "Alison Presmanes Hill"
output:
  html_document:
    keep_md: TRUE
    highlight: pygments
    theme: flatly
    smart: false
    toc: TRUE
    toc_float: TRUE
---







# Introduction

If you want to knit this .Rmd file, you'll need to load the `tidyverse` package. I use functions from `dplyr`, `tidyr`, and `ggplot2` specifically.


```r
library(tidyverse)
```

# The Population Distribution

...where the number of samples, n = 1 die

First, let's create a data frame that defines our sample space. Remember, our sample space is about what is *possible*, not *probable*. The variables here are:

* x = number of pips on our n = 1 die



```r
omega_n1 <- expand.grid(rep(list(1:6), 1))
omega_n1 <- omega_n1 %>%
  data.frame()
names(omega_n1) <- c("x")
omega_n1
```

```
  x
1 1
2 2
3 3
4 4
5 5
6 6
```

Now, let's move on to thinking about what is *probable*, given that we have defined what is *possible*. The `group_by` here is not totally necessary, as each value of `x` only occurs once, but this syntax will be useful in the future to you... 


```r
x_probs_n1 <- omega_n1 %>% 
  group_by(x) %>%
  summarise(count = n(), 
            p_i = count/6) # equally probable, right?
x_probs_n1
```

```
# A tibble: 6 x 3
      x count   p_i
  <int> <int> <dbl>
1     1     1 0.167
2     2     1 0.167
3     3     1 0.167
4     4     1 0.167
5     5     1 0.167
6     6     1 0.167
```

That's it! This is the population distribution, which is the same as the sampling distribution of sample means for one dice roll.

# Our First Sampling Distribution: 2 die

...where the number of samples (die), n = 2 die

First, let's create a data frame that defines our sample space. Remember, our sample space is about what is *possible*, not *probable*. The variables here are:

* x = number of pips on our n = 2 die


```r
omega_n2 <- expand.grid(rep(list(1:6), 2))
omega_n2 <- omega_n2 %>%
  data.frame()
names(omega_n2) <- c("die1", "die2")
omega_n2
```

```
   die1 die2
1     1    1
2     2    1
3     3    1
4     4    1
5     5    1
6     6    1
7     1    2
8     2    2
9     3    2
10    4    2
11    5    2
12    6    2
13    1    3
14    2    3
15    3    3
16    4    3
17    5    3
18    6    3
19    1    4
20    2    4
21    3    4
22    4    4
23    5    4
24    6    4
25    1    5
26    2    5
27    3    5
28    4    5
29    5    5
30    6    5
31    1    6
32    2    6
33    3    6
34    4    6
35    5    6
36    6    6
```

_Question 1:_ How many different possible combinations of pips from die1 and die2 are possible? 

Second, given that we know our random variable is a statistic- the mean number of pips across die1 and die2- what are the sample means of all possible samples in sample space?

Use the `dplyr` function `mutate` to create a new variable that is the mean number of pips for all possible combinations.


```r
omega_n2 <- omega_n2 %>%
  mutate(xbar_i = (die1 + die2)/2)
omega_n2
```

```
   die1 die2 xbar_i
1     1    1    1.0
2     2    1    1.5
3     3    1    2.0
4     4    1    2.5
5     5    1    3.0
6     6    1    3.5
7     1    2    1.5
8     2    2    2.0
9     3    2    2.5
10    4    2    3.0
11    5    2    3.5
12    6    2    4.0
13    1    3    2.0
14    2    3    2.5
15    3    3    3.0
16    4    3    3.5
17    5    3    4.0
18    6    3    4.5
19    1    4    2.5
20    2    4    3.0
21    3    4    3.5
22    4    4    4.0
23    5    4    4.5
24    6    4    5.0
25    1    5    3.0
26    2    5    3.5
27    3    5    4.0
28    4    5    4.5
29    5    5    5.0
30    6    5    5.5
31    1    6    3.5
32    2    6    4.0
33    3    6    4.5
34    4    6    5.0
35    5    6    5.5
36    6    6    6.0
```

_Question 2:_ How many unique sample means are possible?


```r
omega_n2 %>% 
  select(xbar_i) %>%
  distinct()
```

```
   xbar_i
1     1.0
2     1.5
3     2.0
4     2.5
5     3.0
6     3.5
7     4.0
8     4.5
9     5.0
10    5.5
11    6.0
```

Now, we are ready to consider probabilities, and we want the probabilities for each distinct sample mean.


```r
xbar_probs_n2 <- omega_n2 %>% 
  group_by(xbar_i) %>% 
  summarise(count = n(), # number of rows
            p_i = count/36) %>% # again, equally probable, right??
  arrange(xbar_i)
xbar_probs_n2
```

```
# A tibble: 11 x 3
   xbar_i count    p_i
    <dbl> <int>  <dbl>
 1    1       1 0.0278
 2    1.5     2 0.0556
 3    2       3 0.0833
 4    2.5     4 0.111 
 5    3       5 0.139 
 6    3.5     6 0.167 
 7    4       5 0.139 
 8    4.5     4 0.111 
 9    5       3 0.0833
10    5.5     2 0.0556
11    6       1 0.0278
```

Sanity check: do all the probabilities sum to 1?


```r
xbar_probs_n2 %>%
  summarise(sum_of_ps = sum(p_i))
```

```
# A tibble: 1 x 1
  sum_of_ps
      <dbl>
1         1
```

Finally, let's calculate the expected value of the sample mean! That is, 

$E(\bar{x}) = \sum{\bar{x_i}p_i}$


```r
xbar_samp_n2 <- xbar_probs_n2 %>%
  mutate(e_x_i = xbar_i * p_i)
xbar_samp_n2
```

```
# A tibble: 11 x 4
   xbar_i count    p_i  e_x_i
    <dbl> <int>  <dbl>  <dbl>
 1    1       1 0.0278 0.0278
 2    1.5     2 0.0556 0.0833
 3    2       3 0.0833 0.167 
 4    2.5     4 0.111  0.278 
 5    3       5 0.139  0.417 
 6    3.5     6 0.167  0.583 
 7    4       5 0.139  0.556 
 8    4.5     4 0.111  0.5   
 9    5       3 0.0833 0.417 
10    5.5     2 0.0556 0.306 
11    6       1 0.0278 0.167 
```

```r
xbar_samp_n2 %>%
  summarise(e_xbar = sum(e_x_i))
```

```
# A tibble: 1 x 1
  e_xbar
   <dbl>
1    3.5
```


# Our Second Sampling Distribution: 3 die

1. Make a data frame that defines your sample space. How many different possible combinations of pips from die1, die2, and die3 are possible? 
2. Calculate the mean number of pips for each possible combination. These are your $\bar{x_i}$ values. How many unique values of $\bar{x_i}$ are possible? 
3. Calculate the probabilities for each distinct sample mean, so your $p_i$ values.
4. Calculate the expected value of the sample mean! That is, the value of $E(\bar{x}) = \sum{\bar{x_i}p_i}$.
5. Care to hazard a guess as to the expected value of the sample mean for 4 die?
