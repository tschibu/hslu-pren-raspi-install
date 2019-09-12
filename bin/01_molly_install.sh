#########################################
## Molly Raspberry Pi Installer Script ##
##                                     ##
##  use Base Image Stretch Lite        ##
##  with or without desktop            ##
##                                     ##
#########################################

#Colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
cyan=`tput setaf 6`
reset=`tput sgr0`

echo "[INFO] [1] : add ssh-key to connect password-less"
mkdir -p $HOME/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEyBmR9nxhTC3cCyTJsa4JfwtJkaZeIAhhTZCDRhLo1V2WwctJN5MITkq9x9jfjEVzjJMe5xo8xIc1JFdq7JRa3CtviazkQSUkReOhB5Wlq8eKkP832pyo45lh+PT7NhtZsL/DU1/j1tPQPmtB62hexh24FySsxILEsh2oOmbSkwsK01Af4nvJy2zYerr4oB6miQiSFa/kXkfbuXQzXtNX2dAk/BVSpFSiUMwwyxQiPAAGdn7SSC4S13Y0RluUY+jPytX+Pl6/uiBKNQ7PJcvhQTSOHhdN/zoghbDl0VTQPvajgIOdrdESX0jhkc6IHSro6gFwA19aI5LoRnDMa/jZ tschibu" > $HOME/.ssh/authorized_keys

# TODO
# NEW_PASS=`echo "molly" | md5sum | awk '{ print $1 }'`
# b5b81f95350ebab4a6cb590b35f2727a
# sudo bash -c 'echo pi:${NEW_PASS} | chpasswd'
# unset ${NEW_PASS}

echo "${yellow}========================================================${reset}"

# motd
sudo cp -f molly_dynmotd.sh /usr/local/bin/dynmotd
sudo chmod +x /usr/local/bin/dynmotd
echo "[INFO] [2] : add motd"
echo "" >> ~/.profile
echo 'dynmotd' >> ~/.profile
dynmotd
sudo bash -c 'echo "" > /etc/motd'

# locale
sudo sed -i 's/en_GB.UTF-8 UTF-8/# en_GB.UTF-8 UTF-8/g' /etc/locale.gen
sudo sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sudo bash -c 'echo -e "LANG=en_US.UTF-8" > /etc/default/locale'
sudo bash -c 'echo -e "LC_ALL=en_US.UTF-8" >> /etc/default/locale'
sudo bash -c 'echo -e "LANGUAGE=en_US.UTF-8" >> /etc/default/locale'

sudo locale-gen en_US.UTF-8
sudo update-locale en_US.UTF-8

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

echo "[INFO] [3] : reboot"
sudo reboot now