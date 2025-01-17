defmodule ExProsemirror.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_prosemirror,
      version: "0.5.4",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # ExDoc
      name: "ExProsemirror",
      source_url: "https://github.com/GrassHopper42/ex_prosemirror",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_html, "~> 2.14 or ~> 3.0"},
      {:ecto, "~> 3.6"},
      {:polymorphic_embed, "~> 1.6"},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.28.4", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "ExProsemirror",
      nest_modules_by_prefix: prosemirror_modifiers(),
      extras: ["README.md", "CODE_OF_CONDUCT.md", "guides/extends_editor.md", "LICENSE.md"],
      groups_for_modules: [
        HTML: [ExProsemirror.HTML.Form],
        Encoders: prosemirror_encoders(),
        Ecto: prosemirror_ecto_related(),
        Modifiers: prosemirror_modifiers()
      ]
    ]
  end

  defp prosemirror_encoders do
    [
      ExProsemirror.Encoder.HTML
    ]
  end

  defp prosemirror_modifiers do
    [
      ExProsemirror.ModifierHelper,
      ExProsemirror.Block,
      ExProsemirror.Block.Doc,
      ExProsemirror.Block.Heading,
      ExProsemirror.Block.Image,
      ExProsemirror.Block.Paragraph,
      ExProsemirror.Block.Text,
      ExProsemirror.Block.HTML,
      ExProsemirror.Mark,
      ExProsemirror.Mark.Em,
      ExProsemirror.Mark.Link,
      ExProsemirror.Mark.Strong,
      ExProsemirror.Mark.Underline,
      ExProsemirror.Mark.Strikethrough,
      ExProsemirror.Mark.Color,
      ExProsemirror.Mark.FontFamily
    ]
  end

  defp prosemirror_ecto_related do
    [
      ExProsemirror.Schema,
      ExProsemirror.Changeset
    ]
  end
end
