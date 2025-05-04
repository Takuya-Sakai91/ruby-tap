import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game-starter"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    this.handleKeyDown = this.handleKeyDown.bind(this)
    document.addEventListener("keydown", this.handleKeyDown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeyDown)
  }

  handleKeyDown(event) {
    if (event.code === "Space" || event.code === "Enter") {
      event.preventDefault()
      this.formTarget.requestSubmit()
    }
  }
}
