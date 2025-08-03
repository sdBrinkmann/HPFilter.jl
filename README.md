TrendDecomposition.jl
=====================

TrendDecomposition.jl is a Julia module for decomposition of time series into trend and cycle components. More generally it provides 
both (stochastic) trend component estimation and forecasting, though not all methods are suitable for forecasting.

By using filters and smoothers the most pragmatic approach to trend decomposition is estimating the trend $t$ and defining
the cyclical component $c$ of time series $y$ as $c = y - t$.
Often it is up to the user of this module to calculate the cyclical components themselves with the computed trend returned from a function 
provided by this module.

For now this module implements the Hodrick-Prescott (HP) filter as well as its generalization,
generally known as Whittaker-Henderson smoothing, in this package named bohl_filter after its first inventor George Bohlmann.

In addition this module tries to implement also more novel approaches; so far the boosted HP Filter based 
on Peter Phillips and Zhentao Shi (2019): "[Boosting the Hodrick-Prescott Filter](https://arxiv.org/abs/1905.00175)" 
has been implemented.



Get Started
-----------------
This module can either be employed  by cloning this repository or by using the Julia package manager.
With the package manager simply use the add command:
```Julia
(v1.11) pkg> add https://github.com/sdBrinkmann/TrendDecomposition.jl
```

Usage
----------------
The basic usage is demonstrated with the [US industrial production index (IPI)](https://fred.stlouisfed.org/series/IPB50001SQ) provided by FRED data service.

```Julia
using TrendDecomposition
using CSV

# Set path to directory where time series is located
path = "/.../data"

IPI = CSV.read("$(path)/IPB50001SQ.csv", copycols=true)

# HP filter with λ = 1600
hp = HP(IPI[!, 2], 1600)

# The above is equivalent to Whittaker-Henderson smoothing with m = 2 differentiation
wh = bohl_filter(IPI[!, 2], 2, 1600)

# Boosted HP filter with baysian-type information criterion (BIC)
bHP_bic = bHP(IPI[!, 2], 1600, Criterion="BIC")

# Boosted HP filter with augmented Dickey-Fuller (ADF) test 
bHP_adf = bHP(IPI[!, 2], 1600, Criterion="ADF", p=0.01)
```

![HP Results](IPI_HP.png "Plotted Results")
