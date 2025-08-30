// app/javascript/controllers/newsletter_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  subscribe(event) {
    event.preventDefault()
    
    const formData = new FormData(event.target)
    const email = formData.get('email')
    
    // Simulate API call
    this.element.style.opacity = '0.6'
    const submitButton = event.target.querySelector('button[type="submit"]')
    const originalText = submitButton.textContent
    submitButton.textContent = 'Subscribing...'
    submitButton.disabled = true
    
    // Simulate network delay
    setTimeout(() => {
      // Reset form
      event.target.reset()
      this.element.style.opacity = '1'
      submitButton.textContent = originalText
      submitButton.disabled = false
      
      // Show success message via flash controller
      const flashController = document.querySelector('[data-controller*="flash"]')
      if (flashController) {
        const controller = this.application.getControllerForElementAndIdentifier(flashController, 'flash')
        if (controller) {
          controller.addFlash('notice', `Thanks for subscribing with ${email}!`)
        }
      }
      
      // Dispatch custom event
      this.dispatch("subscribed", { detail: { email } })
    }, 1000)
  }
}