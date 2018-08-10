#= require jquery-deparam
#= require URI

$(document).ready ->
  $('.linkage-cols-select').get().forEach (cols_e)->
    name = $(cols_e).attr('table_name')
    filter_name = $(cols_e).attr('condition_name')
    table = $('*[data-linkage-cols-trigger='+name+']')

    if($(cols_e).find("##{filter_name}___all_cols").val()=='')
      not_shown = {}
      cols = $(table).find('th:not(.linkage-ignore)').map ->
        if $(this).is('.linkage-invisible')
          not_shown[$(this).text()] = true
        $(this).text()
      $(cols_e).find("##{filter_name}___all_cols").val(JSON.stringify(cols.get()))

      cols.each ->
        if not_shown[this]
          $("##{filter_name}___cols").append('<option value="'+this+'">'+this+'</option>')
        else
          $("##{filter_name}___cols").append('<option selected value="'+this+'">'+this+'</option>')

    $(table).addClass('table-linkage-cols')
    table.attr('data-linkage', JSON.stringify({triggers: {selector: "##{filter_name}___cols", matcher: 'text'}}))
    $(document).trigger('bind.linkage', table[0])

    $("##{filter_name}___cols").on 'change', ()->
      new_cols = $(this).find('option:selected').map ->
        $(this).val()

      $('.pagination').find('a').get().forEach (a)->
          url = URI($(a).attr('href'))
          params = jQuery.deparam(url.query())
          if (params[filter_name])
            params[filter_name]['__cols'] = new_cols.get()
          else
            params[filter_name] = {
              __cols: new_cols.get()
              __all_cols: $("##{filter_name}___all_cols").val()
            }
          url.query(jQuery.param(params))
          $(a).attr('href', url.toString())

