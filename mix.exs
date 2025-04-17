defmodule NeonProclist.MixProject do
  use Mix.Project

  @moduledoc """
  Elixir bindings to the `proclist` crate.
  """

  @version "0.1.0"
  def project do
    [
      app: :proclist,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      package: package(),
      description: @moduledoc,
      consolidate_protocols: Mix.env() != :dev,
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md", "CHANGELOG.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def package do
    [
      mantainers: ["James Harton <james@harton.dev>"],
      licenses: [],
      links: %{
        "Source" => "https://harton.dev/james/proclist",
        "Sponsor" => "https://github.com/sponsors/jimsynz"
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler_precompiled, "~> 0.8"},
      {:rustler,
       github: "jimsynz/rustler",
       subdir: "rustler_mix",
       branch: "improvement/mix_rustler.clippy",
       runtime: false,
       override: true},
      # {:rustler, "~> 0.36", runtime: false, optional: true},

      # dev/test
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:doctor, "~> 0.22", only: [:dev, :test], runtime: false},
      {:earmark, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_check, "~> 0.16", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.37", only: [:dev, :test], runtime: false},
      {:git_ops, "~> 2.0", only: [:dev, :test], runtime: false},
      {:igniter, "~> 0.5", only: [:dev, :test]}
    ]
  end
end
