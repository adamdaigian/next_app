jQuery ->
  get_rank = ->
    $('#rank').html()


  $('#linkedin').click () ->
    text = "ElasticBox&20Beta&20Developer&20Edition!&summary=Exited%20to%20be%20invite%20number%20" + get_rank() + "%20For%20the%20ElasticBox%20Beta%20Developer%20Edition"
    window.open "http://www.linkedin.com/shareArticle?mini=true&url=http%3A//beta.elasticbox.com&title=#{text}", '_blank', 'width=700,height=500', 'location=no'

  $('#twitter').click () ->
    text = "Sign%20up%20for%20the%20ElasticBox%20Developer%20Edition.%20I%20am%20invite%20number%20" + get_rank() + "%20&via=ElasticBox"
    window.open "http://twitter.com/share?url=http%3A%2F%2Fbeta.elasticbox.com&text=#{text}", '_blank', 'width=700,height=500', 'location=no'