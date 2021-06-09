defmodule ExProsemirror.FormTest do
  use ExUnit.Case

  import Phoenix.HTML
  import ExProsemirror.HTML.Form

  alias Phoenix.HTML.Form

  describe "prosemirror_hidden_input/2" do
    test "without value" do
      input_html =
        %Form{data: %{}}
        |> prosemirror_hidden_input(:title, type: :empty)
        |> safe_to_string()

      assert input_html =~
               ~s(<input id="title_plain" name="title_plain" phx-update="ignore" type="hidden">)
    end

    test "with value" do
      input_html =
        %Form{data: %{title_plain: "hello"}}
        |> prosemirror_hidden_input(:title, type: :empty)
        |> safe_to_string()

      assert input_html =~
               ~s(<input id="title_plain" name="title_plain" phx-update="ignore" type="hidden" value="hello">)
    end
  end

  describe "prosemirror_editor/2" do
    test "no marks - no blocks" do
      input_html =
        %Form{data: %{title_plain: "hello"}}
        |> prosemirror_editor(:title, type: :empty)
        |> safe_to_string()

      assert input_html =~
               ~s(<div class="ex-prosemirror" data-blocks="[]" data-inline="false" data-marks="[]" data-target="#title" id="title")
    end

    test "marks only" do
      input_html =
        %Form{data: %{title_plain: "hello"}}
        |> prosemirror_editor(:title, type: :marks_only)
        |> safe_to_string()

      assert input_html =~
               ~s(<div class="ex-prosemirror" data-blocks="[]" data-inline="false" data-marks="[&quot;em&quot;]" data-target="#title" id="title")
    end

    test "blocks only" do
      input_html =
        %Form{data: %{title_plain: "hello"}}
        |> prosemirror_editor(:title, type: :blocks_only)
        |> safe_to_string()

      assert input_html =~
               ~s(<div class="ex-prosemirror" data-blocks="[&quot;p&quot;]" data-inline="false" data-marks="[]" data-target="#title" id="title")
    end
  end

  @tag capture_log: true
  describe "defaults" do
    test "unknow type" do
      input_html =
        %Form{data: %{title_plain: "hello"}}
        |> prosemirror_editor(:title, type: :unkown)
        |> safe_to_string()

      assert input_html =~
               ~s(<div class="ex-prosemirror" data-blocks="[]" data-inline="false" data-marks="[]" data-target="#title" id="title")
    end

    test "unknown type should log a warn" do
      import ExUnit.CaptureLog

      log =
        capture_log(fn ->
          %Form{data: %{title_plain: "hello"}}
          |> prosemirror_editor(:title, type: :unknown)
          |> safe_to_string()
        end)

      assert log =~ ~S(ExProsemirror - Type "unknown" not found)
      assert log =~ ~S(using default)
    end
  end
end
