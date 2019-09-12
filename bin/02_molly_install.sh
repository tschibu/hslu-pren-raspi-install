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

##
# Base OS Update
##

echo "[INFO] [1.1] : Updating Base System OS"
sudo apt-get update && sudo apt-get upgrade -y
# fixing broken deps, just in case
#apt --fix-broken install -y

echo "[INFO] [1.2] : Remove unnessecary stuff"
# Remove unnessecary stuff
sudo apt-get autoremove -y
sudo apt-get purge -y wolfram-engine
sudo apt-get purge -y libreoffice*
sudo apt-get clean

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

# check if virtualenv is set
if [ ! ${VIRTUAL_ENV} ] ; then
    echo "${red}[ERROR] virtualenv is not set correctly!"
    exit 1
fi

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

echo "[INFO] [3.4.1] : Installing prerequisites for all the AI Tools"

AI_PACKAGES="python-numpy python-scipy libzmq-dev libblas-dev liblapack-dev gfortran"

sudo apt-get install ${AI_PACKAGES} -y

echo "[INFO] [3.4.2] : Installing Tensorflow (pi3 = ~20min / pi3 = ~5min /)"

pip install --upgrade tensorflow

echo "[INFO] [3.4.3] : Installing KERAS (pi3 = ~90min / pi4 = ~60min)"

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
sudo apt-get install build-essential cmake git unzip pkg-config -y

# Libraries Image and Video
sudo apt-get install libjpeg-dev libpng-dev libtiff-dev -y
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev v4l-utils -y
sudo apt-get install libgtk2.0-dev libcanberra-gtk* -y
sudo apt-get install libxvidcore-dev libx264-dev libgtk-3-dev -y

# numerical optimization packages
sudo apt-get install libjasper-dev libopenblas-dev libatlas-base-dev libblas-dev python2.7-dev -y
sudo apt-get install liblapack-dev gfortran -y
sudo apt-get install gcc-arm* -y

# python packages
sudo apt-get install python3-dev python3-numpy -y
sudo apt-get install python-dev python3-pip python-numpy -y

# addon
sudo apt-get install libtbb2 libtbb-dev libdc1394-22-dev -y
sudo apt-get install protobuf-compiler -y

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
make -j1
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