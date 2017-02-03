require './helpers'

build_index = coffee_builder('index')

gulp.task 'build', ['clean'], ->
	build_index.build()

gulp.task 'watch', ['build'], ->
	build_index.watch()
#	gulp.watch 'src', ['build']

gulp.task('default', ['build', 'watch'])
