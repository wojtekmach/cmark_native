defmodule Cmark.NifTest do
  use ExUnit.Case, async: true

  test "greets the world" do
    assert Cmark.Nif.render("hi", 0, 1) == "<p>hi</p>\n"
  end
end
