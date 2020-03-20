HPFilter.jl
=====================

HPFilter.jl is a Julia module that implements the Hodrick-Prescott (HP) Filter as well as the 
boosted HP Filter based on based on Peter Phillips and Zhentao Shi (2019): "[Boosting the Hodrick-Prescott Filter](https://arxiv.org/abs/1905.00175)".

The original implementation in R by one of the coauthors can be found [here](https://github.com/zhentaoshi/Boosted_HP_filter).

Get Started
-----------------
This module can either be employed  by cloning this repository or by using the Julia package manager.
With the package manager simply use the add command:
```Julia
(v1.3) pkg> add https://github.com/sdBrinkmann/HPFilter.jl
```

Usage
----------------
The basic usage is demonstrated with the [US industrial production index (IPI)](https://fred.stlouisfed.org/series/IPB50001SQ) provided by FRED data service.

```Julia
using HPFilter
using CSV

# Set path to directory where time series is located
path = "/.../data"

IPI = CSV.read("$(path)/IPB50001SQ.csv", copycols=true)

# HP filter with λ = 1600
hp = HP(IPI[!, 2], 1600)

# Boosted HP filter with baysian-type information criterion (BIC)
bHP_bic = bHP(IPI[!, 2], 1600, Criterion="BIC")

# Boosted HP filter with augmented Dickey-Fuller (ADF) test 
bHP_adf = bHP(IPI[!, 2], 1600, Criterion="ADF", p=0.01)
```

![HP Results](IPI_HP.png "Plotted Results")
