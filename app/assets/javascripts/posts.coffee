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

  sdown = () ->
    $("#upper").slideDown()
    $(".header").unbind "click",sdown
    $(".header p:first").html("新生答疑汇总")

  $("#search_form").on "submit", ->
    $("#upper").slideUp()
    $(".header p:first").html("返回顶部")
    $(".header").bind "click",sdown

  $("body").on "click",".top_label", ->
    $("input:first").val($(this).data('tag'))
    $("#search_form").submit()

  # 对子元素实现动态绑定
  $("body").on "click",".main_post", post_dir
  $("body").on 'click',".red.button , .blue.button", (e) ->
    e.stopPropagation()

  $('#new_question').dimmer "hide"
  $('#ask_question').on "click", ->
    $('#new_question').dimmer "show"

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

  $("#submit_question").on "click", ->
    $("form").submit()

  $('.ui.form')
    .form({
      fields : {
        title : {
          identifier : 'post[title]',
          rules: [
            {
              type  : 'empty',
              prompt  : '标题不可为空哦~'
            },{
              type  : 'minLength[6]',
              prompt : '小哥哥太短了啦(*/ω＼*)'
            }
          ]
        },
        content : {
          identifier : 'post[content]',
          rules : [
            {
              type  : 'empty',
              prompt  : '内容不可为空哦~'
            }
          ]
        }
      }
    })
