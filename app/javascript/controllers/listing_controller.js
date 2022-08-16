import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["startDate", "endDate", "nightCount", "subTotal", "totalAmount", "guestCount"]

  connect() {
    console.log("Hello")
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

  endDateChange() {
    this.recalculatePrices()
  }

  recalculatePrices() {
    const startDate = new Date(this.startDateTarget.value)
    const endDate = new Date(this.endDateTarget.value)

    const nightCount = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24));
    const subtotal = pricePerNight * nightCount
    const total = subtotal + cleaningFee + serviceFee

    this.nightCountTarget.innerHTML = nightCount
    this.subTotalTarget.innerHTML = subtotal
    this.totalAmountTarget.innerHTML = total
  }

  reserveBooking(event) {
    console.log(event.target.getAttribute('href'))
    event.preventDefault();
    event.stopImmediatePropagation()
    const newPath = event.target.getAttribute('href')
    // console.log(newPath)
    const url = newPath + '?' + 'start_date=' +
      this.startDateTarget.value + '&end_date=' + this.endDateTarget.value + '&guest_count=' + this.guestCountTarget.value + '&listing_id=' + listingId;
    window.location = url
  }

}
