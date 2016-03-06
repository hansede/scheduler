window.config ?= {}

window.config.color ?= ['$mdThemingProvider', ($mdThemingProvider) ->

  cyan_map = $mdThemingProvider.extendPalette('cyan',
    '500': '#0098cc',
    'contrastLightColors': ['500']
  )

  $mdThemingProvider.definePalette('cyan-ish', cyan_map)

  $mdThemingProvider
    .theme('default')
    .primaryPalette('grey',
      default: '100',
      'hue-1': '100',
      'hue-2': '200',
      'hue-3': '300'
    )
    .accentPalette('cyan-ish',
      default: '500'
    )
    .warnPalette('red')
]