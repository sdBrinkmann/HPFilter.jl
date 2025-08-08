using Documenter, TrendDecomposition

makedocs(
    sitename = "TrendDecomposition",
    modules = [TrendDecomposition],
	pages = [
		"Introduction" => "index.md",
		"Get Started" => "man/start.md",
		"API" => "man/api.md",
		 ]	
	)


deploydocs(
    repo = "github.com/sdBrinkmann/TrendDecomposition.jl.git",
)
