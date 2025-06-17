// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

// postits animation

document.addEventListener("DOMContentLoaded", function () {
  const postIts = document.querySelectorAll(".postit-card");
  let currentIndex = 0;

  postIts.forEach((postIt, index) => {
    postIt.dataset.index = index;

    postIt.addEventListener("click", function () {
      const isExpanded = postIt.classList.contains("expanded");

      document.querySelectorAll(".postit-card").forEach(p => {
        p.classList.remove("expanded");
        p.style.zIndex = p.dataset.originalZ || 1;
      });

      if (!isExpanded) {
        postIt.classList.add("expanded");
        postIt.style.zIndex = 100;
      }
    });

    postIt.dataset.originalZ = postIt.style.zIndex;
  });

  function scrollPostIts(direction) {
    postIts[currentIndex].classList.remove("expanded");
    postIts[currentIndex].style.zIndex = postIts[currentIndex].dataset.originalZ;

    if (direction === "up") {
      currentIndex = (currentIndex - 1 + postIts.length) % postIts.length;
    } else {
      currentIndex = (currentIndex + 1) % postIts.length;
    }

    postIts[currentIndex].classList.add("expanded");
    postIts[currentIndex].style.zIndex = 100;
  }

  document.addEventListener("keydown", function (e) {
    if (e.key === "ArrowUp") {
      scrollPostIts("up");
    } else if (e.key === "ArrowDown") {
      scrollPostIts("down");
    }
  });
});

// carousel animation 
document.addEventListener("DOMContentLoaded", function () {
  const carousel = document.querySelector('#teamCarousel');
  if (carousel) {
    new bootstrap.Carousel(carousel, {
      interval: 3000,
      ride: 'carousel',
      pause: false,
      wrap: true
    });
  }
});

// likes animation
document.addEventListener("turbo:load", () => {
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  tooltipTriggerList.forEach((tooltipTriggerEl) => {
    new bootstrap.Tooltip(tooltipTriggerEl)
  })
})