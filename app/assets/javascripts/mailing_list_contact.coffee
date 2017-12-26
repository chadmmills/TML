searchingContact = (contact) ->
  return true unless this.search.length
  return contact.name.toLowerCase().includes(this.search.toLowerCase())

addedToMailingList = (contact) ->
  return true unless this.filterByAdded?
  return true if this.filterByAdded and contact.assignment_id
  return true if not this.filterByAdded and not contact.assignment_id
  return false

MailingContact =
  el: "#mailing_list__contacts-list"
  data:
    contacts: []
    filterByAdded: null
    mailingListId: null
    search: ""
    toggleState: "on"
  computed:
    filteredContacts: () ->
      self = @
      @contacts.filter(searchingContact, self).filter(addedToMailingList, self)
    assignedContacts: () ->
      @contacts.filter (contact) -> contact.assignment_id
    numberOfAssignedContacts: () ->
      @assignedContacts.length
  methods:
    toggleAddedFilter: () ->
      @filterByAdded = !@filterByAdded
    clearFilters: () ->
      @filterByAdded = null
      @search = ""
    showContactModalWith: (contact) ->
      TMLContactModal.showContactWithId(contact.id)
    markActionComplete: (contact) ->
      contact.is_complete = !contact.is_complete
      TMLAxios.patch "/mailing-list-contacts/#{contact.assignment_id}.json",
        contact
      .then (response) -> contact.is_complete = contact.is_complete
      .catch (error) -> console.error(error)
    markAsBlocked: (contact) ->
      contact.is_blocked = !contact.is_blocked
      TMLAxios.patch "/mailing-list-contacts/#{contact.assignment_id}.json",
        contact
      .then (response) -> contact.is_blocked = response.data.is_blocked
      .catch (error) -> console.error(error)
    addToList: (contact) ->
      window.TMLAxios.post "/mailing-list-contacts.json",
        contact_id: contact.id,
        mailing_list_id: contact.list_id,
      .then (response) -> contact.assignment_id = response.data.assignment_id
    toggleAddAll: () ->
      TMLAxios.patch "/mailing-list-contacts-toggle.json",
        mailing_list_id: @mailingListId
        state: @toggleState
      .then ({ data }) =>
        @contacts = data.contacts
        @toggleState = if @toggleState is "on" then "off" else "on"


  mounted: ->
    this.contacts = window._contacts || []
    this.mailingListId = window._mailing_list_id
    setInterval () =>
      TMLAxios.get "/mailing-lists/#{@mailingListId}.json"
        .then ({ data }) => this.contacts = data.contacts
    , 15000

document.addEventListener "turbolinks:load", ->
  if document.getElementById("mailing_list__contacts-list")
    console.info "MailingContact initialized..."
    new Vue(MailingContact)
