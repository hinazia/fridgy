import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="job-status"
export default class extends Controller {
  static values = {
    jobId: String
  }
  connect() {
    this.checkStatus();
  }

  checkStatus() {
    fetch(`status/${this.jobIdValue}`)
    .then(response => response.json())
    .then(data => {
      if (data.status === "complete"){
        window.location.href = "/recipes"
      }
        else {

          setTimeout(() => this.checkStatus() , 3000);
        }
    })
  }
}
