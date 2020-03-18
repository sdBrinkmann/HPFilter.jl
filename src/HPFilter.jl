module HPFilter

using LinearAlgebra
using SparseArrays
using HypothesisTests
using Statistics

include("HPFilterFunc.jl")
greet() = print("Hello World!")

export HP, bHP

end # module
