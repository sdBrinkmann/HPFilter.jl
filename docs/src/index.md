# TrendDecomposition.jl

Welcome to the TrendDecomposition.jl documentation.

TrendDecomposition.jl is a Julia package for decomposition of time series into trend and cycle components. More generally it provides 
both (stochastic) trend component estimation and forecasting, though not all methods are suitable for forecasting.

By using filters and smoothers the most pragmatic approach to trend decomposition is estimating the trend $t$ and defining
the cyclical component $c$ of time series $y$ as $c = y - t$.
Often it is up to the user of this module to calculate the cyclical components themselves with the computed trend returned from a function 
provided by this module.

For now this package implements the Hodrick-Prescott (HP) filter as well as its generalization,
generally known as Whittaker-Henderson smoothing, in this package named bohl_filter after its first inventor George Bohlmann.

In addition this module tries to implement also more novel approaches; so far the boosted HP Filter based 
on Peter Phillips and Zhentao Shi (2019): "[Boosting the Hodrick-Prescott Filter](https://arxiv.org/abs/1905.00175)" 
has been implemented.
