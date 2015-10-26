$ ->
  $.extend $.fn.DataTable.defaults,
    searching: true
    ordering: true
    deferRender: true
    lengthMenu: [10, 25, 50, 100]
    serverSide: true

    initComplete: ->
      $('.filters input, .filters select', @).on 'change', (e) =>
        th = $(e.target).closest("th")
        @api().column(th.index()).search($(e.target).val()).draw()