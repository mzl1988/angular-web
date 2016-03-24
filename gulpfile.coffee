path = require 'path'

gulp = require 'gulp'
concat = require 'gulp-concat'
bower = require 'main-bower-files'
sourcemaps = require 'gulp-sourcemaps'
coffee = require 'gulp-coffee'
webserver = require 'gulp-webserver'
jade = require 'gulp-jade'
wrap = require 'gulp-wrap'
through = require 'through'
stylus = require 'gulp-stylus'
cache = require 'gulp-cached'
remember = require 'gulp-remember'
{argv} = require 'yargs'
gulpif = require 'gulp-if'
uglify = require 'gulp-uglify'
minifyCss = require 'gulp-minify-css'
ngAnnotate = require 'gulp-ng-annotate'
bless = require 'gulp-bless'
coffeelint = require 'gulp-coffeelint'
plumber = require 'gulp-plumber'
merge = require 'merge-stream'
order = require 'gulp-order'
rm = require 'rimraf'
revall = require 'gulp-rev-all'

config = require './config'

isProduction = argv.P

gulp.task 'bower-js', ->
  merge(
    gulp.src bower filter: /\.js$/
    gulp.src 'vendor/**/*.js'
  )
  .pipe sourcemaps.init()
  .pipe order [
    '**/jquery.js'
    '**/angular.js'
  ]
  .pipe concat 'vendor.js'
  .pipe gulpif isProduction, uglify()
  .pipe sourcemaps.write('.')
  .pipe gulp.dest 'release/javascripts'

gulp.task 'bower-css', ->
  merge(
    gulp.src bower filter: /\.css$/
    gulp.src 'vendor/**/*.css'
  )
  # .pipe sourcemaps.init()
  .pipe concat 'vendor.css'
  .pipe gulpif isProduction, minifyCss()
  # .pipe sourcemaps.write('.')
  # .pipe gulpif isProduction, bless()
  .pipe gulp.dest 'release/stylesheets'

gulp.task 'stylus', ->
  gulp.src 'app/**/*.styl'
  .pipe cache 'stylus'
  # .pipe sourcemaps.init()
  .pipe stylus()
  .pipe remember 'stylus'
  .pipe concat 'app.css'
  .pipe gulpif isProduction, minifyCss()
  # .pipe sourcemaps.write('.')
  # .pipe gulpif isProduction, bless()
  .pipe gulp.dest 'release/stylesheets'

gulp.task 'coffee', ->
  gulp.src [
    'app/**/*.coffee'
    '!app/**/_*.coffee'
  ]
  .pipe plumber()
  .pipe cache 'coffee'
  .pipe coffeelint()
  .pipe coffeelint.reporter()
  .pipe sourcemaps.init()
  .pipe coffee bare: true
  .pipe remember 'coffee'
  .pipe order [
    '**/app.coffee'
  ]
  .pipe concat 'app.js'
  .pipe gulpif isProduction, ngAnnotate()
  .pipe gulpif isProduction, uglify()
  .pipe sourcemaps.write('.')
  .pipe gulp.dest 'release/javascripts'

gulp.task 'jade', ->
  gulp.src 'app/**/*.jade'
  .pipe cache 'jade'
  .pipe jade client: true
  .pipe through (data) ->
    data.contents = new Buffer """
      angular.module('app')
      .run(['$templateCache', function($templateCache) {
        var template = #{data.contents}
        $templateCache.put('#{data.relative.replace '.js', ''}', template());
      }]);
    """
    @queue data
  .pipe remember 'jade'
  .pipe concat('template.js')
  .pipe gulpif isProduction, uglify()
  .pipe gulp.dest 'release/javascripts'

gulp.task 'asset', ->
  gulp.src 'app/assets/**/*'
  .pipe gulp.dest 'release'

gulp.task 'clean', ->
  rm.sync 'release'

gulp.task 'build', ['clean', 'bower-js', 'bower-css', 'coffee', 'stylus', 'jade', 'asset'], ->
  return if not isProduction

  gulp.src 'release/**/*'
  .pipe revall
    transformFilename: (file, hash) ->
      if file.path.match /index\.html$/
        'index.html'
      else
        ext = path.extname file.path
        basename = path.basename file.path, ext
        "#{basename}-#{hash.substr(0, 5)}#{ext}"
  .pipe gulp.dest 'release'

gulp.task 'watch', ['build'], ->
  gulp.watch 'app/**/*', (event) ->
    if event.path.match /app\/assets\//
      gulp.start 'asset'
    if event.path.match /\.coffee$/
      gulp.start 'coffee'
    if event.path.match /\.jade$/
      gulp.start 'jade'
    if event.path.match /\.styl$/
      gulp.start 'stylus'

  gulp.src 'release'
  .pipe webserver
    host: '0.0.0.0'
    port: config.port
    livereload: config.livereload

gulp.task 'default', ['watch']
