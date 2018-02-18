// Run this example by adding <%= javascript_pack_tag "hello_elm" %> to the
// head of your layout file, like app/views/layouts/application.html.erb.
// It will render "Hello Elm!" within the page.

import Elm from '../ContactsList'

document.addEventListener("turbolinks:load", () => {
  const target = document.getElementById('contacts-table')

  if (target) {
    Elm.ContactsList.embed(target)
    console.info("Initialized Elm Contacts List Table...")
  }
})
