# !/bin/bash
# Script created by mescu

echo "https://twitter.com/mescu"
echo "https://github.com/mescu"
echo "AnonMeProxy 0.1"
echo

update_sys() {
    echo
    echo "This will update and upgrade your system."
    echo "Do you want to proceed? (y/n)"
    read -r truesys

    if [[ "$truesys" == "y" ]]; then
        echo "Updating and upgrading your system..."
        sudo apt-get update && sudo apt-get upgrade -y
        
        if [ $? -eq 0 ]; then
            echo "System updated and upgraded successfully."
        else
            echo "Failed to update and upgrade your system."
            exit 1
        fi
    else
        echo "Operation cancelled."
    fi
}

proxychains_verify() {
    echo
    echo "Verifying if proxychains is installed..."

    if command -v proxychains >/dev/null 2>&1; then
        echo "Proxychains is already installed on your system."
    else
        echo "Proxychains is not installed on your system."
        echo "Do you want to install it now? (y/n)"
        read -r trueinstallproxy

        if [[ "$trueinstallproxy" == "y" ]]; then
            echo "Installing proxychains..."
            sudo apt-get install -y proxychains

            if [ $? -eq 0 ]; then
                echo "Proxychains successfully installed."
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

update_sys
proxychains_verify
