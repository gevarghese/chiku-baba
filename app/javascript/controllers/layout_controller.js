import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="layout"
export default class extends Controller {
  static targets = ["main", "footer"]

  connect() {
    this.adjust()
    window.addEventListener("resize", this.adjust)
  }

  disconnect() {
    window.removeEventListener("resize", this.adjust)
  }

  adjust = () => {
    const header = document.getElementById("app-header")
    const footer = this.footerTarget

    if (header) {
      document.documentElement.style.setProperty(
        "--header-height",
        `${header.offsetHeight}px`
      )
    }

    if (footer) {
      document.documentElement.style.setProperty(
        "--footer-height",
        `${footer.offsetHeight}px`
      )
    }
  }
}
