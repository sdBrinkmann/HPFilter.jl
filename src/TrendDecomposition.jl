module TrendDecomposition

using LinearAlgebra
using SparseArrays
using HypothesisTests
using Statistics

include("HPFilter.jl")
greet() = print("Hello World!")

export HP, bHP, bohl_filter

end # module
