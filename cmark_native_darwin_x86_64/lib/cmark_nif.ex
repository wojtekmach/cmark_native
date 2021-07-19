if Mix.env() in [:dev, :test] do
  File.mkdir_p!("priv")
  File.cp!(:code.priv_dir(:cmark) ++ '/cmark.so', "priv/cmark.so")
end

defmodule Cmark.Nif do
  @moduledoc false
  @on_load :init

  def init do
    path = :code.priv_dir(:cmark_native_darwin_x86_64) ++ '/cmark'
    :ok = :erlang.load_nif(path, 0)
  end

  def render(_data, _options, _format) do
    :erlang.nif_error(:undefined)
  end
end
