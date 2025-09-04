import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "openIcon", "closedIcon"]

  connect() {
    this.isOpen = false
    this.boundClickOutside = this.clickOutside.bind(this)
    this.boundKeydown = this.keydown.bind(this)
  }

  toggle() {
    this.isOpen ? this.close() : this.open()
  }

  open() {
    this.menuTarget.classList.remove("hidden", "translate-x-full", "opacity-0")
    this.menuTarget.classList.add("translate-x-0", "opacity-100")

    this.openIconTarget.classList.remove("hidden")
    this.closedIconTarget.classList.add("hidden")

    document.body.style.overflow = "hidden"
    this.isOpen = true

    document.addEventListener("click", this.boundClickOutside)
    document.addEventListener("keydown", this.boundKeydown)
  }

  close() {
    this.menuTarget.classList.add("translate-x-full", "opacity-0")
    this.menuTarget.classList.remove("translate-x-0", "opacity-100")

    setTimeout(() => {
      if (!this.isOpen) this.menuTarget.classList.add("hidden")
    }, 300) // match transition duration

    this.openIconTarget.classList.add("hidden")
    this.closedIconTarget.classList.remove("hidden")

    document.body.style.overflow = ""
    this.isOpen = false

    document.removeEventListener("click", this.boundClickOutside)
    document.removeEventListener("keydown", this.boundKeydown)
  }

  clickOutside(event) {
    if (this.isOpen && !this.element.contains(event.target)) {
      this.close()
    }
  }

  keydown(event) {
    if (this.isOpen && event.key === "Escape") {
      this.close()
    }
  }

  disconnect() {
    document.body.style.overflow = ""
    document.removeEventListener("click", this.boundClickOutside)
    document.removeEventListener("keydown", this.boundKeydown)
  }
}
