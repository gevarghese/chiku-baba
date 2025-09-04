import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "icon"]

  connect() {
    this.isOpen = false
    this.boundClickOutside = this.clickOutside.bind(this)
    this.boundKeydown = this.keydown.bind(this)
  }

  toggle() {
    this.isOpen ? this.close() : this.open()
  }

  open() {
    this.menuTarget.classList.remove("hidden", "opacity-0", "scale-95")
    this.menuTarget.classList.add("opacity-100", "scale-100")

    this.menuTarget.classList.add(
      "transition",
      "ease-out",
      "duration-150",
      "transform",
      "origin-top"
    )

    if (this.hasIconTarget) {
      this.iconTarget.classList.add("rotate-180")
    }

    this.isOpen = true
    document.addEventListener("click", this.boundClickOutside)
    document.addEventListener("keydown", this.boundKeydown)
  }

  close() {
    this.menuTarget.classList.add("opacity-0", "scale-95")
    this.menuTarget.classList.remove("opacity-100", "scale-100")

    if (this.hasIconTarget) {
      this.iconTarget.classList.remove("rotate-180")
    }

    setTimeout(() => {
      if (!this.isOpen) {
        this.menuTarget.classList.add("hidden")
      }
    }, 150)

    this.isOpen = false
    document.removeEventListener("click", this.boundClickOutside)
    document.removeEventListener("keydown", this.boundKeydown)
  }

  clickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }

  keydown(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }

  disconnect() {
    document.removeEventListener("click", this.boundClickOutside)
    document.removeEventListener("keydown", this.boundKeydown)
  }
}
