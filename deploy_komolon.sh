#!/bin/bash

export LANG="en_US.UTF-8"


main()
{
	echo "This deploy option is CentOS7 only."

	print_title "CHECKING SYSTEM VALIDATION"

	local user_name=`whoami`
	if [ ! $user_name ]; then
		echo "User not set.."
		exit 1
	fi

	if id "$user_name" >/dev/null 2>&1; then
		echo "USER_NAME :""$user_name"
	else
		echo "user "$user_name" is not exist"
		exit 1
	fi

        local base_dir=$(dirname "$0")
        if [ ! -d "$base_dir" ]; then
                echo "base directroy invalid : please check your komolon path and working directory."
                exit 1
        fi 

	local deploy_path="/var/www/Komolon"
	if ! [ -x "$(command -v python3 --version)" ]; then
		echo "please install python upper then 3.6"
		exit 1
	fi

	if [ ! -d "$deploy_path" ]; then
		echo "Deploy path "${deploy_path}" is not exists..  please create deploy path"
		sudo mkdir ${deploy_path}
	fi

	local cur_usr=`stat -c "%U%G" ${deploy_path}`
	if [ "$cur_usr" != "${user_name}${user_name}" ]; then
		echo "Deploy path owner "${user_name}" is not matched.. please change owner user and group."
		sudo chown ${user_name}:${user_name} ${deploy_path}
	fi

	if [ ! -d "$deploy_path" ]; then
		echo "Deploy path is not exists."
		exit 1
	fi

	local whl_path=`find ${base_dir}/dist/ -type f -name "*.whl" | xargs stat -c "%Y %n" | sort | awk '{print $2}'`
	if [ -f "$whl_path" ]; then
		echo "falsk whl path : ""$whl_path"
	else
		echo "flask whl is not exists.."
		exit 1
	fi

	local wsgi_path=${base_dir}"/Komolon.wsgi"
	if [ ! -f "$wsgi_path" ]; then
		echo "wsgi is not exist.."
		exit 1
	fi

	print_title "STATRING PYTHON VENV"

	echo "Copy flask whl to deplay path"
	cp -f $wsgi_path $deploy_path"/"
	cp -f $whl_path $deploy_path"/"

	cd $deploy_path
	local venv_dir="$deploy_path""/venv/"
	if [ ! -d "$venv_dir" ]; then
		echo "deploy venv is not planted, install venv."
		python3 -m venv venv
	fi

	echo "activate venv"
	source $venv_dir"/bin/activate"

	pip install --upgrade pip -q

	print_title "INSTALL FLASK WHL TO DEPLOY VENV"
	local whl_name=$(basename "$whl_path")
	pip install "$deploy_path""/""$whl_name"
	pip freeze

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
