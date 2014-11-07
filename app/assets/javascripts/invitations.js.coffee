# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

jQuery ->
  toggle_elements = () ->
    $('.sign-up-form').toggle()


  $('.toggle_form').click (e) ->
    toggle_elements()

  $('.toggle_form_footer').click (e) ->
    window.scrollTo(0, 0)

  $("#new_invitation")
    .on "ajax:error", (event, data) ->
      console.log data
      console.log $("#error_messages")
      if $("#error_messages").length > 0
        $("#error_messages").replaceWith(data.responseText)
      else
        $(this).prepend(data.responseText)
