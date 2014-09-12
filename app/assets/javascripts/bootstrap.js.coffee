jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $("#datetimepicker").datetimepicker
    pickTime: false
    minDate: "1/1/1930"
