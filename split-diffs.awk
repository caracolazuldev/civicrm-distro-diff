BEGIN {
	patch_file = "ERR" # initialize

	patches = "patches" # dir to output patches
	if (ENVIRON["PATCH_DIR"]) {
		patches = ENVIRON["PATCH_DIR"]
	}
	system("test -d " patches " || mkdir -p " patches)
}

/^diff/ { next }
/Sólo en/ { next }
/Only in/ { next }

/^-{3}|+{3}/ {
	setOutput()
}

{
	print $0 >> patch_file
}

function setOutput(			file_path, path, new_file) {
	file_path = $2
	split(file_path, path, "/")
	new_file = patches "/" path[length(path)] ".patch"
	if (new_file != patch_file) {
		system("truncate --size 0 " new_file )
	}
	patch_file = new_file
}