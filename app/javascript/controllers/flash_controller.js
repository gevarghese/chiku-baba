// app/javascript/controllers/flash_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["alert"]

  connect() {
    // Auto-dismiss flash messages after 5 seconds
    this.alertTargets.forEach(alert => {
      setTimeout(() => {
        this.dismissAlert(alert)
      }, 5000)
    })
  }

  dismiss(event) {
    const alert = event.currentTarget
    this.dismissAlert(alert)
  }

  dismissAlert(alert) {
    // Add fade out animation
    alert.classList.add('opacity-0', 'transform', 'translate-x-full')
    
    // Remove element after animation completes
    setTimeout(() => {
      if (alert.parentNode) {
        alert.remove()
      }
    }, 300)
  }

  // Programmatically add new flash messages
  addFlash(type, message) {
    const flashContainer = this.element
    const alertClasses = this.getAlertClasses(type)
    const iconSvg = this.getIconSvg(type)
    
    const alertElement = document.createElement('div')
    alertElement.setAttribute('data-flash-target', 'alert')
    alertElement.setAttribute('data-action', 'click->flash#dismiss')
    alertElement.className = `${alertClasses} px-4 py-3 rounded-lg shadow-lg max-w-sm cursor-pointer transform transition-all duration-300 hover:scale-105`
    
    alertElement.innerHTML = `
      <div class="flex items-center space-x-2">
        <div class="flex-shrink-0">
          ${iconSvg}
        </div>
        <div class="flex-1">
          <p class="text-sm font-medium">${message}</p>
        </div>
        <button class="flex-shrink-0 ml-2 opacity-50 hover:opacity-100 transition-opacity duration-200">
          <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
          </svg>
        </button>
      </div>
    `
    
    flashContainer.appendChild(alertElement)
    
    // Auto-dismiss after 5 seconds
    setTimeout(() => {
      this.dismissAlert(alertElement)
    }, 5000)
  }

  getAlertClasses(type) {
    switch(type) {
      case 'notice':
        return 'bg-green-100 border border-green-400 text-green-700 dark:bg-green-900/20 dark:border-green-600 dark:text-green-400'
      case 'alert':
      case 'error':
        return 'bg-red-100 border border-red-400 text-red-700 dark:bg-red-900/20 dark:border-red-600 dark:text-red-400'
      case 'warning':
        return 'bg-yellow-100 border border-yellow-400 text-yellow-700 dark:bg-yellow-900/20 dark:border-yellow-600 dark:text-yellow-400'
      default:
        return 'bg-blue-100 border border-blue-400 text-blue-700 dark:bg-blue-900/20 dark:border-blue-600 dark:text-blue-400'
    }
  }

  getIconSvg(type) {
    switch(type) {
      case 'notice':
        return '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>'
      case 'alert':
      case 'error':
        return '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path></svg>'
      case 'warning':
        return '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path></svg>'
      default:
        return '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path></svg>'
    }
  }
}
