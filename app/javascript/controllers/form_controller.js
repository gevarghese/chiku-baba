// app/javascript/controllers/form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('submit', this.handleSubmit.bind(this))
  }

  handleSubmit() {
    const submitButton = this.element.querySelector('button[type="submit"], input[type="submit"]')
    if (submitButton) {
      submitButton.classList.add('opacity-50', 'cursor-not-allowed')
      submitButton.disabled = true
      
      // Re-enable after a delay as fallback
      setTimeout(() => {
        submitButton.classList.remove('opacity-50', 'cursor-not-allowed')
        submitButton.disabled = false
      }, 5000)
    }
  }

  disconnect() {
    this.element.removeEventListener('submit', this.handleSubmit)
  }
}