#!/bin/bash

export LANG="en_US.UTF-8"

main()
{
	local base_dir=$(dirname "$0")
	if [ ! -d "$base_dir" ]; then
		echo "base directroy invalid : please check your komolon path and working directory."
		exit 1
	fi

	cd $base_dir"/build/" && cd - && rm -rf $base_dir"/build/"
	cd $base_dir"/dist/" && cd - && rm -rf $base_dir"/dist/"
	cd $base_dir"/Komolon.egg-info/" && cd - && rm -rf $base_dir"/Komolon.egg-info/"
	cd $base_dir"/venv/" && cd - && rm -rf $base_dir"/venv/"

}

main
