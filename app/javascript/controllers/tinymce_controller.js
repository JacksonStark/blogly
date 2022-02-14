import { Controller } from "@hotwired/stimulus"
import { initTinyMce } from "../packs/tinymce"

export default class extends Controller {
  connect() {
    initTinyMce()
  }
  
  disconnect() {
    tinymce.activeEditor.destroy()
  }
}
