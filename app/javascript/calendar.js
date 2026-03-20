document.addEventListener("click", function(event) {
  const link = event.target.closest(".js-calendar-link");
  if (!link) return;

  event.preventDefault();

  const url = link.href;

  fetch(url, {
    headers: { "X-Requested-With": "XMLHttpRequest" }
  })
  .then(response => response.text())
  .then(html => {
    const container = document.getElementById("calendar-container");
    if (container) container.innerHTML = html;
  })
  .catch(error => console.error("Ошибка загрузки календаря:", error));
});