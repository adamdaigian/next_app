jQuery ->
  status_check_count = 0
  status_ok = false
  timer = null
  $('.loading').addClass('spin')



  redirect_url = () ->
    if $('#processing-account').data("github_auth") == true
      "https://github.com/login/oauth/authorize?client_id=faefad85adc892922e4b"
    else
      "https://beta.elasticbox.com/"


  check_status = () ->
    account_token = $('#processing-account').data(account_token).account_token
#    account_token = $('#processing-account').data("account_token")
    $.ajax
      type: 'get'
      url: "/hi/checkstatus/#{account_token}"
      data: {}
      error: (jqXHR, textStatus, errorThrown) ->
        console.log 'Error while checking status'

      success: (data, textStatus, jqXHR) ->
        status_check_count += 1
        # console.log data
        # console.log status_check_count
        if data.status == 'ok'
          status_ok = true
          $('.message').html("Your account is now ready :-)")
          $('.loading').removeClass('spin')

          window.location.replace(redirect_url())

           
        else if data.status == 'error'
          $('#processing-account').html(data.message)
          $('.message').html(data.message)
          $('.loading').removeClass('spin')

        else # it's processing
          console.log "will try again"

      dataType: 'json'



  get_status_or_clear = () ->
    if status_ok == false
      console.log 'doing do_something - false'
      check_status()
    else
      console.log 'doing do_something - else'
      clearInterval(timer)


  if $('#processing-account').length > 0 and status_ok == false
    timer = setInterval ( -> get_status_or_clear() ), 1000
