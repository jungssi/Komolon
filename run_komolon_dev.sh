#!/bin/bash

export LANG="en_US.UTF-8"

main()
{
	print_start_message
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
	local req_path="${base_dir}/venv_requirements.txt"
	pip install --upgrade pip -q
	pip install -r $req_path -q
	pip freeze


	print_title "RUNNING DEV FLASK SERVER"

	echo "코몰론 개발 서버 가동 시작 < 부활 제한 구역 >"
	local flask_path=$base_dir"/server/run_flask.py"
	env FLASK_APP=$flask_path flask run
	echo "flask down.."

	echo "deactivate venv"
	deactivate
}

function print_start_message()
{
cat << "EOF"
   __ __                __            _   ____           __ __    _____                 ___         
  / //_/__  __ _  ___  / /__  ___    (_) / __/__  ____  / //_/___/ ___/_ _____ ________/ (_)__ ____ 
 / ,< / _ \/  ' \/ _ \/ / _ \/ _ \  _   / _// _ \/ __/ / ,< /___/ (_ / // / _ `/ __/ _  / / _ `/ _ \
/_/|_|\___/_/_/_/\___/_/\___/_//_/ (_) /_/  \___/_/   /_/|_|    \___/\_,_/\_,_/_/  \_,_/_/\_,_/_//_/
                                                                                                    
EOF
}

function print_title()
{
	echo "----------------------------------------------------------------------"
	echo "$1"
	echo "----------------------------------------------------------------------"
}

main
