import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="job-status"
export default class extends Controller {
  static values = {
    jobId: String
  }

  static targets = ["bar"]


  connect() {
    this.checkStatus();

  }

  checkStatus() {
    fetch(`status/${this.jobIdValue}`)
    .then(response => response.json())
    .then(data => {
      if (data.status === "complete"){
        this.barTarget.style.width = `${data.progress}%`
        window.location.href = "/recipes"
      }
        else {
          this.barTarget.style.width = `${data.progress}%`
          this.barTarget.innerText = `${data.progress}%`
          setTimeout(() => this.checkStatus() , 3000);
        }
    })
  }
}
