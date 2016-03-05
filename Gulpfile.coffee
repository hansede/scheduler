gulp = require 'gulp'
live_reload = require 'gulp-livereload'
args   = require('yargs').argv
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
stylus = require 'gulp-stylus'
css_nano = require 'gulp-cssnano'
gulp_if = require 'gulp-if'
if_else = require 'gulp-if-else'
jade = require 'gulp-jade'
gulp_replace = require 'gulp-replace'

is_prod = args.target is 'production'
is_livereload = args.livereload is 'true'

gulp.task 'javascript', ->
  gulp.src [
    'bower_components/angular/angular.js'
    'bower_components/angular-aria/angular-aria.js'
    'bower_components/angular-animate/angular-animate.js'
    'bower_components/angular-material/angular-material.js'
    'src/coffee/controller/**/*'
    'src/coffee/factory/**/*'
    'src/coffee/scheduler.coffee'
  ]
    .pipe gulp_if /[.]coffee$/, coffee()
    .pipe uglify(outSourceMap: no, mangle: is_prod, compress: is_prod, output: {beautify: not is_prod})
    .pipe concat 'compress.min.js'
    .pipe gulp.dest 'dist/js'
    .pipe if_else is_livereload, live_reload

gulp.task 'css', ->
  gulp.src [
    'bower_components/angular-material/angular-material.css'
    'src/stylus/**/*'
  ]
    .pipe(gulp_replace(/\/images\//g, '/img/'))
    .pipe gulp_if /[.]styl$/, stylus()
    .pipe css_nano()
    .pipe concat 'compress.min.css'
    .pipe gulp.dest 'dist/css'
    .pipe if_else is_livereload, live_reload

gulp.task 'html', ->
  gulp.src ['src/index.jade']
    .pipe jade()
    .pipe gulp.dest 'dist'
    .pipe if_else is_livereload, live_reload

  gulp.src 'src/jade/**/*'
    .pipe jade()
    .pipe gulp.dest 'dist/html'
    .pipe if_else is_livereload, live_reload

gulp.task 'build', ['javascript', 'css', 'html']

gulp.task 'default', ->
  if is_livereload then live_reload()

  gulp.watch('gulpfile.coffee', ['build']).on 'change', (event) ->
    console.log("#{event.path} was #{event.type}")

  gulp.watch(['src/coffee/**/*'], ['javascript']).on 'change', (event) ->
    console.log("#{event.path} was #{event.type}")

  gulp.watch(['src/stylus/**/*'], ['css']).on 'change', (event) ->
    console.log("#{event.path} was #{event.type}")

  gulp.watch(['src/index.jade', 'src/jade/**/*'], ['html']).on 'change', (event) ->
    console.log("#{event.path} was #{event.type}")