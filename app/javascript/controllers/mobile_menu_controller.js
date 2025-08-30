// app/javascript/controllers/mobile_menu_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "openIcon", "closedIcon"]

  connect() {
    this.isOpen = false
  }

  toggle() {
    this.isOpen = !this.isOpen
    
    if (this.isOpen) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    this.menuTarget.classList.remove('hidden')
    this.menuTarget.classList.add('animate-fadeIn')
    
    this.openIconTargets.forEach(icon => {
      icon.classList.remove('hidden')
      icon.classList.add('block')
    })
    
    this.closedIconTargets.forEach(icon => {
      icon.classList.remove('block')
      icon.classList.add('hidden')
    })
    
    // Prevent body scroll when menu is open
    document.body.style.overflow = 'hidden'
    
    this.dispatch("opened")
  }

  close() {
    this.menuTarget.classList.add('hidden')
    this.menuTarget.classList.remove('animate-fadeIn')
    
    this.openIconTargets.forEach(icon => {
      icon.classList.remove('block')
      icon.classList.add('hidden')
    })
    
    this.closedIconTargets.forEach(icon => {
      icon.classList.remove('hidden')
      icon.classList.add('block')
    })
    
    // Restore body scroll
    document.body.style.overflow = ''
    
    this.dispatch("closed")
  }

  // Close menu when clicking outside (optional)
  clickOutside(event) {
    if (this.isOpen && !this.element.contains(event.target)) {
      this.close()
    }
  }

  // Close menu on escape key
  keydown(event) {
    if (this.isOpen && event.key === 'Escape') {
      this.close()
    }
  }

  disconnect() {
    // Clean up body overflow when controller is disconnected
    document.body.style.overflow = ''
  }
}