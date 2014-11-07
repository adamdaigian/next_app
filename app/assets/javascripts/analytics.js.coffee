jQuery ->

  $('[track]').click () ->
    mixpanel.track($(this).attr("track"))
