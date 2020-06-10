import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "name", "key", "fqdn", "user_name", "connection" ]

  connect() {
    this.connectionTarget.textContent = "ssh "+ this.user_nameTarget.value + "@"  + this.fqdnTarget.value + " -i " + this.keyTarget.value + ' "RAILS_ENV=' + this.nameTarget.value + " ..."
  }

  evalstring() {
    this.connectionTarget.textContent = "ssh "+ this.user_nameTarget.value + "@"  + this.fqdnTarget.value + " -i " + this.keyTarget.value + ' "RAILS_ENV=' + this.nameTarget.value + " ..."
  }
}

