import menuPlugin from './prosemirror/menu';
import { keymap } from 'prosemirror-keymap';
import { baseKeymap } from 'prosemirror-commands';
import { EditorState } from 'prosemirror-state';
import { EditorView } from 'prosemirror-view';
import { DOMParser } from 'prosemirror-model';
import schemaFunc from './prosemirror/schema';
import { placeholderPlugin, insertPlaceholder } from './prosemirror/plugins/placeholder';


export default class ExEditorView {
  constructor(editorNode) {
    this.editorNode = editorNode;
    this.target = editorNode.dataset.target + '_plain';
    this.initializeSchema();

    this.editorView = new EditorView(editorNode, {
      state: this.state,
      dispatchTransaction: (transaction) => {this.dispatchTransaction(transaction);},
    });
  }

  initializeSchema() {
    const schema = schemaFunc(this.editorNode.dataset);

    this.state = EditorState.create({
      doc: this.getDoc(schema),
      plugins: [menuPlugin({ schema }), keymap(baseKeymap), placeholderPlugin]
    });
  }

  getDoc(schema) {
    const initialValue = document.querySelector(this.target).value;

    if(initialValue.length > 0) {
      try {
        return schema.nodeFromJSON(JSON.parse(initialValue));
      } catch {
        return DOMParser.fromSchema(schema).parse('');
      }
    } else {
      return DOMParser.fromSchema(schema).parse('');
    }
  }

  dispatchTransaction(transaction) {
    const newState = this.editorView.state.apply(transaction);
    const parsedState = newState.doc.toJSON();

    // TODO liveview supports

    document.querySelector(this.target).value = JSON.stringify(parsedState);
    this.editorView.updateState(newState);
  }
}
