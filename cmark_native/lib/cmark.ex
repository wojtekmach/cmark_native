unless Code.ensure_loaded?(Cmark.Nif) do
  require Logger

  Logger.error(
    "cmark_native is not available for your platform, no cmark_native_#{Mix.target()} package"
  )

  raise "platform not supported"
end

defmodule Cmark do
  import Bitwise, only: [<<<: 2]

  @formats %{
    html: 1,
    xml: 2,
    man: 3,
    commonmark: 4,
    latex: 5
  }

  # cmark.h -> CMARK_OPT_*
  @flags %{
    sourcepos: 1 <<< 1,
    hardbreaks: 1 <<< 2,
    nobreaks: 1 <<< 4,
    normalize: 1 <<< 8,
    validate_utf8: 1 <<< 9,
    smart: 1 <<< 10,
    unsafe: 1 <<< 17
  }

  @doc ~S"""
  Converts a Markdown document to HTML.

  ## Examples

      iex> Cmark.to_html("*Hello*")
      "<p><em>Hello</em></p>\n"

  """
  def to_html(document, options \\ []) when is_binary(document) and is_list(options) do
    convert(document, options, Map.fetch!(@formats, :html))
  end

  defp convert(document, options, format_id) when is_integer(format_id) do
    flag = Enum.reduce(options, 0, &(Map.fetch!(@flags, &1) + &2))
    Cmark.Nif.render(document, flag, format_id)
  end
end
