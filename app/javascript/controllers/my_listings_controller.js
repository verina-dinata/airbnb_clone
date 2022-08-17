import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("abcde")
  }

  updateBooking(event) {
    event.preventDefault();
    event.stopImmediatePropagation()

    fetch(event.target.getAttribute('href'), {
      method: "POST",
      headers: {"Content-Type": "application/json"},
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        location.reload()
      })
  }
}
