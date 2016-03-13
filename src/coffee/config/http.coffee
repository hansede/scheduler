window.config ?= {}

window.config.http ?= ['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push 'httpRequestInterceptor'
]