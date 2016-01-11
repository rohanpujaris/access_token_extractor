defmodule AccessTokenExtractor.Mixfile do
  use Mix.Project

  def project do
    [app: :access_token_extractor,
     version: "0.1.1",
     description: description,
     package: packages,
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end


  def application do
    [applications: [:logger]]
  end


  defp deps do
    [{:cowboy, "~> 1.0.0"},
     {:plug, "~> 1.0"},
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.11", only: :dev}]
  end

  defp description do
    """
    Simple Plug to extract access_token from request and add it to private map in Plug.Conn struct.
    """
  end

  defp packages do
    [
      files: ["lib", "priv", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Rohan Pujari"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/rohanpujaris/access_token_extractor"}
    ]
  end
end
