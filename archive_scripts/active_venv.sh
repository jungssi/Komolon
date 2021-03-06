#!/bin/bash

export LANG="en_US.UTF-8"

main()
{
	if ! [ -x "$(command -v python3 --version)" ]; then
		echo "please install python upper then 3.6"
		exit 1
	fi

	local base_dir=$(dirname "$0")
	if [ ! -d "$base_dir" ]; then
		echo "base directroy invalid : please check your komolon path and working directory."
		exit 1
	fi

	local venv_dir="$base_dir""/venv/"
	if [ ! -d "$venv_dir" ]; then
		echo "venv is not planted, install venv."
		cd $base_dir
		python3 -m venv venv
		cd -
	fi

	echo "activate venv"
	source $venv_dir"/bin/activate"

	echo "update pip and requirements"
	local req_path="${base_dir}/venv_requirements.txt"
	pip install --upgrade pip -q
	pip install -r $req_path -q
	pip freeze
}

main
