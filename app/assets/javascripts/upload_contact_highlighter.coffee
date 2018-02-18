
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
