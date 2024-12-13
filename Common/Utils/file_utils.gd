class_name FileUtils

## returns list of files at given path recursively
## taken from https://gist.github.com/hiulit/772b8784436898fd7f942750ad99e33e
static func get_all_files(path: String, file_ext := "", recursive := false, files: Array[String] = []) -> Array[String]:
	var dir := DirAccess.open(path)
	if file_ext.begins_with("."): # get rid of starting dot if we used, for example ".tscn" instead of "tscn"
		file_ext = file_ext.substr(1, file_ext.length() - 1)
	
	if DirAccess.get_open_error() == OK:
		dir.list_dir_begin()

		var file_name = dir.get_next()

		while file_name != "":
			if recursive and dir.current_is_dir():
				files = get_all_files(dir.get_current_dir() + "/" + file_name, file_ext, recursive, files)
			else:
				# trim needed because on builds resource files are suffixed with .remap, see here https://github.com/godotengine/godot/issues/66014
				file_name = file_name.trim_suffix('.remap')
				if file_ext and file_name.get_extension() != file_ext:
					# print("skipping file ", file_name)
					file_name = dir.get_next()
					continue
				
				files.append(dir.get_current_dir() + "/" + file_name)

			file_name = dir.get_next()
	else:
		print("[get_all_files()] An error occurred when trying to access %s." % path)
	return files
