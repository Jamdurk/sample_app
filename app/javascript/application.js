import "@hotwired/turbo-rails";
import "controllers";
import "jquery";
import "bootstrap";
import "@popperjs/core";

// Ensure Bootstrap dropdowns work
document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".dropdown-toggle").forEach((dropdown) => {
    new bootstrap.Dropdown(dropdown);
  });
});
