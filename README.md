# CumulantGeneratingFunctions

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jw3126.github.io/CumulantGeneratingFunctions.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jw3126.github.io/CumulantGeneratingFunctions.jl/dev/)
[![Build Status](https://github.com/jw3126/CumulantGeneratingFunctions.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jw3126/CumulantGeneratingFunctions.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/jw3126/CumulantGeneratingFunctions.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/jw3126/CumulantGeneratingFunctions.jl)

This package exports one function `cgf` that calculates the [cumulant-generating-function](https://en.wikipedia.org/wiki/Cumulant) of a distribution:

```julia
julia> using Distributions, CumulantGeneratingFunctions

julia> cgf(Normal(0,1), 100)
5000.0
```
