#! /bin/bash


# Create project directory structure

mkdir src
mkdir src/js
mkdir src/css
mkdir src/scss
mkdir src/images
mkdir src/es6

mkdir dist

# Create gulpfile.js
read -r -d '' gulpfile <<- _GULPFILE_
var gulp = require('gulp');
var plumber = require('gulp-plumber');
var connect = require('gulp-connect');
var sass = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');


// Server Task
gulp.task('server', function(){
	connect.server({
					 livereload: true  
					});

});

// Html 

gulp.task('html', function() {
  		gulp.src('./*.html')
      	.pipe(connect.reload());

});

// Scripts

gulp.task('script',function(){
    gulp.src('./$js_dir/*.js')
      .pipe(connect.reload());
});

// Sass
gulp.task('sass', function() {
	gulp.src('./$sass_dir/*.scss')
	.pipe(plumber())
	.pipe(sass())
	.pipe(autoprefixer())
	.pipe(gulp.dest('$css_dir'))
	.pipe(connect.reload());

});

// Watch

 gulp.task('watch', function() {
		gulp.watch(['./*.html'],['html']);
		gulp.watch(['./$js_dir/*.js'],['script']);
	    gulp.watch(['./$sass_dir/*.scss'],['sass']);

});
					  

gulp.task('default', ['server','watch']);

_GULPFILE_

echo "$gulpfile" > gulpfile.js

# Create package.json
# Create package.json file
read -r -d '' npm_package <<- _PACKAGE_JSON_
{
  "name": "$project_name",
  "version": "1.0.0",
  "description": "$project_desc",
  "main": "",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "devDependencies": {
  	"gulp-plumber": "*",
    "gulp-autoprefixer": "*",
    "gulp-connect": "*",
    "gulp-sass": "*"
  }
}

_PACKAGE_JSON_
echo "$npm_package" > package.json

# Run npm install
read -ep "    Run npm install [y/n]: " confirm

echo 
	#npm install



