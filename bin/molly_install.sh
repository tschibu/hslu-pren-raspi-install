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
#echo "${red}red text ${green}green text${reset}"

# Global config
export OPENCV_VERSION=4.1.1
export PYTHON_VERSION=3.6.8

# Expand FS
# sudo raspi-config --expand-rootfs

# Pi name
# -> do it manually
# echo "[INFO] Give this computer a name.."
# PI_HOSTNAME="molly"
# export PI_HOSTNAME="mollyplusplus" # only [a-z] and [0-9]
# echo "[INFO] Your Raspberry Pi will rename to ${PI_HOSTNAME}"
# sudo sed -i "s/raspberrypi/$PI_HOSTNAME/g" /etc/hosts
# sudo sed -i "s/raspberrypi/$PI_HOSTNAME/g" /etc/hostname

# mit GUI
# sudo apt-get install xrdp

# Check if sudo is used
# why u need this?
#if [ "$(id -u)" != 0 ]; then
#  echo "${red}[ERROR] Sorry, you need to run this script with sudo${red}"
#  echo "${red}[ERROR[ use type >>sudo !!<<"
#  exit 1
#fi


# motd
sudo cp -f molly_dynmotd.sh /usr/local/bin/dynmotd
sudo chmod +x /usr/local/bin/dynmotd
echo "[INFO] [0] : add motd"
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

##
# Base OS Update
##

echo "[INFO] [1.1] : Updating Base System OS"
sudo apt-get update && sudo apt-get upgrade -y
# fixing broken deps, just in case
#apt --fix-broken install -y

echo "[INFO] [1.2] : Remove unnessecary stuff"
# Remove unnessecary stuff
sudo apt-get purge -y wolfram-engine
sudo apt-get purge -y libreoffice*
sudo apt-get clean
sudo apt-get autoremove -y

echo "[INFO] [1] : Completed"
echo "[INFO] ${yellow}========================================================${reset}"


###
#
# Defining OS-Packages 2 be installed
#
###
echo "[INFO] [2] : Python & Installing Linux Packages"
echo "[INFO] [2.1] : Installing Python 3.6 on Raspbian"

PYTHON_PACKAGES="build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev"

echo "[INFO] [2.1] : Installing Linux Packages"
echo "[INFO] [2.1] : Package List: "
echo "[INFO] $PYTHON_PACKAGES"

echo "${cyan}========================================================${reset}"

sudo apt-get install $PYTHON_PACKAGES -y

wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz
tar xf Python-${PYTHON_VERSION}.tar.xz
cd Python-${PYTHON_VERSION}
./configure
make -j -l 4
sudo make altinstall
cd ..
sudo rm -r Python-${PYTHON_VERSION}
rm Python-${PYTHON_VERSION}.tar.xz

echo "[INFO] [2] : python installed completed"

PACKAGES="cmake curl e2fslibs build-essential cifs-utils g++ gcc gcc-4.9-base gcc-5-base gcc-6-base git htop initramfs-tools kmod libapt-inst2.0 libapt-pkg5.0 libc-bin libc6 libdbus-1-3 libgnutls30 python3-pip python3-rpi.gpio python3-smbus wiringpi python3-picamera python-pip espeak python3-scipy python3-h5py libhdf5-dev hdf5-tools libblas-dev liblapack-dev"

echo "[INFO] [2] : Installing Linux Packages"
echo "[INFO] [2] : Package List: "
echo "[INFO] $PACKAGES"

echo "${cyan}========================================================${reset}"

sudo apt-get install $PACKAGES -y

echo "[INFO] [2] : Completed"
echo "${yellow}========================================================${reset}"

###
#
# Defining Python-PIP Packs 2 be installed
#
###

###
#
# first upgrade setuptools
#
echo "[INFO] [3] : upgrading pip3 setuptools"
sudo pip3 install --upgrade setuptools

###
#
# install virtualenv und create a venv
#
echo "[INFO] [3.1.1] : install pip3 virtualenv"
sudo pip3 install virtualenv

# clean up
sudo rm -rf ~/.cache/pip

echo "[INFO] [3.1.2] : create virtualenv for molly"
mkdir -p ~/virtualenvs/
virtualenv -p /usr/local/bin/python3.6 ~/virtualenvs/molly

echo "[INFO] [3.1.5] : add env-loading to ~/.profile"
echo "" >> ~/.profile
echo 'echo "[INFO]: loading molly virtualenv"' >> ~/.profile
echo 'source "$HOME/virtualenvs/molly/bin/activate"' >> ~/.profile


echo "[INFO] [3.1.4] : activate virtualenv for molly"
source "$HOME/virtualenvs/molly/bin/activate"

