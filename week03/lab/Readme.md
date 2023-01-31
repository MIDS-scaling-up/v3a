# Lab 3
DETR in action

## Provision an Ubuntu Desktop VM
This could be local or in the Cloud. Assuming you already have one, just start it up. The main disk needs to be 35GB or larger (can be changed in VM settings)

### Ensure Docker is installed
Your local VM should have Docker pre-installed, so there's nothing to do here. Else, install docker as we discussed in [section 1](https://github.com/MIDS-scaling-up/v3a/tree/master/week01/hw)

### Ensure desktop is installed
Your local VM comes with Ubuntu desktop, so nothing to do here. Else, install it, e.g. 
```
# become root
apt update
apt install -y ubuntu-desktop tightvncserver gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
```
### Configure desktop if not configured (cloud only)
We are using VNC here and loosely following [this guide](https://ubuntu.com/tutorials/ubuntu-desktop-aws):
```
vncserver:1
```
Now edit ~/.vnc/xstartup and add this
```
#!/bin/sh

export XKL_XMODMAP_DISABLE=1
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey

vncconfig -iconic &
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal &
```
Now restart vncserver
```
vncserver -kill :1

vncserver -geometry 1920x1080 :1
```
### Connect to desktop (cloud only)
Use remmina or screensharing for mac, connect to port 5901. (verify that you have an inbound rule for connectivity into port 5901 within the security group that is controlling your instance) Open up a terminal and enter ```xhost +``` to allow new X windows.
If the above does not work, use a [VNC Client](https://www.realvnc.com/en/connect/download/viewer/) and connect to your desktop (54.173.249.104:1 or ec2-54-173-249-104.compute-1.amazonaws.com:1) notice that those IP addresses are an example, your case would be different values).

### Set up the code
```
# become root
mkdir -m 777 /data
cd /data
git clone https://github.com/MIDS-scaling-up/v3a
cd /data/v3a/week03/lab
# build Docker image (this will take a few minutes)
# IF YOU ARE ON An APPLE HW (not Intel) MAC, please edit the Dockerfile.pt by using this line
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/aarch64-linux-gnu/
docker build -t pt -f Dockerfile.pt . 
# if it takes too long, just pull the ready image (x86 only), e.g. 
docker pull w251/detr
docker tag w251/detr pt
# Please note that this image is x86 only. If you are on an an Apple hardware Mac you will need to build.
```
### Download a video clip for processing
For instance, try this URL: https://www.nps.gov/media/video/view.htm?id=5B11A65B-2E51-4377-9E52-367426BAE6A1
### Run the code
```
sh run_pt.sh
# now inside the container
cd /data/v3a/week03/lab
# edit detr.py and add the downloaded clip filename to the feed variable.. 
# if you are on a local VM in a Mac, use 1 as your feed.
# also, edit the device variable if you are running on CPU..
python3 detr.py
```
