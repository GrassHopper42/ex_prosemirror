defmodule ExProsemirror do
  @moduledoc ~S"""
  ExProsemirror is a helper to use [ProseMirror](https://prosemirror.net/) inside
  [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html).

  Current version is alpha and we don't garantee this lib to works as you expected.


  ## Examples

      <%= form_for @changeset, "#", fn f -> %>
        <%= prosemirror_input f, :title, marks: [:em] %>
        <%= prosemirror_input f, :body, marks: [:strong, :em], blocks: [:p, :h1] %>
      <% end %>

  > Marks and blocks should be defined by your own code using prosemirror.

  This code sample will create a form with 2 fields: `title` and `body`. The
  title will expose italic marks only. The body will expose italic and strong
  marks plus paragraph and header 1.


      <form for="article">
        <input type="hidden" name="article[title]">
        <div id="ProseMirrorTitleDiv"></div>

        <input type="hidden" name="article[body]">
        <div id="ProseMirrorBodyDiv"></div>
      </form>


  ## Installation

  - First, you need to add the dependency according to the following code:

  ```elixir
  def deps do
  [
    {:ex_prosemirror, "~> 0.1.0"}
  ]
  end
  ```

  - Then, you have to import `ExProsemirror.HTML.Form` in your views / liveviews
  > This could be done directly in your AppWeb.ex in `view/0` and/or `live_view/0`.
  > In recent phoenix version, you could simply add the line in `view_helper/0`.

  ``` elixir
  defp view_helpers do
    quote do
      use Phoenix.HTML

      import Phoenix.View

      import ExProsemirror.HTML.Form # <--- this line

      import AppWeb.ErrorHelpers
      alias AppWeb.Router.Helpers, as: Routes
    end
  end
  ```

  - Update your package.json to `ex_prosemirror` dependency:

  ```json
  {
    ...
    "dependencies": {
      ...
      "ex_prosemirror": "file:../deps/ex_prosemirror"
    }
    ...
  }
  ```

  - Finally, add your js part to configure prosemirror and initialized
  ExProsemirror.

  ```elixir
  # Prosemirror dependencies
  import { exampleSetup } from 'prosemirror-example-setup'
  import { EditorState } from 'prosemirror-state'
  import { EditorView } from 'prosemirror-view'
  import { DOMParser, Node } from "prosemirror-model"
  import { Schema } from 'prosemirror-model';

  # This is the helper from ex_prosemirror
  import ExProsemirror from 'ex_prosemirror'

  # You'll need to create a function that return a prosemirror Schema when executed
  const schemaFunc = (options) => {
    return new Schema({
      nodes: {
        text,
        paragraph: export default {
          group: 'block',
          content: 'inline*',
          toDOM() { return ['p', 0]; },
          parseDOM: [{ tag: 'p' }],
        },
        doc: {
          content: 'block+',
        },
      }
    });
  }

  # Bind your configuration to ExProsemirror
  const exProsemirror = new ExProsemirror({EditorState, DOMParser, EditorView, Node})

  # Initalizaed schemas
  exProsemirror.init({schemaFunc, pluginFunc: exampleSetup})
  ```

  You can use prosemirror in the way that you need, ExProsemirror will ensure your dom to be bind
  to your data.
  """
end
