defmodule SendGrid.Mixfile do
  use Mix.Project

  def project do
    [app: :sendgrid,
     version: "1.8.0",
     elixir: "~> 1.4",
     package: package(),
     compilers: compilers(Mix.env),
     description: description(),
     source_url: project_url(),
     homepage_url: project_url(),
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     xref: [exclude: [Phoenix.View]]
    ]
  end

  def application do
    [
      extra_applications: [
        :logger
      ]
    ]
  end

  # Use Phoenix compiler depending on environment.
  defp compilers(:test), do: [:phoenix] ++ Mix.compilers()
  defp compilers(_), do: Mix.compilers()

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:earmark, "~> 1.2.2", only: :dev},
      {:ex_doc, "~> 0.18.1", only: :dev},
      {:httpoison, "~> 0.13.0"},
      {:poison,  ">= 2.0.0 or >= 3.0.0"},
      {:phoenix, "~> 1.3"},
      {:phoenix_html, "~> 2.10.4"}
    ]
  end

  defp description do
    """
    A wrapper for SendGrid's API to create composable emails.
    """
  end

  defp project_url do
    """
    https://github.com/alexgaribay/sendgrid_elixir
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "LICENSE", "README.md"],
      maintainers: ["Alex Garibay"],
      licenses: ["MIT"],
      links: %{"GitHub" => project_url()}
    ]
  end

end
