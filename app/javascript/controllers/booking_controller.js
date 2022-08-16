import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["startDate", "endDate", "guest", "dateError"]

  connect() {
    console.log("Hello from our first Stimulus controller")
  }

  saveDate() {
    const urlSearchParams = new URLSearchParams(window.location.search);
    const params = Object.fromEntries(urlSearchParams.entries());

    const newStartDate = this.startDateTarget.value
    const newEndDate = this.endDateTarget.value

    alert('123')
    if (Date.parse(newStartDate) >= Date.parse(newEndDate)) {
      this.dateErrorTarget.innerHTML = 'End date should be greater than start date'
    } else {
      const url = window.location.pathname + '?' + 'start_date=' +
        this.startDateTarget.value + '&end_date=' + this.endDateTarget.value + '&guest_count=' + params.guest_count + '&listing_id=' + params.listing_id;
      window.location = url
    }

  }

  saveGuest() {
    alert('789')
    const urlSearchParams = new URLSearchParams(window.location.search);
    const params = Object.fromEntries(urlSearchParams.entries());

    const url = window.location.pathname + '?' + 'start_date=' +
      params.start_date + '&end_date=' + params.end_date + '&guest_count=' + this.guestTarget.value + '&listing_id=' + params.listing_id;
    window.location = url
  }

  cancelBooking(event) {
    alert('456')
    event.preventDefault();
    event.stopImmediatePropagation()
    fetch(event.target.href, {
      method: "POST",
      headers: {"Content-Type": "application/json"},
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        location.reload()
      })
  }

  startDateChange() {
    let minEndDate = new Date(this.startDateTarget.value)
    minEndDate.setDate(minEndDate.getDate() + 1)
    this.endDateTarget.min = minEndDate.toISOString().split('T')[0]

    const endDate = new Date(this.endDateTarget.value)
    if (endDate < minEndDate) {
      this.endDateTarget.value = minEndDate.toISOString().split('T')[0]
    }
  }
}
