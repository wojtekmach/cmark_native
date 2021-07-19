defmodule CmarkNative.MixProject do
  use Mix.Project

  def project do
    [
      app: :cmark_native,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      xref: [
        exclude: [
          Cmark.Nif
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    target =
      case :os.type() do
        {:win32, _} ->
          :"windows_#{:erlang.system_info(:wordsize) * 8}"

        {:unix, osname} ->
          arch_str = :erlang.system_info(:system_architecture)
          [arch | _] = arch_str |> List.to_string() |> String.split("-")
          :"#{osname}_#{arch}"
      end

    Mix.target(target)

    targets = [
      :darwin_aarch64,
      :darwin_x86_64,
      :linux_aarch64,
      :linux_x86_64
    ]

    for target <- targets do
      name = "cmark_native_#{target}"

      opts =
        if Mix.env() in [:dev, :test] do
          [path: "../#{name}", targets: [target]]
        else
          [github: "wojtekmach/cmark_native", sparse: name, targets: [target]]
        end

      {String.to_atom(name), opts}
    end
  end
end
