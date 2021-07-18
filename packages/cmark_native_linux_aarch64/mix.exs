defmodule CmarkNativeLinuxAarch64.MixProject do
  use Mix.Project

  def project do
    [
      app: :cmark_native_linux_aarch64,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
