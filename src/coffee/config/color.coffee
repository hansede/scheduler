window.config ?= {}

window.config.color ?= ['$mdThemingProvider', ($mdThemingProvider) ->

  cyan_map = $mdThemingProvider.extendPalette('cyan',
    '500': '#0098cc',
    'contrastLightColors': ['500']
  )

  $mdThemingProvider.definePalette('cyan-ish', cyan_map)

  $mdThemingProvider
    .theme('default')
    .primaryPalette('cyan-ish',
      default: '500'
    )
    .warnPalette('red')

  $mdThemingProvider
    .theme('grey-theme')
    .primaryPalette('grey',
      default: '100'
    )
]