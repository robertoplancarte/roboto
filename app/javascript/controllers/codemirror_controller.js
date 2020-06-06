import { Controller } from "stimulus"
import CodeMirror from 'codemirror';
import 'codemirror/mode/ruby/ruby.js';

export default class extends Controller {
  static targets = [ "code" ]

  connect() {
    var myCodeMirror = CodeMirror.fromTextArea(this.codeTarget, {lineNumbers: true, mode: "ruby", viewportMargin: Infinity, theme: "nord"});
  }
}
