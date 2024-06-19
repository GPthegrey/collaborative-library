import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  static targets = [ "toast" ]

  connect() {
    this.toastTargets.forEach(toastElement => {
      const toast = new bootstrap.Toast(toastElement)
      toast.show()
    })
  }
}
