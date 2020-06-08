import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "self" ]

  connect() {
    const sleep = (milliseconds) => {
      return new Promise(resolve => setTimeout(resolve, milliseconds))
    }
    sleep(5000).then(() => { 
      this.selfTarget.classList.remove("bg-red-400", "bg-green-400", "text-gray-100")
      this.selfTarget.classList.add("transition", "duration-500", "bg-transparent", "text-transparent"); 
    })
  }
}

