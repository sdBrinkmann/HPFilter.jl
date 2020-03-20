HPFilter.jl
=====================

HPFilter.jl is a Julia module that implements the Hodrick-Prescott (HP) Filter as well as the 
boosted HP Filter based on based on Peter Phillips and Zhentao Shi (2019): "[Boosting the Hodrick-Prescott Filter](https://arxiv.org/abs/1905.00175)".

The original implementation in R by one of the coauthors can be found [here](https://github.com/zhentaoshi/Boosted_HP_filter).

Get Started
-----------------
This module can either be employed  by cloning this repository or by using the Julia package manager.
With the package manager type in the Julia  REPL:
```Julia
using Pkg
Pkg.add("https://github.com/sdbrinkmann/HPFilter.jl.git")
```

Example
----------------

