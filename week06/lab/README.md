

Part one of this lab will be done on a local Ubuntu VM.  If you'd like to run with a Jetson device, see old version of this lab.  Note, you may need to adjust some commands to fit the latest lastest version of Jetpack that is available for your device.

## VM Setup
Once you have your VM created, you'll need to make sure gstreamer is installed.  From a terminal, run the following command:
```
sudo apt-get install -y python3-dev python3-pip  python3-opencv vim-tiny  libopencv-dev git python3-gst-1.0  gstreamer1.0 gstreamer1.0-tools gstreamer1.0-plugins-base-apps gstreamer1.0-plugins-base  gstreamer1.0-plugins-good  gstreamer1.0-plugins-bad  gstreamer1.0-plugins-ugly gstreamer1.0-x  gstreamer1.0-libav
```

## Part 1: GStreamer

In this part of the lab, you'll explore using GStreamer, primally via the gst-launch-1.0 tool.  

While not covered here, audio is also supported.  See the Gstreamer documentation for examples.
 

### Basics
At its core GStreamer uses pipelines, where a pipelie is a list of elements separated by exclamation marks (!). 

An element can be thought of as a black box with one or more pads, the element's interface to the outside world; data comes in on one side, the data element does something with it and something else comes out the other side.  There are 3 types of elements, source, filter and filter-like, and sink elements.

Source elements generate data for use by a pipeline, for example reading from from a camera or a file. 

![Filter element](images/src-element.png)


Filters and filter-like elements have both input and outputs pads. They operate on data that they receive on their input (sink) pads, and will provide data on their output (source) pads.


Filter-like elements can have any number of source or sink pads.  For example, a demuxer would have one sink pad and several (1-N) source pads, one for each of the  streams contained in the source format. On the other hand, an decoder will only have one source and sink pads.

![Filter element](images/filter-element.png)


![Filter element](images/filter-element-multi.png)


Finally, sink elements are the end of a pipeline; they accept an input and outout to a display, to disk, etc.

![Filter element](images/sink-element.png)


### Pipelines

The first pipeline will be a simple video test image. 
```
gst-launch-1.0 videotestsrc ! xvimagesink
```

This will display a classic "test pattern". The command is composed of two elements, the videotestsrc and a video sink, xvimagesink.

Running `gst-inspect-1.0 videotestsrc` will provide some additional information on the src and supported properies.  In this case, we are interested in the property `pattern`.
The patterns have an index number and a name, either may be used.  For example both `gst-launch-1.0 videotestsrc pattern=snow ! xvimagesink` and `gst-launch-1.0 videotestsrc pattern=0 ! xvimagesink` produce the same thing.

Explore the various patterns.

The first example demostrated running a single pipeline, but we can do even more.  The following example runs runs two videotestsrc pipelines:
```
gst-launch-1.0 videotestsrc ! xvimagesink videotestsrc pattern=ball ! xvimagesink
```

Edge devices such as the Nvidia Jetson line have their own hardware accellerated plugins.  While not covered in this lab, these plugins can be used to improve the performace of a varity of tasks including encoding, decoding and image transformations.

To use a camera with GStreamer, you mist need to know what is available.  You can get infomration about your available camera or cameras through `gst-device-monitor-1.0` applicaion.

