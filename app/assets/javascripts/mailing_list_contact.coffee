addedToMailingList = (contact) ->
  return true unless this.filterByAdded?
  return true if this.filterByAdded and contact.assignment_id
  return true if not this.filterByAdded and not contact.assignment_id
  return false

MailingContact =
  el: "#mailing_list__contacts-list"
  data:
    filterByAdded: null
    contacts: []
  computed:
    filteredContacts: () ->
      self = @
      @contacts.filter(addedToMailingList, self)
    assignedContacts: () ->
      @contacts.filter (contact) -> contact.assignment_id
    numberOfAssignedContacts: () ->
      @assignedContacts.length
  methods:
    toggleAddedFilter: () ->
      @filterByAdded = !@filterByAdded
    clearFilters: () ->
      @filterByAdded = null
    showContactModalWith: (contact) ->
      TMLContactModal.showContactWithId(contact.id)
    markActionComplete: (contact) ->
      TMLAxios.patch "/mailing-list-contacts/#{contact.assignment_id}.json"
      .then (response) -> contact.is_complete = !contact.is_complete
      .catch (error) -> console.error(error)
    addToList: (contact) ->
      window.TMLAxios.post "/mailing-list-contacts.json",
        contact_id: contact.id,
        mailing_list_id: 3,
      .then (response) -> contact.assignment_id = response.data.assignment_id


  mounted: ->
    this.contacts = window._contacts || []

document.addEventListener "turbolinks:load", ->
  if document.getElementById("mailing_list__contacts-list")
    console.info "MailingContact initialized..."
    new Vue(MailingContact)
