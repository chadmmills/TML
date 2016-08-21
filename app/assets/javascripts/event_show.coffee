$(document).on "turbolinks:load", ->
  $("[data-show-modal='yes']").on "click", ->
    window.modal.show().waiting()

  $("[data-behavior='show-event']").on "ajax:send", (data, status) ->
    console.info "Sending request for event..."

  $("[data-behavior='show-event']").on "ajax:error", (data, status, error) ->
    console.log "ERROR"
    console.log error

