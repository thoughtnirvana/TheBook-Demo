# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".add-book-link").click (e) ->
    e.preventDefault();
    orig_element = this
    book_id = this.getAttribute('book_id')
    user_id = this.getAttribute('user_id')
    $.ajax url: "/users/#{user_id}/add_book", type: 'PUT', data: "book_id=#{book_id}",
    success: (d) ->
      if d
        parent = $(orig_element).parent()
        $(orig_element).remove()
        parent.append("<td>You have read this Book</td>")
    return false;

