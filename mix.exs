defmodule ChunkCSV.Mixfile do
  use Mix.Project

  def project do
    [app: :chunk_csv,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     description: description()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:benchfella, "~> 0.3.0", only: [:dev]},
      {:ex_spec,    "~> 2.0.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE*"],
      maintainers: ["Nghia Le Van"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/leogi/chunk_csv"}
    ]
  end

  defp description do
    """
    Chunk CSV
    """
  end
end
