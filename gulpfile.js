require("coffee-script");

var gulp = require("gulp");
var coffee = require("gulp-coffee");
var jshint = require("gulp-jshint");
var gutil = require("gulp-util");

gulp.task('coffee', function () {
  gulp.src('./app/coffee/*.coffee')
    .pipe(coffee({bare: true}))
    .pipe(jshint())
    .pipe(gulp.dest('app/js'));
});

gulp.task('watch-coffee', function () {
  gulp.watch(['./app/coffee/main.coffee'], ['coffee']);
});