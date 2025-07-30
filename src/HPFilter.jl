module HPFilter

using LinearAlgebra
using SparseArrays
using HypothesisTests
using Statistics

include("HPFilterFunc.jl")
greet() = print("Hello World!")

export HP, bHP, bohl_filter

end # module
