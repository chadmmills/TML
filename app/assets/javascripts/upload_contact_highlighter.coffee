$(document).on "turbolinks:load", ->
  $("[data-behavior='show-included-contacts']").on "mouseover", (evt) ->
    listItem = $(evt.target).parent("li[data-behavior='show-included-contacts']")
    new UploadContactHighlighter(listItem).highlightContacts()

  $("[data-behavior='show-included-contacts']").on "mouseout", (evt) ->
    listItem = $(evt.target).parent("li[data-behavior='show-included-contacts']")
    new UploadContactHighlighter(listItem).unHighlightContacts()

class UploadContactHighlighter
  constructor: (@$upload) ->
    console.info "Upload highlighter started ..."

  highlightContacts: () ->
    @toggleHighlight()

  unHighlightContacts: () ->
    @toggleHighlight()

  toggleHighlight: () ->
    for id in @contactIds()
      document.getElementById("contact_#{id}").classList.toggle("highlight")

  contactIds: () ->
    @$upload.data("contact-ids").split ","
