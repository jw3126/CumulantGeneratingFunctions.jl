using CumulantGeneratingFunctions
using Test
using Distributions
import ForwardDiff

@testset "CumulantGeneratingFunctions.jl" begin
    d(f) = Base.Fix1(ForwardDiff.derivative, f)
    mk(dist, ts; compare_logmf=true) = (;dist=dist, ts=ts, compare_logmf)

    @testset "$(item.dist)" for item in [
        mk(Bernoulli(0.5),           Any[1f0, -1f0,1e6, -1e6]),
        mk(Bernoulli(0.1),           Any[1f0, -1f0,1e6, -1e6]),
        mk(Geometric(0.1),           Any[1f0, 1e6]           ),
        mk(Geometric(0.5),           Any[1f0, 1e6]           ),
        mk(Binomial(10,0.1),         Any[1f0, -1f0,1e6, -1e6]),
        mk(Binomial(100,1f-3),       Any[1f0, -1f0,1e6, -1e6]),
        mk(Geometric(0.5),           Any[1f0, 1e6]           ),
        mk(NegativeBinomial(10,0.5), Any[-1f0, -200.0,-1e6]  , compare_logmf=false),
        mk(NegativeBinomial(3,0.1), Any[-1f0, -200.0,-1e6]  , compare_logmf=false),
        mk(Poisson(1),               Any[1f0,2f0,10.0,50.0]),
        mk(Poisson(10),               Any[1f0,2f0,10.0,50.0]),
        mk(Poisson(1e-3),               Any[1f0,2f0,10.0,50.0]),
        mk(Uniform(0,1),               Any[1, -1, 100f0, 1e6, -1e6]),
        mk(Normal(0,1),               Any[1, -1, 100f0, 1e6, -1e6]),
        mk(Normal(1,0.4),               Any[1, -1, 100f0, 1e6, -1e6]),
        mk(Exponential(1),               Any[0.9, -1, -100f0, -1e6]),
        mk(Exponential(0.91),               Any[0.9, -1, -100f0, -1e6]),
        mk(Exponential(10),           Any[0.08, -1, -100f0, -1e6]),
                   ]
        dist = item.dist
        κ₀ = cgf(dist, 0)
        @test κ₀ ≈ 0 atol=2*eps(one(κ₀))
        κ₁ = d(Base.Fix1(cgf, dist))(0)
        @test κ₁ ≈ mean(dist)
        κ₂ = d(d(Base.Fix1(cgf, dist)))(0)
        @test κ₂ ≈ var(dist)
        
        for t in item.ts
            val = @inferred cgf(dist, t)
            @test isfinite(val)
            compare_logmf = item.compare_logmf
            compare_logmf || continue
            try
                compare_logmf = isfinite((log∘mgf)(dist, t))
            catch err
                continue
            end
            if compare_logmf
                rtol = eps(float(one(t)))^(1/3)
                @test (exp∘cgf)(dist, t) ≈ mgf(dist, t) rtol=rtol
            end
        end
    end
end
