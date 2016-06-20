angular.module 'app'
.directive 'btn', ->
  {
    restrict: 'C'
    link: (scope, element) ->
      if element.hasClass('btn-icon') or element.hasClass('btn-float')
        Waves.attach element, [ 'waves-circle' ]
      else if element.hasClass('btn-light')
        Waves.attach element, [ 'waves-light' ]
      else
        Waves.attach element
      Waves.init()
      return

  }