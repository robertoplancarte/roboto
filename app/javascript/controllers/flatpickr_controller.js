import { Controller } from "stimulus"
import flatpickr from 'flatpickr';
import "flatpickr/dist/themes/dark.css";

export default class extends Controller {
  static targets = [ "self" ]

  connect() {
    flatpickr(this.selfTarget, {
      enableTime: true,
      altInput: true,
      altFormat: 'F J (D), Y - h:i:S K',
      dateFormat: 'Z' // Y-m-d H:i
    })
  }
}
