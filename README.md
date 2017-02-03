Empty CoffeeScript Project
==========================

Fast create an CoffeeScript project with build command.

You can also just treat this repo as an gulpfile reference if you are familiar with gulp.

Properties
----------

- build source files with **gulp** & **browserify**
- watch file changes & fast rebuild with **watchify**
- build all CoffeeScript source files into one(or more if you want) JavaScript file.
- you can use `require` from nodejs (CommonJS Style) directly
- compiled JavaScript can be used on both nodejs and browser
- both complete version and minified version are built

How to use
----------

### prepare

1. install gulp globally
	```
	npm install -g gulp
	```

### create new project

1. clone this repo
	```
	git clone git@github.com:luochen1990/empty-coffee-project.git
	```
2. install npm packages
	```
	cd path/to/this/repo/
	npm install
	```
3. reset git commit messages & upstream
	```
	rm -rf .git
	git init
	```
4. modify package.json and replace `???` to proper informations of yours
5. create `/src` directory to put source files(includes .coffee, .js, .html, .css etc.)

### commands in developing

- `gulp build`, build source files from `src/` to `build/`
- `gulp clean`, clean built files under `build/`
- `gulp watch`, start to watch file changes and rebuild source files
- `gulp`, build then watch

