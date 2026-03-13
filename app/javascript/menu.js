console.log("menu js loaded")

document.addEventListener("turbo:load", () => {

  const burger = document.getElementById("burger-button")
  const menu = document.getElementById("menu-overlay")
  const close = document.getElementById("menu-close")

  if (!burger || !menu) return

  burger.addEventListener("click", () => {
    menu.classList.add("open")
  })

  if (close) {
    close.addEventListener("click", () => {
      menu.classList.remove("open")
    })
  }

})