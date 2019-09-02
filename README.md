# HSLU - PREN - Installscript für Raspberry Pi 4

# Beschreibung RPI Installation 

1. Start mit Clean Image von Raspberry (Raspbian Buster Lite - Minimal image based on Debian Buster)

1.1 Infos

```
diskutil list
diskutil unmountDisk /dev/disk2
sudo dd bs=1m if=path_of_your_image.img of=/dev/disk2 conv=sync
sudo dd bs=1m if=/Users/tluscre1/Documents/Studium.Local/PREN_STAGING/2019-07-10-raspbian-buster-lite.img  of=/dev/disk2 conv=sync
Progress = press Ctrl+T
```

activate ssh
```
touch /Volumes/boot/ssh
cp ~/Documents/Studium.Local/PREN/hslu-pren-raspi-install/config/molly_wpa_supplicant.conf /Volumes/boot/wpa_supplicant.conf
```

disk eject 
```
diskutil eject /dev/disk2
```

username and password
```
user = pi
pass = raspberrypi
```

```
./molly_install.sh > molly_install.log
tail -f molly_install.log
```

2. Auf dem Pi unter "/home/pi" einen Ordner "install" erstellen

3. Ganzen Inhalt dieses Ordners auf Pi "/home/pi/install" kopieren und 'sudo ./rpi_install.sh' starten

3.1. Um ein Log zu erhalten, start mit 'sudo ./rpi_install.sh | tee rpi_install.log'

4. Installation startet und installiert: Updates, Sensor Libraries, OpenCV4, Tesseract4

*Die OpenCV4 Compilation dauert ca 2h, alternativ kann via pip Opencv3.4 installiert werden, das ist precompiled*

5. Manuell noch die Custom Tesseract library für Numbers nachladen

https://github.com/Shreeshrii/tessdata_shreetest


# Install Packages Manually (list not complete!)

## OpenCV 4.1 / 3.4.4


## Tesseract 4

### Prerequisits

Check if not already installed (kapitel in bearbeitung)

    sudo apt-get install g++ # or clang++ (presumably)
    sudo apt-get install autoconf automake libtool
    sudo apt-get install pkg-config
    sudo apt-get install libpng-dev
    sudo apt-get install libjpeg8-dev
    sudo apt-get install libtiff5-dev
    sudo apt-get install zlib1g-dev


## Tesseract 4 Main Installation

Follow these Instructions:

https://github.com/tesseract-ocr/tesseract/wiki/Compiling-%E2%80%93-GitInstallation


## Sensor Libraries


## Web Server

# Change Permissions





