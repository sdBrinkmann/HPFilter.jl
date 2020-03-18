module HPFilter

using LinearAlgebra
using SparseArrays
using  HypothesisTests

include("HPFilterFunc.jl")
greet() = print("Hello World!")

export HPfilter

end # module