PIPPACKAGES="board rpi-ws281x RPi.GPIO smbus2 configparser urllib3 Werkzeug pyserial numpy termcolor h5py transitions mock" #no picam and no pillow (v6 broken)

echo "[INFO] [3.2] : Installing Python Packs over (pip)"
echo "[INFO] [3.2] : PIP List: "
echo "[INFO] $PIPPACKAGES"

pip install $PIPPACKAGES


echo "${yellow}========================================================${reset}"

echo "[INFO] [3.3] : Enlarge SWAP to 2Gibi"

# Enlarging the Swap File, else Pi will explode
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

echo "${yellow}========================================================${reset}"


echo "[INFO] [3.4] : Installing Tensorflow (~20min)"

pip install --upgrade tensorflow

echo "[INFO] [3.5] : Installing KERAS (~90min)"

pip install keras

echo "${yellow}========================================================${reset}"


echo "[INFO] [3.6] : Installing Pillow 5.4.1 (pip) because v6 has broken dependencies"

pip install Pillow==5.4.1

echo "[INFO] [3.7] : Completed"
echo "${yellow}========================================================${reset}"
echo "[INFO] ...going to sleep for 30s, please check the Log above"
sleep 30s
echo "${yellow}========================================================${reset}"



###
#
# Defining Special Packages 2 be installed (opencv, Tesseract...)
#
###

echo "[INFO] [4] : Installing Special Packages"
echo "[INFO] [4] : Special Packages List: "

echo "[INFO] [4.1] : Opencv ${OPENCV_VERSION}"

echo "[INFO] [4.1.1] : Install Opencv ${OPENCV_VERSION} from Git"

#Commands for Opencv 3.4.4
#prerequisits & Dependencies
#apt install libatlas3-base libsz2 libharfbuzz0b libtiff5 libjasper1 libilmbase12 libopenexr22 libilmbase12 libgstreamer1.0-0 libavcodec57 libavformat57 libavutil55 libswscale4 libqtgui4 libqt4-test libqtcore4 -y
# main opencv 3.4
#pip3 install opencv-contrib-python

# CV4: Build Tools
sudo apt-get install build-essential cmake unzip pkg-config -y

# Libraries Image and Video
sudo apt-get install libjpeg-dev libpng-dev libtiff-dev -y
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev -y
sudo apt-get install libxvidcore-dev libx264-dev -y

# numerical optimization packages
sudo apt-get install libatlas-base-dev gfortran python3-dev python2.7-dev -y

# Download and Install OpenCV

# #Download opencv
wget -O opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
# Download opencv additional libraries
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip

unzip -qq opencv.zip
unzip -qq opencv_contrib.zip

mv opencv-${OPENCV_VERSION} opencv
mv opencv_contrib-${OPENCV_VERSION} opencv_contrib

cd opencv
mkdir build
cd build

# just in case
sudo apt-get install cmake -y

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=~/install/opencv_contrib/modules \
    -D PYTHON_EXECUTABLE=~/virtualenvs/molly/bin/python \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D BUILD_EXAMPLES=OFF ..



echo "${yellow}==========================Start CV Compilation==============================${reset}"
# TODO
make -j4
echo "${yellow}==========================Completed CV Compilation==============================${reset}"

sudo make install
sudo ldconfig

cd ..
cd ..
#cleanup opencv install
sudo rm -r opencv
sudo rm -r opencv_contrib

rm opencv.zip
rm opencv_contrib.zip

echo "[INFO] [4.2.2] Link OpenCV 4 into your Python 3 virtual environment"
# Rename python bidings
PY3_BINDINGS_PATH=`find /usr/local -name "cv2.cpython-*-arm-linux-gnueabihf.so"`
CV2_DIR_NAME=`dirname ${PY3_BINDINGS_PATH}`
CV2_FILE_NAME=`basename ${PY3_BINDINGS_PATH}`
sudo mv ${CV2_DIR_NAME}/${CV2_FILE_NAME} ${CV2_DIR_NAME}/cv2.so

# Link the bindings to your virtual environment
cd `find ~/virtualenvs/molly -name "site-packages"`
ln -s ${CV2_DIR_NAME}/cv2.so cv2.so
ls -l cv2.so

unset ${PY3_BINDINGS_PATH}
unset ${CV2_DIR_NAME}
unset ${CV2_FILE_NAME}

cd ~/install

echo "[INFO] [4.2.3] OpenCV 4 finished.. finally!"

echo "${yellow}========================================================${reset}"

echo "[INFO] [4.2] : Tesseract 4"
echo "[INFO] [4.2.1] : install tesseract 4 from git"

