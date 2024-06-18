// app/javascript/controllers/book_search_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["results"];

  connect() {
    console.log("BookSearchController connected");
  }

  async search(event) {
    event.preventDefault();

    const query = this.element.querySelector("input[name='query']").value;
    const response = await fetch(`/books?query=${query}`, { headers: { Accept: "application/json" } });
    const data = await response.json();
    this.resultsTarget.innerHTML = this.renderResults(data);
  }

  renderResults(data) {
    return data.map(book => `
      <div class="book">
        <h2>${book.volumeInfo.title}</h2>
        <p>${book.volumeInfo.description}</p>
      </div>
    `).join("");
  }
}
