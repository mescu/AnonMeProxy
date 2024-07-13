# !/bin/bash
# Script created by mescu

update_sys() {
    echo
    echo "This will update and upgrade your system."
    echo "Do you want to proceed? (y/n)"
    read -r truesys

    if [ "$truesys" == "y" ]; then
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

        if [ "$trueinstallproxy" == "y" ]; then
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

check_proxy() {
    echo
    echo "Enter the proxy details (format: protocol://ip:port):"
    read -r proxy_details

    protocol=$(echo "$proxy_details" | awk -F '://' '{print $1}')
    ip_port=$(echo "$proxy_details" | awk -F '://' '{print $2}')
    ip=$(echo "$ip_port" | awk -F ':' '{print $1}')
    port=$(echo "$ip_port" | awk -F ':' '{print $2}')

    echo "Checking if the IP is accessible..."
    if ping -c 2 "$ip" >/dev/null; then
        echo "IP is accessible. Now adding the proxy to the configuration..."
        add_proxy "$protocol $ip $port"
    else
        echo "The IP is not accessible."
    fi
}

add_proxy() {
    proxy_details=$1
    echo "Do you want to add the proxy to the proxychains configuration? (y/n)"
    read -r addproxy

    if [ "$addproxy" == "y" ]; then
        sudo sh -c "echo '$proxy_details' >> /etc/proxychains.conf"
        if [ $? -eq 0 ]; then
            echo "Proxy added to proxychains configuration successfully."
        else
            echo "Failed to add proxy to proxychains configuration."
        fi
    else
        echo "Operation cancelled."
    fi
}

proxy_ut() {
    echo
    echo "Select an option to use AnonMeProxy:"
    echo "1) Open Firefox with AnonMeProxy"
    echo "2) Use Nmap with AnonMeProxy"
    echo "3) Run a custom command with AnonMeProxy"
    read -r proxyut

    case $proxyut in
        1)
            echo "Opening Firefox with AnonMeProxy..."
            proxychains firefox www.google.com
            ;;
        2)
            echo "Enter the Nmap command:"
            read -r nmap_command
            echo "Running Nmap with AnonMeProxy..."
            proxychains nmap $nmap_command
            ;;
        3)
            echo "Enter the custom command to run with AnonMeProxy:"
            read -r custom_command
            echo "Running custom command with AnonMeProxy..."
            proxychains $custom_command
            ;;
        *)
            echo "Invalid option. Exiting."
            exit 1
            ;;
    esac
}

proxychains_logo() {
    clear
    echo -e "\e[32m    
        _______            
      /\       \           
     /()\   ()  \          
    /    \_______\         
    \    /()     /         
     \()/   ()  /          
      \/_____()/
  
    AnonMeProxy 0.1\e[0m"
    
    echo
    echo "https://twitter.com/mescu"
    echo "https://github.com/mescu"
    echo "https://www.linkedin.com/in/mescu/"
    echo
}

update_sys
proxychains_logo
proxychains_verify
check_proxy
proxy_ut