#For Tesseract 3.04 version:
#apt-get install tesseract-ocr -y

# Prerequisits
sudo apt-get install automake g++ git libtool libleptonica-dev make pkg-config -y
sudo apt-get install --no-install-recommends asciidoc -y

git clone --depth 1 https://github.com/tesseract-ocr/tesseract.git 
cd tesseract/
./autogen.sh
./configure

echo "${yellow}==========================Start Tesseract Compilation==============================${reset}"
# TODO
make -j4 
echo "${yellow}==========================Completed Tesseract Compilation==============================${reset}"

sudo make install
sudo ldconfig
tesseract --version
cd ..

# cleanup
sudo rm -r tesseract

echo "${yellow}========================================================${reset}"

echo "[INFO] [4] : Shrinking SWAP to 256"

#Shrinking the Swap File again, else SD Card will implode
sudo sed -i 's/CONF_SWAPSIZE=2048/CONF_SWAPSIZE=256/g' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

echo "${yellow}========================================================${reset}"

# Add digits traineddata
echo "[INFO] [4.2.3] : create folder for TESSDATA_PREFIX models"`/sbin/ifconfig wlan0 | grep inet | awk -F" " {'print $2'} | head -1`
mkdir -p /home/pi/tesseract/tessdata/

echo "[INFO] [4.2.3] : add TESSDATA_PREFIX to profile"
echo "" >> ~/.profile
echo "export TESSDATA_PREFIX=$HOME/tesseract/tessdata/" >> ~/.profile

export TESSDATA_PREFIX=$HOME/tesseract/tessdata/

cd ${TESSDATA_PREFIX}
wget https://github.com/Shreeshrii/tessdata_shreetest/blob/master/digits.traineddata
cd -

tesseract --list-langs

echo "[INFO] [4.2.2] : install python tesseract wrapper"
pip install pytesseract

echo "[INFO] [4] : Completed"
echo "${yellow}========================================================${reset}"

##
# Tweaking Operating System
##

# Replace the Existing config.txt file with our version so we have:
# gpu mem reduced | Camera activated | uart

echo "[INFO] [5] : Tweaking OS for molly"
sudo mv /boot/config.txt /boot/config_default.txt
sudo cp -f molly_config.txt /boot/config.txt

echo "[INFO] [5.1] : activate serial (uart) port"
sudo sed -i 's/console=serial0,115200//g' /boot/cmdline.txt


echo "[INFO] [5] : Completed"

echo "[INFO] [6] : add ssh-key to connect password-less"
mkdir -p $HOME/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEyBmR9nxhTC3cCyTJsa4JfwtJkaZeIAhhTZCDRhLo1V2WwctJN5MITkq9x9jfjEVzjJMe5xo8xIc1JFdq7JRa3CtviazkQSUkReOhB5Wlq8eKkP832pyo45lh+PT7NhtZsL/DU1/j1tPQPmtB62hexh24FySsxILEsh2oOmbSkwsK01Af4nvJy2zYerr4oB6miQiSFa/kXkfbuXQzXtNX2dAk/BVSpFSiUMwwyxQiPAAGdn7SSC4S13Y0RluUY+jPytX+Pl6/uiBKNQ7PJcvhQTSOHhdN/zoghbDl0VTQPvajgIOdrdESX0jhkc6IHSro6gFwA19aI5LoRnDMa/jZ tschibu" > $HOME/.ssh/authorized_keys

echo "[INFO] [7] : change pass for user pi"

# TODO
# NEW_PASS=`echo "molly" | md5sum | awk '{ print $1 }'`
# sudo bash -c 'echo pi:${NEW_PASS} | chpasswd'
# unset ${NEW_PASS}

echo "[INFO] [7] : pass changed"

echo "[INFO] [7] : add ssid-network"

sudo cp -f molly_wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf

echo "[INFO] [7] : ssid added."

echo "${yellow}========================================================${reset}"

echo "[INFO] [6] : Cleanup Installations"

#cleanup python stuff
#apt-get --purge remove build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev -y
sudo apt-get autoremove -y
sudo apt-get clean

echo "[INFO] [6] : Completed"

echo "${yellow}========================================================${reset}"

echo "${green}[INFO] [Complete] : Installation is completed!${reset}"
echo "${cyan}[INFO] : You may need to activate UART (Serial) with Raspi-Conf${reset}"
echo "${cyan}[INFO] : OpenCV 4 & Tesseract 4 - ready 2 read some numbers${reset}"
echo "${cyan}[INFO] : Please reboot Pi (sudo reboot now)${reset}"


echo "${yellow}========================================================${reset}"