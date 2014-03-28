require! gulp
gutil = require 'gulp-util'
stylus = require 'gulp-stylus'
jade = require 'gulp-jade'
ls = require 'gulp-livescript'

gulp.task 'jade' ->
  gulp.src './index.jade'
    .pipe jade!
    .pipe gulp.dest '.'

gulp.task 'ls' ->
  gulp.src './index.ls'
    .pipe ls bare: true
    .pipe gulp.dest '.'

gulp.task 'stylus' ->
  gulp.src './index.styl'
    .pipe stylus use: <[nib]>
    .pipe gulp.dest './css'

gulp.task \default ->
  gulp.watch './index.styl' <[stylus]>
  gulp.watch './index.jade' <[jade]>
  #gulp.watch './index.ls' <[ls]>
