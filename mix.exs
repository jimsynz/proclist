defmodule NeonProclist.MixProject do
  use Mix.Project

  @moduledoc """
  Elixir bindings to the `proclist` crate.
  """

  @version "0.1.3"

  @nerves_rust_target_triple_mapping %{
    "armv6-nerves-linux-gnueabihf": "arm-unknown-linux-gnueabihf",
    "armv7-nerves-linux-gnueabihf": "armv7-unknown-linux-gnueabihf",
    "aarch64-nerves-linux-gnu": "aarch64-unknown-linux-gnu",
    "x86_64-nerves-linux-musl": "x86_64-unknown-linux-musl"
  }

  def project do
    if is_binary(System.get_env("NERVES_SDK_SYSROOT")) do
      components =
        System.get_env("CC")
        |> tap(&System.put_env("RUSTFLAGS", "-C linker=#{&1}"))
        |> Path.basename()
        |> String.split("-")

      target_triple =
        components
        |> Enum.slice(0, Enum.count(components) - 1)
        |> Enum.join("-")

      mapping = Map.get(@nerves_rust_target_triple_mapping, String.to_atom(target_triple))

      if String.ends_with?(mapping, "-musl") do
        rustflags =
          [System.get_env("RUSTFLAGS"), "--codegen target-feature=-crt-static"]
          |> Enum.reject(&is_nil/1)
          |> Enum.join(" ")

        System.put_env("RUSTFLAGS", rustflags)
      end

      if is_binary(mapping) do
        System.put_env("RUSTLER_TARGET", mapping)
      end
    end

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
      {:rustler, "~> 0.37", runtime: false},

      # dev/test
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:doctor, "~> 0.22", only: [:dev, :test], runtime: false},
      {:ex_check, "~> 0.16", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.40", only: [:dev, :test], runtime: false},
      {:git_ops, "~> 2.0", only: [:dev, :test], runtime: false},
      {:igniter, "~> 0.7", only: [:dev, :test]}
    ]
  end
end
