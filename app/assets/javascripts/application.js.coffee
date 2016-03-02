#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require_tree .

$(document).on 'ready page:load', ->
  # change price and current amount of item, related on size
  $('select').change ->
    values = []
    $(this.options).each ->
      values.push this.value
    idx = values.indexOf this.value
    parent = $(this).parent()

    priceTd = parent.next()
    priceTd.find('li:not(.hidden)').addClass('hidden')
    $(priceTd.find('li')[idx]).removeClass('hidden')

    amountTd = parent.next().next()
    amountTd.find('li:not(.hidden)').addClass('hidden')
    $(amountTd.find('li')[idx]).removeClass('hidden')

  # clear amount inpunt on click
  $('span.glyphicon').click ->
    $(this).parent().prev().find('input').val(0)
