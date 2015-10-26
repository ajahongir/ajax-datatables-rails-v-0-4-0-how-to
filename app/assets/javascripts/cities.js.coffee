class App.Cities extends App.Base

  index: ->
    $ ->
      $('#dataTable').dataTable
        ajax: cities_path()
        columns: [
            data: "id"
          ,
            data: "name"
          ,
            data: "iata"
          ,
            data: "timezone"
          ,
            data: "country_name"
        ]