Run `gst-device-monitor-1.0 Video/Source` to see your cameras and their capablities.  For example, my VM has the following:
```
	name  : FaceTime HD Camera
	class : Video/Source
	caps  : video/x-raw, format=YUY2, width=1280, height=720, framerate=30/1
	        video/x-raw, format=YUY2, width=640, height=480, framerate=30/1
	properties:
		object.path = v4l2:/dev/video2
		device.api = v4l2
		media.class = Video/Source
		device.product.id = 65529
		device.vendor.id = 8250
		api.v4l2.path = /dev/video2
		api.v4l2.cap.driver = uvcvideo
		api.v4l2.cap.card = "FaceTime\ HD\ Camera:\ FaceTime\ HD"
		api.v4l2.cap.bus_info = usb-0000:00:03.0-4
		api.v4l2.cap.version = 5.15.39
		api.v4l2.cap.capabilities = 84a00001
		api.v4l2.cap.device-caps = 04200001
		device.id = 33
		node.name = v4l2_input.platform-2300000.pci-pci-0000_00_03.0-usb-0_4_1.0
		node.description = "FaceTime\ HD\ Camera"
		factory.name = api.v4l2.source
		node.pause-on-idle = false
		factory.id = 10
		client.id = 32
		clock.quantum-limit = 8192
		media.role = Camera
		node.driver = true
		object.id = 37
		object.serial = 37
	gst-launch-1.0 pipewiresrc path=37 ! ...


Device found:

	name  : Ryan XS Camera
	class : Video/Source
	caps  : video/x-raw, format=NV12, width=1280, height=720, framerate=60/1
	        video/x-raw, format=NV12, width=1920, height=1080, framerate=60/1
	        video/x-raw, format=NV12, width=1920, height=1440, framerate=60/1
	        video/x-raw, format=NV12, width=640, height=480, framerate=60/1
	properties:
		object.path = v4l2:/dev/video0
		device.api = v4l2
		media.class = Video/Source
		device.product.id = 65529
		device.vendor.id = 8250
		api.v4l2.path = /dev/video0
		api.v4l2.cap.driver = uvcvideo
		api.v4l2.cap.card = "Ryan\ XS\ Camera:\ Ryan\ XS\ Camera"
		api.v4l2.cap.bus_info = usb-0000:00:03.0-3
		api.v4l2.cap.version = 5.15.39
		api.v4l2.cap.capabilities = 84a00001
		api.v4l2.cap.device-caps = 04200001
		device.id = 36
		node.name = v4l2_input.platform-2300000.pci-pci-0000_00_03.0-usb-0_3_1.0
		node.description = "Ryan\ XS\ Camera"
		factory.name = api.v4l2.source
		node.pause-on-idle = false
		factory.id = 10
		client.id = 32
		clock.quantum-limit = 8192
		media.role = Camera
		node.driver = true
		object.id = 39
		object.serial = 61
	gst-launch-1.0 pipewiresrc path=39 ! ...
```
You can see that I have 2 cameras available, each with a different set of capabilities.  

For the rest of the camera based examples, you'll need to use values that work with your actual hardware; I'll be using /dev/video2.

```
gst-launch-1.0 v4l2src device=/dev/video2 ! videoconvert ! xvimagesink sync=false -e
```
In this example, I'm using a `videoconvert`.  This is needed as on my machine, `xvimagesink` does not suppor the image format `YUY2` (howerver `NV12` is). Videoconvert finds a format that xvimagesink as converts as needed.  If no conversion is needed, this is simply a pass through.  If you'd like to see that videoconvert is using, add the `-v` flag to your command.



Take note of the property `sync=false` and the flag `-e`.  Setting sync to false, incoming samples will be played as fast as possible, and the -e flag forces the stream to close before shutting down the pipeline.

Now that we have access to the cameara, we can explore what we can do.  Now the the camera is the limit; if your camera doesn't support 60 FPS and 4K, there is no use asking for it.  

Cameras may support more than one FPS option (mine doesn't but we'll pretend) .

Let's start by asking for 30 FPS.  Note, you'll need to use the` X/1` for framerates. I'm using the specific caps for my camera.
```
gst-launch-1.0 v4l2src device=/dev/video2 ! video/x-raw, format=YUY2, width=1280, height=720, framerate=30/1 ! videoconvert ! xvimagesink sync=false -e
```
Notice that the size of the window as changed.  Now what if we want 30 FPS at 1920x1080?  Let's find out.
```
gst-launch-1.0 v4l2src device=/dev/video2 ! video/x-raw, format=YUY2, width=1920, height=1080, framerate=30/1 ! videoconvert ! xvimagesink sync=false -e
```
and for me, it fails.  If we look above, should be clear why; my camera doesn't support that.  

Let's go the other way and ask for 640x480.
```
gst-launch-1.0 v4l2src device=/dev/video2 ! video/x-raw, format=YUY2, width=640, height=480, framerate=30/1 ! videoconvert ! xvimagesink sync=false -e
```

And works as expected.   Feel free to explore what your camera can do!


Now what can we do with the video?  Let's start with scaling the image.
```
 gst-launch-1.0 v4l2src device=/dev/video2  ! videoscale ! video/x-raw, width=320, height=240 ! videoconvert ! xvimagesink sync=false -e
```
Now we can try converting the image to grey scale
Say we want to see the image in grayscale.
```
gst-launch-1.0 v4l2src device=/dev/video2 ! videoconvert ! video/x-raw,format=GRAY8 ! videoconvert  ! xvimagesink sync=false -e
```
Why is the extra videoconvert needed?  Try:
```
gst-launch-1.0 v4l2src device=/dev/video0 ! video/x-raw,framerate=30/1 ! videoconvert ! video/x-raw,format=GRAY8  ! xvimagesink sync=false -e
```
Fails as we need to make sure the video is in a format that xvimagesink can understand, e.g. BGRx.

We can also do fun things like flip the image:
```
gst-launch-1.0 v4l2src device=/dev/video2 ! videoconvert ! videoflip method=rotate-180 ! videoconvert ! xvimagesink sync=false -e
```

