describe 'selectNavigator', ->
  select = undefined
  navigator = undefined
  beforeEach ->
    select = $('<select id="animal-select"></select>')
    select.append('<option value="/dog" data-method="post">Dog</option>')
    select.append('<option value="/lion" data-method="put">Lion</option>')
    select.append('<option value="/cat">Cat</option>')
    select.selectNavigator()
    navigator = select.data('select-navigator')

  describe 'changing the select', ->
    beforeEach ->
      spyOn(navigator, 'doRedirect').andCallFake ->
      spyOn(navigator, 'doFormSubmission').andCallFake ->

    it 'should handle simple GET requests', ->
      select.val('/cat').trigger('change')
      expect(navigator.doRedirect).toHaveBeenCalledWith '/cat'

    it 'should handle POST and other requests', ->
      select.val('/lion').trigger('change')
      select.trigger 'change'
      expect(navigator.doFormSubmission).toHaveBeenCalledWith '/lion', 'put'


  describe 'buildForm', ->
    it 'should handle simple post forms', ->
      form = navigator.buildForm('/mypath', 'post')
      expect(form.attr('action')).toEqual '/mypath'
      expect(form.attr('method')).toEqual 'post'
      expect(form.find('input[name="_method"]').length).toEqual 0

    it 'should create a hidden field for method if anything other than POST', ->
      form = navigator.buildForm('/mypath', 'put')
      expect(form.attr('action')).toEqual '/mypath'
      expect(form.attr('method')).toEqual 'post'
      expect(form.find('input[name=\'_method\']').val()).toEqual 'put'

    it 'should include a hidden field for the csrf token if present', ->
      form = navigator.buildForm('/mypath', 'put')
      expect(form.find('input[name="authenticity_token"]').val()).toEqual '4uzs798NiSsv3e/OfbtSC/0Adt/ACW3WyA8WVWMG3O8='


  describe 'doFormSubmission', ->
    it 'should build a form and submit it', ->
      form = navigator.buildForm('/mypath', 'put')
      spyOn(navigator, 'buildForm').andReturn form
      spyOn(form, 'submit').andCallFake ->

      navigator.doFormSubmission '/mypath', 'put'
      expect(navigator.buildForm).toHaveBeenCalledWith '/mypath', 'put'
      expect(form.submit).toHaveBeenCalled()


  describe 'csrfParamName', ->
    it 'should return the value from the meta tag if there is one', ->
      expect(navigator.csrfParamName()).toEqual 'authenticity_token'


  describe 'csrfToken', ->
    it 'should return the value from the meta tag if there is one', ->
      expect(navigator.csrfToken()).toEqual '4uzs798NiSsv3e/OfbtSC/0Adt/ACW3WyA8WVWMG3O8='



