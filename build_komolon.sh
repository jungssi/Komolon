#!/bin/bash

export LANG="en_US.UTF-8"

main()
{
	echo "Welcome to duty K-guardian.."

	print_title "CHECKING SYSTEM VALIDATION"

	if ! [ -x "$(command -v python3 --version)" ]; then
		echo "please install python upper then 3.6"
		exit 1
	fi

	local base_dir=$(dirname "$0")
	if [ ! -d "$base_dir" ]; then
		echo "base directroy invalid : please check your komolon path and working directory."
		exit 1
	fi

	print_title "STATRING PYTHON VENV"

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
	local req_path="${base_dir}/requirements.txt"
	pip install --upgrade pip -q
	pip install -r $req_path -q
	pip freeze


	print_title "BUILD FLASK WHL"

	cd ${base_dir}
	python setup.py bdist_wheel
	cd -

	echo "deactivate venv"
	deactivate
}

function print_title()
{
	echo "----------------------------------------------------------------------"
	echo "$1"
	echo "----------------------------------------------------------------------"
}

main
