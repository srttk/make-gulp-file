#! /bin/bash

echo "Project Name?"
read project_name

echo "Javascript directory? (js)"
read js_dir;

echo "sass directory? (scss)"
read sass_dir;

echo "css directory? (css)"
read css_dir;


read -r -d '' gulpfile <<- _GULPFILE_
var gulp = require('gulp');
var connect = require('gulp-connect');
var sass = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');

gulp.task('server', function(){
					 connect.server({
					     livereload: true  
						    
								});

					 });

gulp.task('html', function() {
  gulp.src('./*.html')
      .pipe(connect.reload());

					 });

					 gulp.task('sass', function() {
					   gulp.src('./$sass_dir/*.scss')
						    .pipe(sass())
							     .pipe(autoprefixer())
								      .pipe(gulp.dest('$css_dir'))
										    .pipe(connect.reload());

					 });

					 gulp.task('watch', function() {
					   gulp.watch(['./*.html'],['html']);
						  gulp.watch(['./$sass_dir/*.scss'],['sass']);

					 });
					  

					  gulp.task('default', ['server','watch']);

_GULPFILE_
echo "$gulpfile" > gulpfile.js


# Create package.json file
read -r -d '' npm_package <<- _PACKAGE_JSON_
{
  "name": "$project_name",
  "version": "1.0.0",
  "description": "",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "gulp-autoprefixer": "^3.1.0",
    "gulp-connect": "^2.3.1",
    "gulp-sass": "^2.1.1"
  }
}

_PACKAGE_JSON_
echo "$npm_package" > package.json

