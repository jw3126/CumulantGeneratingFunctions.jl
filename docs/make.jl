using CumulantGeneratingFunctions
using Documenter

DocMeta.setdocmeta!(CumulantGeneratingFunctions, :DocTestSetup, :(using CumulantGeneratingFunctions); recursive=true)

makedocs(;
    modules=[CumulantGeneratingFunctions],
    authors="Jan Weidner <jw3126@gmail.com> and contributors",
    repo="https://github.com/jw3126/CumulantGeneratingFunctions.jl/blob/{commit}{path}#{line}",
    sitename="CumulantGeneratingFunctions.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jw3126.github.io/CumulantGeneratingFunctions.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jw3126/CumulantGeneratingFunctions.jl",
    devbranch="main",
)
