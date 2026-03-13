document.addEventListener("turbo:load", () => {

  document.querySelectorAll(".cart-controls").forEach(control => {

    const productId = control.dataset.productId
    const addButton = control.querySelector(".add-to-cart-button")
    const counter = control.querySelector(".cart-counter")
    const quantitySpan = control.querySelector(".cart-quantity")

    const plus = control.querySelector(".cart-plus")
    const minus = control.querySelector(".cart-minus")

    let quantity = 1

    addButton?.addEventListener("click", () => {

      fetch("/cart_items", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({
          product_id: productId,
          quantity: 1
        })
      })

      addButton.classList.add("hidden")
      counter.classList.remove("hidden")

      updateCartBadge(1)

    })

    plus?.addEventListener("click", () => {

      quantity++
      quantitySpan.innerText = quantity

      updateCart(productId, quantity)
      updateCartBadge(1)

    })

    minus?.addEventListener("click", () => {

      if (quantity <= 1) return

      quantity--
      quantitySpan.innerText = quantity

      updateCart(productId, quantity)
      updateCartBadge(-1)

    })

  })

})

function updateCart(productId, quantity) {

  fetch("/cart_items/update_quantity", {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
    },
    body: JSON.stringify({
      product_id: productId,
      quantity: quantity
    })
  })

}

function updateCartBadge(change) {

  const badge = document.querySelector(".cart-count")

  if (!badge) return

  let current = parseInt(badge.innerText || 0)

  badge.innerText = current + change

}