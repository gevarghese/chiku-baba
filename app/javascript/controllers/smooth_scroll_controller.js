// app/javascript/controllers/smooth_scroll_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('click', this.handleClick.bind(this))
  }

  handleClick(e) {
    const href = this.element.getAttribute('href')
    if (href && href.startsWith('#')) {
      e.preventDefault()
      const target = document.querySelector(href)
      if (target) {
        target.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        })
      }
    }
  }

  disconnect() {
    this.element.removeEventListener('click', this.handleClick)
  }
}