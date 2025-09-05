// app/javascript/controllers/comment_form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    reset() {
        this.element.reset();
    }

    reply(event) {
        event.preventDefault();
        const commentId = event.params.id;
        const parentIdField = this.element.querySelector('input[name="comment[parent_id]"]');
        parentIdField.value = commentId;

        // Scroll to comment form
        const commentForm = this.element;
        commentForm.scrollIntoView({ behavior: 'smooth' });

        // Focus on textarea
        const textarea = commentForm.querySelector('textarea');
        textarea.focus();

        // Update UI to show replying state
        const replyingTo = document.createElement('div');
        replyingTo.classList.add('text-sm', 'text-blue-600', 'mb-2');
        replyingTo.textContent = `Replying to comment #${commentId}`;

        // Remove any existing reply notification
        const existingReplyNote = commentForm.querySelector('.replying-to');
        if (existingReplyNote) {
            existingReplyNote.remove();
        }

        replyingTo.classList.add('replying-to');
        commentForm.insertBefore(replyingTo, textarea.parentNode);

        // Add cancel button
        const cancelButton = document.createElement('button');
        cancelButton.textContent = 'Cancel Reply';
        cancelButton.classList.add('text-sm', 'text-red-600', 'ml-2');
        cancelButton.addEventListener('click', (e) => {
            e.preventDefault();
            parentIdField.value = '';
            replyingTo.remove();
            cancelButton.remove();
        });

        replyingTo.appendChild(cancelButton);
    }
}