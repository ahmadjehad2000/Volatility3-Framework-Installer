#!/usr/bin/env bash

figlet adhmad 0xD8.CLUB
declare -a pkgs=("build-essential" "libdistorm3-dev" "yara" "libraw1394-11" "libcapstone-dev" "capstone-tool" "tzdata")
echo 'Welcome To Volatility3 Framework Installer'
if [[ $(id -u) != 0 ]]
then
	echo "Please run the installer as root (SUDO)"
else
	echo 'Running as root (SUDO)'
	echo 'Checking if dependencies are installed'
	sleep 1
	echo '-------------------------'
	for i in "${pkgs[@]}"
	do
        command=$(dpkg -s $i 2> /dev/null | awk {'print $2'} | grep -e install)
        if [[ $command == "install" ]]
	then
		echo -e "$(tput setaf 4) $i installed"
		sleep 1
	else
		echo -e "$(tput setaf 1) $i not installed"
		sleep 1
		echo -e "----------------\n"
		echo -e "$(tput setaf 6) installing $i \n"
		echo -e "_______________\n"
		apt-get install $i -y
		echo -e "$(tput setaf 4) Finished installing $i\n"
		echo -e "______________\n"
	fi
	done
	echo -e "\nChecking of packages made successfully!"
	sleep 1
	echo -e "______________________\n"
	echo -e "Installing python3 pip3 libraries\n"
	echo -e "_______________________\n"
	sleep 1 
	apt install -y python3 python3-dev libpython3-dev python3-pip python3-setuptools python3-wheel
	echo -e "______________________\n"
	sleep 2
	python3 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone
	echo -e "installed python3 pip3 libraries"
	sleep 2
	if [[ $(python3 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone) ]]
	then 
		sleep 2
		echo -e "$(tput setaf 7) now installing volatility 3\n"
		sleep 2
		python3 -m pip install -U git+https://github.com/volatilityfoundation/volatility3.git
		if [[ $(python3 -m pip install -U git+https://github.com/volatilityfoundation/volatility3.git) ]]
		then 
			sleep 2
			echo -e "_______________________\n"
			echo -e "Configuring PATH"
			sleep 1
			echo -e "\n":
			sleep 1
			read -p "Please enter your user path name: " user
			echo -e "$(tput setaf 2) User : $user"
			shellvar=$(which $SHELL | cut -d '/' -f 4)
			echo -e "please enter: export PATH=/home/$user/.local/bin:"\$PATH" >> ~/."$shellvar"rc"
                        echo -e "then please enter:  . ~/."$shellvar"rc"
			echo -e "\n Run volatility by:\n sudo vol\t sudo volshell (SUDO)\t\n"
			su $user
		else
			echo -e "$(tput setaf 2) problems with python3 volatility libraries"
		fi			
	else
		echo -e "$(tput setaf 1) problems with python3 pip"

	fi
fi 

        
