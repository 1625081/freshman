# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->
  $('.ui.dropdown')
    .dropdown()
  # $('.main_post').on "click", ->
  #   href = $(this).data("link")
  #   console.log($(this))
  #   window.location.href = href
  post_dir = () ->
    href = $(this).data("link")
    window.location.href = href

  $('.main_post').on "click", post_dir
  $(".red.button , .blue.button").on 'click', (e) ->
    e.stopPropagation()

  $('#flash').on "click", ->
    $(this).hide()
  $('.choosen_tag').on "click", ->
    $(this).toggleClass "teal"
  $('#add_tag').on "click", ->
    newtag = $("input[name='add_tag']").val()
    numarr= []
    tags = $('.tag_container').find "a"
    numarr.push $(tag).attr "data-tag" for tag in tags
    if newtag in numarr
      alert "此tag已存在"
      return
    if newtag isnt ""
      html = "<a class=\"ui tag label choosen_tag\" data-tag="+ newtag + ">" + newtag + "</a>"
    $(".tag_container").append html
    $("input[name='add_tag']").val ""
    $('.tag_container a:last').on "click", ->
      $(this).toggleClass "teal"

  $('#submit_post').on "click", ->
    numarr = []
    tags = $('.tag_container').find "a"
    numarr.push($(tag).attr("data-tag")) for tag in tags when $(tag).hasClass("teal") and $(tag).attr("data-tag") not in numarr
    $('#tags_submit').val numarr
    $('form').submit()
