# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$ ->
  $('[data-toggle="tooltip"]').tooltip()
  $('.row-reveal').click ->
    row = $("##{$(@).attr('for')}")
    row.slideToggle("slow")
    @.text = "Hide"
