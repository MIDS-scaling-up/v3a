# Lab 3
DETR in action

## Provision a VM
This could be local or in the Cloud.

### Ensure Docker is installed
If the image comes with Docker pre-installed, there's nothing to do here. Else, install docker as we discussed in [section 1](https://github.com/MIDS-scaling-up/v3a/tree/master/week01/hw)

### Ensure desktop is installed
If the image comes with Ubuntu desktop, nothing to do here. Else, install it, e.g. 
```
# become root
apt update
apt install -y ubuntu-desktop tightvncserver gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
```
### Configure desktop if not configured
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
### Connect to desktop
Use remmina or screensharing for mac, connect to port 5901. Open up a terminal and enter ```xhost +``` to allow new X windows.
If the above does not work, use a [VNC Client](https://www.realvnc.com/en/connect/download/viewer/) and connect to your desktop (54.173.249.104:1 or ec2-54-173-249-104.compute-1.amazonaws.com:1) notice that those IP addresses are an example, your case would be different values).

### Set up the code
```
# become root
mkdir -m 777 /data
cd /data
git clone https://github.com/MIDS-scaling-up/v3a
cd /data/v3a/week03/lab
# build Docker image (this will take a few minutes)
docker build -t pt -f Dockerfile.pt . 
```
### Download a video clip for processing
For instance, try this URL: https://www.nps.gov/media/video/view.htm?id=5B11A65B-2E51-4377-9E52-367426BAE6A1
### Run the code
```
sh run_pt.sh
# now inside the container
cd /data/v3a/week03/lab
# edit detr.py and add the downloaded clip filename to the feed variable
python3 detr.py
```
