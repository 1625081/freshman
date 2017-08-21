# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file. JavaScript code in this file should be added after the last require_* statement.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require semantic-ui
#-----simditor-----(NOTICE: the order of these JS can't be changed.)
#= require simditor/module
#= require simditor/hotkeys
#= require simditor/uploader
#= require simditor/simditor
#------------------
#= require_tree .

# simditor config
$(document).on "turbolinks:load", ->
  if $("body").data('action') in ["new","edit"] and $("body").data('controller') == "posts"
    editor = new Simditor(
      textarea: $('textarea:last')
      tabIndent: true
      params: {}
      toolbarFloat: true
      upload:
        url: '/images'
        connectionCount: 1
        leaveConfirm: '正在上传文件，如果离开上传会自动取消'
      pasteImage: true
      toolbar: ['bold', 'italic', 'underline', '|', 'ol', 'ul', 'blockquote', 'code', '|', 'link',  '|','image', 'indent', 'outdent', '|', 'hr', 'table']
    )

  $('.message').on 'click', () ->
    $(this)
      .closest('.message')
      .transition('fade')

  width = $(window).width()
  $(".ui.fluid.category.search").css("padding-top",width*0.408/2)
  $(".ui.fluid.category.search").css("padding-bottom",width*0.408/2)


  if $("body").data 'action' in ["show","index"]
    $("body").css 'background','beige'
    $("table").addClass "ui unstackable celled table"
    $("img").addClass "ui image"
