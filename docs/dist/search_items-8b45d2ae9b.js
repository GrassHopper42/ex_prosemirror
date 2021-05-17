searchNodes=[{"doc":"ExProsemirror is a helper for the ProseMirror rich-text editor inside of Phoenix.HTML.Form . The current version is in alpha and we don't guarantee it works as expected. Examples &lt; % = form_for @changeset , &quot;#&quot; , fn f -&gt; % &gt; &lt; % = prosemirror_input f , :title , marks : [ :em ] % &gt; &lt; % = prosemirror_input f , :body , marks : [ :strong , :em ] , blocks : [ :p , :h1 ] % &gt; &lt; % end % &gt; Marks and blocks should be defined by your own code using ProseMirror. The following code sample will create a form with 2 fields: title and body . The title will expose italic marks only. The body will expose italic and strong marks plus paragraph and header 1. &lt; form for = &quot;article&quot; &gt; &lt; input type = &quot;hidden&quot; name = &quot;article[title]&quot; &gt; &lt; div id = &quot;ProseMirrorTitleDiv&quot; &gt; &lt; / div &gt; &lt; input type = &quot;hidden&quot; name = &quot;article[body]&quot; &gt; &lt; div id = &quot;ProseMirrorBodyDiv&quot; &gt; &lt; / div &gt; &lt; / form &gt; Installation First, you need to add the dependency according to the following code: def deps do [ { :ex_prosemirror , &quot;~&gt; 0.1.0&quot; } ] end Then, you have to import ExProsemirror.HTML.Form in your views / liveviews This could be done directly in your AppWeb.ex in view/0 and/or live_view/0 . In recent phoenix versions, you could simply add the line in view_helper/0 . defp view_helpers do quote do use Phoenix.HTML import Phoenix.View import ExProsemirror.HTML.Form # &lt;--- this line import AppWeb.ErrorHelpers alias AppWeb.Router.Helpers , as : Routes end end Add the ex_prosemirror dependency to your package.json: { ... &quot;dependencies&quot;: { ... &quot;ex_prosemirror&quot;: &quot;file:../deps/ex_prosemirror&quot; } ... } Finally, add your js part to configure prosemirror and initialized ExProsemirror. # ProseMirror dependencies import { exampleSetup } from &#39;prosemirror-example-setup&#39; import { EditorState } from &#39;prosemirror-state&#39; import { EditorView } from &#39;prosemirror-view&#39; import { DOMParser , Node } from &quot;prosemirror-model&quot; import { Schema } from &#39;prosemirror-model&#39; ; # This is the helper from ex_prosemirror import ExProsemirror from &#39;ex_prosemirror&#39; # You&#39;ll need to create a function that returns a ProseMirror Schema when executed const schemaFunc = ( options ) =&gt; { return new Schema ( { nodes : { text , paragraph : export default { group : &#39;block&#39; , content : &#39;inline*&#39; , toDOM ( ) { return [ &#39;p&#39; , 0 ] ; } , parseDOM : [ { tag : &#39;p&#39; } ] , } , doc : { content : &#39;block+&#39; , } , } } ) ; } # Bind your configuration to ExProsemirror const exProsemirror = new ExProsemirror ( { EditorState , DOMParser , EditorView , Node } ) # Initialize the schemas exProsemirror . init ( { schemaFunc , pluginFunc : exampleSetup } ) You can now use ProseMirror in the way that you need, ExProsemirror will ensure that your DOM is binded to your data.","ref":"ExProsemirror.html","title":"ExProsemirror","type":"module"},{"doc":"Form helpers to generate HTML fields required by ProseMirror. Using this component, ProseMirror will automatically be link to hidden input fields. These hidden inputs will be used by Phoenix.HTML.Form to send data to the backend. Live synchronization over LiveView is not currently supported. Options marks: mark tags to use defined in your ProseMirror config blocks: block tags to use defined in your ProseMirror config","ref":"ExProsemirror.HTML.Form.html","title":"ExProsemirror.HTML.Form","type":"module"},{"doc":"Generates the &lt;div&gt; that will be used by javascript to mount the ProseMirror component. Usage &lt; % = prosemirror_editor ( @form , :title ) % &gt; See ExProsemirror.HTML.Form for options","ref":"ExProsemirror.HTML.Form.html#prosemirror_editor/3","title":"ExProsemirror.HTML.Form.prosemirror_editor/3","type":"function"},{"doc":"Generates a hidden input field to store data for ProseMirror. Uses Phoenix.HTML.Form.html.hidden_input/3 under the hood. Usage &lt; % = prosemirror_hidden_input ( @form , :title ) % &gt;","ref":"ExProsemirror.HTML.Form.html#prosemirror_hidden_input/3","title":"ExProsemirror.HTML.Form.prosemirror_hidden_input/3","type":"function"},{"doc":"Generates inputs for ProseMirror. Usages &lt; % = prosemirror_input @form , :body , id : &quot;my-article-input&quot; % &gt; iex&gt; prosemirror_input(form, :body)","ref":"ExProsemirror.HTML.Form.html#prosemirror_input/3","title":"ExProsemirror.HTML.Form.prosemirror_input/3","type":"function"}]