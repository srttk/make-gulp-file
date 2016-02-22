#! /bin/bash


# Create project directory structure


# Source directrory

echo -n "Enter source directory . default(src):"

read src_dir

if [ "$src_dir" == "" ] ; then 
  src_dir = src
fi

mkdir $src_dir
mkdir $src_dir/js
mkdir $src_dir/css
mkdir $src_dir/scss
mkdir $src_dir/images
mkdir $src_dir/es6

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
  		gulp.src('./$src_dir/**/*.html')
      	.pipe(connect.reload());

});

// Scripts

gulp.task('script',function(){
    gulp.src('./$src_dir/js/**/*.js')
      .pipe(connect.reload());
});

// Sass
gulp.task('sass', function() {
	gulp.src('./$src_dir/scss/**/*.scss')
	.pipe(plumber())
	.pipe(sass())
	.pipe(autoprefixer())
	.pipe(gulp.dest('./$src_dir/css'))
	.pipe(connect.reload());

});

// Watch

 gulp.task('watch', function() {
		gulp.watch(['./$src_dir/**/*.html'],['html']);
		gulp.watch(['./$src_dir/js/**/*.js'],['script']);
	  gulp.watch(['./$src_dir/scss/**/*.scss'],['sass']);

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


confirm=$(echo "$confirm" | tr [:upper:] [:lower:])


echo "$confirm"

if [ "$confirm" == "yes" ] || [ "$confirm" == "y" ] ; then
  npm install
fi



