import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    // toggle visibility
    this.menuTarget.classList.toggle("hidden")

    if (!this.menuTarget.classList.contains("hidden")) {
      this.adjustDirection()
    }
  }

  adjustDirection() {
    const rect = this.element.getBoundingClientRect()
    const viewportHeight = window.innerHeight

    // if not enough space below, open upward
    if (rect.bottom + this.menuTarget.offsetHeight > viewportHeight) {
      this.menuTarget.classList.add("bottom-full", "mb-2")
      this.menuTarget.classList.remove("top-full", "mt-2")
    } 
    // else open downward
    else {
      this.menuTarget.classList.add("top-full", "mt-2")
      this.menuTarget.classList.remove("bottom-full", "mb-2")
    }
  }
}
