
"""
    HP(x::Vector, λ::Real)

Apply the Hodrick-Prescott decomposition to vector x with multiplier value λ
"""

function HP(x::Vector, λ::Real)
    n = length(x)
    m = 2
    @assert n > m
    #I = Diagonal(ones(n))
    D = spdiagm(n, n-m, 0 => fill(1.0, n-m),
        -1 => fill(-2.0, n-m),
        -2 => fill(1.0, n-m) )
    #@inbounds D = D[1:n,1:n-m]
    return (I + λ * D * D') \ x
end

"""
    HP(x::Vector, λ::Real, iter::Int)

Compute boosted Hodrick-Prescott filter with number of iterations specified by iter
"""

function HP(x::Vector, λ::Real, iter::Int)
    n = length(x)
    m = 2
    @assert n > m
    I = Diagonal(ones(n))
    D = spdiagm(n, n-m, 0 => fill(1.0, n-m),
        -1 => fill(-2.0, n-m),
        -2 => fill(1.0, n-m) )
    #@inbounds D = D[1:n,1:n-m]
    S = (I + λ * D * D')
    #G = "Test for scope"
    function solve(S,x,iter)
        f = S \ x
        #@printf "%s" G
        #l = "test 2"
        if iter > 1
            return solve(S,x-f,iter-1)
        else
            return x-f
        end
    end
    #@printf "%s" l
    return x - solve(S,x,iter)
end


"""
    bHP(x::Vector, λ::Real; Criterion="BIC", max_iter::Int = 100, p::Float64=0.05)

Compute boosted Hodrick-Prescott filter with stop criterion using either a Bayesian-type
information criterion (BIC) or an augmented Dickey-Fuller (ADF) test

"""

######

function bHP(x::Vector, λ::Real; Criterion="BIC", max_iter::Int = 100, p::Float64=0.05)
    n = length(x)
    m = 2
    @assert n > m
    #I = Diagonal(ones(n))
    D = diagm(n, n-m, 0 => fill(1.0, n-m),
        -1 => fill(-2.0, n-m),
        -2 => fill(1.0, n-m) )
    #@inbounds D = D[1:n,1:n-m]
    S = I + λ * D * D'

    if Criterion == "BIC"
        S = inv(S)
        c_j = x
        c_p = Array{Float64, 1}()
        c_hp = Array{Float64, 1}()
        B = 1.0
        IC = Vector{Float32}()
        for i in 1:max_iter
            c_p = c_j
            c_j = (I - S) * c_j
            if i == 1
                c_hp = c_j
            end
            B *= (I - S)
            B_j = I - B
            push!(IC, var(c_j) / var(c_hp) + log(n) * tr(B_j) / tr(I - S))
            if i > 1 && IC[i] > IC[i-1]
                #println("Number of iterations = $(i-1)")
                break
            end
        end
        return x - c_p
    end

    if Criterion == "ADF"
        iter = max_iter
        function solve(S,x,iter,p)
            f = S \ x
            p_adf = pvalue( ADFTest(x-f, :trend, Int(floor((length(x)-1)^(1/3)))))
            if iter > 1 && p_adf > p
                return solve(S,x-f,iter-1,p)
            else
                println("p-value: ", p_adf)
                println("Number of iterations: ", max_iter  - iter + 1)
                return x-f
            end
        end
        return x - solve(S,x,iter,p)
    end
end
