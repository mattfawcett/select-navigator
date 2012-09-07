class SelectNavigator
  constructor: (select)->
    select.data('select-navigator', this)

    @defaultMethod = select.data('method') || 'get'

    select.bind 'change', (e)=>
      selectedOption = select.find('option:selected')
      url = selectedOption.val()
      method = selectedOption.data('method') || @defaultMethod
      if method == 'get'
        @doRedirect url
      else
        @doFormSubmission(url, method)

  doRedirect: (url)->
    window.location = url

  doFormSubmission: (url, method)->
    @buildForm(url, method).submit()

  buildForm: (url, method)->
    form = $("<form/>", { method: 'post', action: url })
    unless method == 'post'
      form.append($('<input/>', {type: 'hidden', name: '_method', value: method}))
    if @csrfParamName() and @csrfToken()
      form.append($('<input/>', {type: 'hidden', name: @csrfParamName(), value: @csrfToken()}))
    return form

  csrfParamName: ->
    $('meta[name="csrf-param"]').attr('content')

  csrfToken: ->
    $('meta[name="csrf-token"]').attr('content')

jQuery.fn.extend
  selectNavigator: ->
    new SelectNavigator(this)