Now let's play with some "special effects".
```
gst-launch-1.0 v4l2src device=/dev/video2 ! videoconvert ! warptv ! videoconvert ! xvimagesink sync=false -e

gst-launch-1.0  videotestsrc ! agingtv scratch-lines=15 ! videoconvert ! xvimagesink -e

```
Inspect both agingtv and warptv to see what other effects can be applied.


Now add some text to the video: 
```
gst-launch-1.0 v4l2src device=/dev/video2 ! videoconvert ! textoverlay text="Hello from GST" valignment=bottom halignment=left font-desc="Sans, 40" ! xvimagesink sync=false -e
```

Now what having an image be routed to more than one window.  This uses tee and queue.
```
gst-launch-1.0 v4l2src device=/dev/video2 ! videoconvert ! queue ! tee name=t t. ! queue ! xvimagesink sync=false t. ! queue ! videoflip method=horizontal-flip ! xvimagesink sync=false -e
```

We can also overlay images.  

```
gst-launch-1.0 videotestsrc pattern=1 ! video/x-raw, framerate=60/1, width=100, height=100 ! compositor name=comp ! videoconvert ! ximagesink    videotestsrc ! video/x-raw, framerate=60/1, width=320, height=240 ! comp.
```
and a more complicated example:
```
gst-launch-1.0 -e compositor name=comp  ! ximagesink sync=false v4l2src device=/dev/video2 ! videoconvert ! videoscale  ! video/x-raw, width=640, height=360 ! comp.sink_0 videotestsrc pattern="snow" ! video/x-raw, framerate=60/1, width=200, height=150 ! comp.sink_1
```

We can also integrate with other programs like OpenCV. Run the command `gst-inspect-1.0 opencv` to see what OpenCV plugins are available.

Try the following
```
gst-launch-1.0 v4l2src device=/dev/video2 ! videoconvert ! facedetect ! videoconvert ! xvimagesink sync=false -e

gst-launch-1.0 v4l2src device=/dev/video2 ! videoconvert ! edgedetect ! videoconvert ! xvimagesink sync=false -e

gst-launch-1.0 v4l2src device=/dev/video2 ! videoconvert ! skindetect ! videoconvert ! xvimagesink sync=false -e
```

GStreamer can be used to stream media (e.g. create your own IP camera) between devices, however to keep things simple, you'll stream from your Jetson to your Jetson.

This will require two shell windows.

In the first window, run the following: 
```
gst-launch-1.0 v4l2src device=/dev/video2 ! video/x-raw, format=YUY2, width=640, height=480, framerate=30/1 ! videoscale ! video/x-raw, format=YUY2, width=320, height=240 ! videoconvert ! x264enc ! h264parse ! rtph264pay config-interval=1 ! udpsink host=127.0.0.1 port=5000 sync=false
```
This starts the "server" broadcasting the packets (udp) to the IP Address 127.0.01 on port 8001. The server broadcasts the stream using RTP that is h264 ecnoded.

In the second window, run the following: 

```
gst-launch-1.0 udpsrc port=5000 ! application/x-rtp, media=video, encoding-name=H264 ! rtph264depay ! h264parse ! avdec_h264 ! videoconvert ! ximagesink sync=false  -e
```

This listens for the packets and decodes the RTP stream and displays it on the screen.

This is just a very simple introduction to GStreamer.  If you are interested in other ways it can be used on the edge, take a look at Nvidia's DeepStream SDK, a streaming analytic toolkit to build AI-powered applications, which leverages GStreamer.



## Part 2: Optimiazation and Quantization

This is a very simple image classification example based on [PTQ_example.ipynb](https://github.com/tensorflow/tensorrt/blob/master/tftrt/examples-py/PTQ_example.ipynb) from the TensorFlow/TF-TRT project. You'll learn how to use TensorFlow 2.x to convert a Keras model to three tf-trt models, a fp32, fp16, and int8. A simple set of test images will be used to both validate and benchmark both the native model and the three tf-trt ones.

### Running 
1. Procure a virtual machine in AWS - we recommend a T4 GPU and 32 GB of RAM (e.g. g4dn.2xlarge). Use the Nvidia Deep Learning AMI so that the pre-requisites are pre-installed for you. We recommend using the latest [nvidia tensorflow container](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/tensorflow).  When starting the container, make sure that port 8888 is bound to the host, e.g. `-p 8888:8888` and that your firewall allows ingress on port 8888.
2. Clone this reposisotry: `git clone https://github.com/MIDS-scaling-up/v3a`.
3. Start Jupyter Lab with the command: `jupyter lab --ip 0.0.0.0 -allow-root`.  
4. Login to your lab instance.
5. Navigate to and open v3a/week06/lab/tf-trt.ipynb.
6. Run the notebook.

Think about and note the changes in inference peformance. Feel free to replace the model used with a different one and rerun.

**DELETE YOUR VM when the lab is complete!**
