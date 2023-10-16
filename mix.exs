defmodule Sort.MixProject do
  use Mix.Project

  def project do
    [
      app: :sort,
      version: "1.0.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        c: :test,
        coveralls: :test,
        "coveralls.json": :test,
        "coveralls.html": :test,
        t: :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Parse JSON file: github.com/michalmuskala/jason
      {:jason, "~> 1.1"},

      # Create docs for publishing Hex.docs: github.com/elixir-lang/ex_doc
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},

      # Check test coverage: github.com/parroty/excoveralls
      {:excoveralls, "~> 0.18.0", only: :test}
    ]
  end

  defp description() do
    "A collection of sort objects used in our App"
  end

  defp package() do
    [
      files: ["lib/sort.ex", "mix.exs", "README.md"],
      name: "sort",
      licenses: ["GPL-2.0-or-later"],
      maintainers: ["dwyl"],
      links: %{"GitHub" => "https://github.com/dwyl/sort"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix c
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      t: ["test"],
      c: ["coveralls.html"]
    ]
  end
end
