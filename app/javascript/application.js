// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"


// Optional: Add global event listeners for enhanced UX
document.addEventListener("DOMContentLoaded", function() {
  // Add loading states to forms
  document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function() {
      const submitButton = form.querySelector('button[type="submit"], input[type="submit"]')
      if (submitButton) {
        submitButton.classList.add('opacity-50', 'cursor-not-allowed')
        submitButton.disabled = true
        
        // Re-enable after a delay as fallback
        setTimeout(() => {
          submitButton.classList.remove('opacity-50', 'cursor-not-allowed')
          submitButton.disabled = false
        }, 5000)
      }
    })
  })

  // Close mobile menu on window resize
  let mobileMenuController = null
  
  window.addEventListener('resize', function() {
    if (window.innerWidth >= 768) { // md breakpoint
      const mobileMenuElement = document.querySelector('[data-controller*="mobile-menu"]')
      if (mobileMenuElement && mobileMenuController) {
        const controller = window.Stimulus.getControllerForElementAndIdentifier(mobileMenuElement, 'mobile-menu')
        if (controller && controller.isOpen) {
          controller.close()
        }
      }
    }
  })

  // Add smooth scrolling for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const href = this.getAttribute('href')
      if (href !== '#') {
        e.preventDefault()
        const target = document.querySelector(href)
        if (target) {
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          })
        }
      }
    })
  })
})

// Global error handling for better UX
window.addEventListener('error', function(e) {
  console.error('Application error:', e.error)
  // You could show a user-friendly error message here
})

// Turbo event listeners for enhanced UX
document.addEventListener('turbo:visit', function() {
  // Show loading indicator (optional)
  document.body.classList.add('loading')
})

document.addEventListener('turbo:load', function() {
  // Hide loading indicator
  document.body.classList.remove('loading')
  
  // Reinitialize any components that need it after Turbo navigation
  // This is useful for third-party libraries that need reinitialization
})

document.addEventListener('turbo:frame-load', function() {
  // Handle Turbo Frame specific loading
  console.log('Turbo frame loaded')
})

// Optional: Add keyboard shortcuts
document.addEventListener('keydown', function(e) {
  // Toggle theme with Cmd/Ctrl + Shift + D
  if ((e.metaKey || e.ctrlKey) && e.shiftKey && e.key === 'D') {
    e.preventDefault()
    const themeController = document.querySelector('[data-controller*="theme"]')
    if (themeController) {
      const controller = window.Stimulus.getControllerForElementAndIdentifier(themeController, 'theme')
      if (controller) {
        controller.toggle()
      }
    }
  }
  
  // Close mobile menu with Escape key
  if (e.key === 'Escape') {
    const mobileMenuElement = document.querySelector('[data-controller*="mobile-menu"]')
    if (mobileMenuElement) {
      const controller = window.Stimulus.getControllerForElementAndIdentifier(mobileMenuElement, 'mobile-menu')
      if (controller && controller.isOpen) {
        controller.close()
      }
    }
  }
})