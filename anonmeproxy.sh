#!/bin/bash
#Script created by mescu

clear

echo "https://twitter.com/mescu"

echo "https://github.com/mescu"

echo "AnonMeProxy 1.0"

function update_sys() {

	echo

	echo "This will update and upgrade all your system"

	echo

	echo "Do you want to? (y/n)"

	echo

	read -r truesys

	if [ "$truesys" = "y" ]; then

		echo "Updating and upgading your system...."

		echo
		
		sudo apt-get update && sudo apt upgrade
		
		clear
		
			if [ $? -eq 0 ]; then
		        	
		        	echo "System updated and upgraded successfully"
		        	
		        	echo
		   	
		   	else
		        	
		        	echo "Failed to update and upgrade your system"
		    
		        	
		        	exit 1
		    	fi
	
	else
		
		echo "Ok"
		
		echo
	
	fi

}	

update_sys

function proxychains_verify() { 

	echo

	echo "Verifying if you have proxychains installed..."

	if command -v proxychains >/dev/null 2>&1; then
	
	    echo
	    
	    echo "proxychains is installed on your system."
	
	else
	    
	    echo
	    
	    echo "proxychains is not installed on your system."
	    
	    echo
	   
	    echo "You need to install proxychains to continue. Do you want to install it now? (y/n)"
	   
	    echo
	    
	    read -r trueinstallproxy
	    
	    if [ "$trueinstallproxy" = "y" ]; then
		   
		    sudo apt install -y proxychains
		    
		    
		    if [ $? -eq 0 ]; then
		       
		        echo "proxychains successfully installed."
		   
		    else
		        
		        echo "Failed to install proxychains."
		       
		        exit 1
		    
		    fi
	   
	    else
	        
	        echo "If you don't install proxychains, you can't continue!"
	        
	        exit 1
	    
	    fi
	
	fi

}

proxychains_verify