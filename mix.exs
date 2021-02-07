defmodule WorldJobs.MixProject do
  use Mix.Project

  def project do
    [
      app: :world_jobs,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {WebhookProcessor.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_csv, "~> 1.0"},
      {:topo, "~> 0.4.0"},
      {:table_rex, "~> 3.1.1"},
      {:plug_cowboy, "~> 2.0"},
      {:poison, "~> 3.1"}
    ]
  end
end
