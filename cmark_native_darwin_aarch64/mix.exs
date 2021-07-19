defmodule CmarkNativeDarwinAarch64.MixProject do
  use Mix.Project

  def project do
    [
      app: :cmark_native_darwin_aarch64,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [
        organization: "hex",
        links: %{},
        licenses: ["Apache-2.0"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:cmark, "~> 0.10", only: [:dev, :test]}
    ]
  end
end
