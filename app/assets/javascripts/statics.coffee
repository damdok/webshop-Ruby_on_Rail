# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#user_credit').on "input", (event) ->
    $('#credit-span').html($('#user_credit').val() / 100)


$(document).ready(ready)
$(document).on('page:load', ready)