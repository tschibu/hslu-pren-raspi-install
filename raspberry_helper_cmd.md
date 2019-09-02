# TA.Produktentwicklung 2 FS 1901 

PREN (Produktentwicklung) - HSLU - Team 1

# Shutdown molly
```
^C => control + C
```

# Deployment

Run `deploy.sh` to incrementally deploy to a remote ssh host using rsync. By default this is `pi@mollyvision` and the folder `~/deployment`. Edit the variables at the top of file if you want to change this.

Run `deploy.sh complete` to delete the contents of the deployment folder first before deploying. Be careful with this, especially when reconfiguring the deployment folder/host.

## Boot Logs
Um zu sehen wann das Pi zuletzt gebootet hat folgender command ausführen.
```bash
grep -a "Booting" /var/log/messages | tail -3
```

# Display image via ssh

1. install x11 GUI (for Mac us https://www.xquartz.org and for Windows use the normal X.Org App https://www.x.org/wiki/)
2. check if `feh` is installed on raspberry pi

```bash
mollyvision) pi@mollyvision2:~ $ which feh
/usr/bin/feh
(mollyvision) pi@mollyvision2:~ $
```

If the package `feh` is missing, you can install it via cli:
```bash
sudo apt-get update
sudo apt-get install feh
```

3. start a ssh session with X11 connection forwarding (capital X!)
```bash
UM00889:~ tluscre1$ ssh -X pi@mollyvision2
```
It can also be the parameter -x (lowercase X) or -Y (capital)

4. open an image
```bash
(mollyvision) pi@mollyvision2:~ $ feh test.jpg
```

# Show the version from Raspbian

```bash
(mollyvision) pi@mollyvision2:~ $ /usr/bin/lsb_release -a
No LSB modules are available.
Distributor ID:	Raspbian
Description:	Raspbian GNU/Linux 9.4 (stretch)
Release:	9.4
Codename:	stretch
```

# Hotspot auf dem PI erweitern
```bash
pi@mollyvision:/etc/wpa_supplicant $ cat wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=CH

network={
	ssid="Do More Max"
	psk="remo88//"--system-site-packages
}
pi@mollyvision:/etc/wpa_supplicant $
```

# Pi suchen
```bash
nmap -p22 192.168.43.1-254
```

Pi suchen via Hotspot iPhone
```
nmap -p22 172.20.10.0-254
```

```bash
-> 172.20.10.5 = mollyvision
 --> pi@mollyvision => Emanuel
```

```bash
-> 172.20.10.10 = mollyvision2
pi@mollyvision => Remo
```


# Backing up / Restore - Raspberry Pi SD card
 
## Cloning Using the Command Line (CLI)

### Step 1 - Insert & Locate your SD card

Insert the Raspi-SD card to the SD Slot on your Device and start a Terminal
```bash
$ diskutil list
```

Output:
```bash
$ diskutil list
/dev/disk0 (internal):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                         1.0 TB     disk0
   1:                        EFI EFI                     314.6 MB   disk0s1
   2:                 Apple_APFS Container disk1         1.0 TB     disk0s2

/dev/disk1 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +1.0 TB     disk1
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            826.1 GB   disk1s1
   2:                APFS Volume Preboot                 44.4 MB    disk1s2
   3:                APFS Volume Recovery                522.7 MB   disk1s3
   4:                APFS Volume VM                      2.1 GB     disk1s4

/dev/disk2 (disk image):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        +2.1 TB     disk2
   1:                        EFI EFI                     209.7 MB   disk2s1
   2:                  Apple_HFS Time Machine Backups    2.1 TB     disk2s2

/dev/disk3 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *15.9 GB    disk3
   1:             Windows_FAT_32 boot                    45.9 MB    disk3s1
   2:                      Linux                         15.9 GB    disk3s2

```

Identify your SD Card (look under NAME and SIZE to verify correct volume).
In my example, the SD Card is /dev/disk3.


### Step 2 - Cloning Your SD Card

In Terminal, enter the following command to create a disc image (.dmg) of your SD Card.
```bash
sudo dd if=/dev/disk3 of=~/Documents/Studium.Local/PREN/20190414_Pi.img
```

There is no progress indicator for the `dd` command, but you can use the shortcut `CTRL+t` to see the process, 
load and speed from the copy pid.

After around 15 minutes (depend on your computer) you will see the images:

```
$ ls -l ~/Documents/Studium.Local/PREN/20190414_Pi.img
-rw-r--r--  1 root  1437665408  15931539456 Apr 14 11:30 /Users/tluscre1/Documents/Studium.Local/PREN/20190414_Pi.img
```

## Restoring Using the Command Line (CLI)

### Step 1 - Locate the SD Card to be Restored

Insert your blank / used / nuked SD Card and check with the command `diskutil list` which mount point are used for your
SD Card.
```bash
M00889:doc tluscre1$ diskutil list
/dev/disk0 (internal):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                         1.0 TB     disk0
   1:                        EFI EFI                     314.6 MB   disk0s1
   2:                 Apple_APFS Container disk1         1.0 TB     disk0s2

/dev/disk1 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +1.0 TB     disk1
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            842.3 GB   disk1s1
   2:                APFS Volume Preboot                 44.4 MB    disk1s2
   3:                APFS Volume Recovery                522.7 MB   disk1s3
   4:                APFS Volume VM                      2.1 GB     disk1s4

/dev/disk2 (disk image):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        +2.1 TB     disk2
   1:                        EFI EFI                     209.7 MB   disk2s1
   2:                  Apple_HFS Time Machine Backups    2.1 TB     disk2s2

/dev/disk3 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *15.9 GB    disk3
   1:             Windows_FAT_32 boot                    45.9 MB    disk3s1
   2:                      Linux                         15.9 GB    disk3s2
```

In my case it is the Disk `/dev/disk3`

### Step 2 - unmount

```bash
diskutil unmountDisk /dev/disk3
```

### Step 3 - format the SD Card
When you have identified your SD Card, enter the following command to format it as FAT32.
In my case it’s /dev/disk3.

```bash
sudo newfs_msdos -F 32 /dev/disk
```

### Step 4 - Restore from a Cloned Disc Image

Ensuring that you identify the correct destination disc!

```bash
sudo dd if=~/Documents/Studium.Local/PREN/20190414_Pi.img of=/dev/disk3
```

# 
Building Python
---------------

Because Python 3.6 is not yet available in the standard rasbian repos,
we built it manually:

    cd ~/Python-3.6.7/ && ./configure --enable-optimizations \
      && make && sudo make install

It will try to run a long test suite after building with make. You can
just abort it or find the ./configure flag to disable it.


Python virtualenv
-----------------

Run `source virtualenvs/mollyvision/bin/activate` to load the python3
virtualenv.

It was created using the command:
 
    virtualenv -p /usr/local/bin/python3.6 --system-site-packages \
      ~/virtualenvs/mollyvision

And it uses the own compiled python. `--system-site-packages` was passed
for OpenCV to be acessible
after installing it to the system. Else some manual hackery (e.g. copying
some files around) would be necessary
in order for python to find the opencv module & shared libraries it needs.


Building OpenCV
---------------

Make sure to be in the virtualenv _before_ you build opencv for the python
bindings to be found. You should see in your prompt something like:

    (mollyvision) pi@mollyvision:~ $ 

To build, run `opencv-3.4.3/build/cmake-command.sh`, maybe set other
options with the -D flags inside the file then delete all files except the
`cmake-command.sh`, because CMake caches it's result after being run once.

Be aware that when you've created a new virtualenv that numpy should
be installed into it in order for `cmake-command.sh` to pick up the
python correctly.

Then run `make && sudo make install` in `opencv-3.4.3/build` to build and 
install OpenCV.

Complete build instructions:

https://www.pyimagesearch.com/2018/09/26/install-opencv-4-on-your-raspberry-pi/

Using RS232
-----------

The Port first needs to be enabled via `sudo raspi-config`. 5 Interface options. Disable the linux console over serial, but enable the serial port.


There is a python module called 'pyserial', install it via pip into the virtualenv.

Then open and read/write to the port as follows.


```
import serial
s = serial.Serial('/dev/ttyS0', 9600) # baud rate = 9600, default parity settings
s.read(10) # read 10 byte, blocking
s.write(b"some bytes") # write some bytes b"" is required because unicode is not supported
```

Do the same thing on the other side. I did it with python as well on my linux machine and the USB to RS232 converter appeared as /dev/ttyUSB0.

Using the Raspberry PI Cam
--------------------------

Make sure it's connected correctly and it's connected the right way arround! Then run ``sudo raspi-config``, go to Interfacing Options and enable the camera there. Then reboot.
It should work then. You can use the RapberryPi Camera command line tools like `raspistill` to check whether the camera works.


# Install Tesseract OCR 4 (4.0.0) for Raspberry Pi 3

https://github.com/thortex/rpi3-tesseract

## Prerequisite
```bash
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt install git
```

## How to Install

```bash
git clone https://github.com/thortex/rpi3-tesseract.git
cd rpi3-tesseract/release
./install_requires_related2leptonica.sh
./install_requires_related2tesseract.sh
./install_tesseract.sh
```

## How to Build

```bash
cd setup
./019_checkinstall.sh
./070_tesseract.sh
```

# tesseract model

One from Github:
- https://github.com/Shreeshrii
model only with digits:
- https://github.com/Shreeshrii/tessdata_shreetest

More infos: 
https://github.com/Shreeshrii/tessdata_shreetest/issues/1#issuecomment-425947492


With Tenserflow:
Online: https://digit-recognition.ixartz.com


MNIST Database:
http://yann.lecun.com/exdb/mnist/

https://dev.to/search?q=digits%20tenserflow


# Webserver commands

## set speed to a specified speed

via curl:

```
curl -v http://172.20.10.10:8000/?setspeed:100\;
```

via Browser (not recommended)
```
http://172.20.10.10:8000/?setspeed:100;
```

## stop command
```
http://172.20.10.10:8000/?setspeed:0\;
curl http://192.168.1.117:8000/?setspeed:0\;
```

## to pass the POST check
```
http://172.20.10.10:8000/?test
curl http://192.168.1.117:8000/?test
```

## start
```
http://192.168.1.117:8000/?start
```


## Stop Speed
```
StopSpeed: 80 => Halt Zeit Berechnung 6000
StopSpeed: 200 => Halt Zeit Berechnung 1000
```

# dist_bhatt
```
1 = Keine Übereinstimmung
0 = Perfekte Übereinstimmung
``

# stop_distance_value
stop_distance_value => je höher 
(5200/40)/80