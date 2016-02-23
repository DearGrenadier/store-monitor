#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require_tree .

$(document).ready ->
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
