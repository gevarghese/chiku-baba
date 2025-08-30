// app/javascript/controllers/theme_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["lightIcon", "darkIcon"]

  connect() {
    this.updateIcons()
  }

  toggle() {
    const html = document.documentElement
    
    if (html.classList.contains('dark')) {
      html.classList.remove('dark')
      localStorage.theme = 'light'
    } else {
      html.classList.add('dark')
      localStorage.theme = 'dark'
    }
    
    this.updateIcons()
    this.dispatch("changed", { detail: { theme: localStorage.theme } })
  }

  updateIcons() {
    const isDark = document.documentElement.classList.contains('dark')
    
    this.lightIconTargets.forEach(icon => {
      icon.classList.toggle('hidden', isDark)
      icon.classList.toggle('block', !isDark)
    })
    
    this.darkIconTargets.forEach(icon => {
      icon.classList.toggle('hidden', !isDark)
      icon.classList.toggle('block', isDark)
    })
  }
}




  