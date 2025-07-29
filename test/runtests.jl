println("Testing...")

using Random, Distributions, Statistics, Test
using HPFilter

Random.seed!(7886)

ϵ = rand(Normal(0, 16), 200)

ζ = rand(Normal(0, 1), 200)

μ = zeros(200)
β = zeros(200)


for t in 2:200
    β[t] = β[t-1] + ζ[t]
end

for t in 2:200
    μ[t] = μ[t-1] + β[t-1]
end



x = range(1, 200, 200)

y = μ + ϵ

q = 1 / 16^2
λ = 1 / q

@test true

@testset "Iteration" begin
    @test HP(y, λ) ≈ HP(y, λ, 1)

end

@testset "Errors" begin
    @test_throws AssertionError HP([1], λ)
end
