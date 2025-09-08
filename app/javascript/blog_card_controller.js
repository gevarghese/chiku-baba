// app/javascript/controllers/blog_card_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Initialize any properties or setup needed
  }
  
  animateIn(event) {
    // Add hover animations
    this.element.classList.add('scale-102');
    this.element.style.transition = 'all 0.3s ease';
    this.element.style.transform = 'translateY(-5px)';
    this.element.style.boxShadow = '0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)';
  }
  
  animateOut(event) {
    // Remove hover animations
    this.element.classList.remove('scale-102');
    this.element.style.transform = 'translateY(0)';
    this.element.style.boxShadow = '';
  }
}