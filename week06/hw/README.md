# Homework 6

This homework covers some use of GStreamer and model optimization.  It builds on the week 6 lab and completing the lab first is hightly recommended.   

This is an ungraded assignment

## Part 1: GStreamer

1. What is the difference between a property and a capability?  How are they each expressed in a pipeline?

2. Explain the following pipeline, that is explain each piece of the pipeline, desribing if it is an element (if so, what type), property, or capability.  What does this pipeline do?

```
gst-launch-1.0 v4l2src device=/dev/video0 ! video/x-raw, framerate=30/1 ! videoconvert ! agingtv scratch-lines=10 ! videoconvert ! xvimagesink sync=false
```

3. GStreamer pipelines may also be used from Python and OpenCV.  For example:
```
import numpy as np
import cv2

# use gstreamer for video directly
camSet='v4l2src device=/dev/video2 ! videoconvert ! video/x-raw, format=BGR ! appsink sync=false'
cap= cv2.VideoCapture(camSet)

#cap = cv2.VideoCapture(0)

while(True):
    # Capture frame-by-frame
    ret, frame = cap.read()

    # Display the resulting frame
    cv2.imshow('frame',frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()
```
In the lab, you saw how to stream using Gstreamer.  Using the lab and the above example, write a Python application that listens for images streamed from a Gstreamer pipeline.  You'll want to make sure your image displays in color.  Feel free to add some "transformations" to the stream!

For part 1, you'll need to submit:
- Answer to question 1
- Answer to question 2
- Source code and Gstreamer "server" pipeline used.


## Part 2: Model optimization and quantization

In lab, you saw to how use leverage TensorRT with TensorFlow.  For this homework, you'll look at another way to levarage TensorRT with Pytorch.

1. Procure a virtual machine in AWS - we recommend a T4 GPU and 32 GB of RAM (e.g. g4dn.2xlarge). Use the Nvidia Deep Learning AMI so that the pre-requisites are pre-installed for you. We recommend using the latest [nvidia pytorch container](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch).  When starting the container, make sure that port 8888 is bound to the host, e.g. `-p 8888:8888` and that your firewall allows ingress on port 8888.
2. Clone this reposisotry: `git clone https://github.com/MIDS-scaling-up/v3a`.
3. Start Jupyter Lab with the command: `jupyter lab --ip 0.0.0.0 -allow-root`.  
4. Login to your lab instance.
5. Navigate to and open v3a/week06/hw/torch-trt.ipynb.
6. Run the notebook.

What was your average throughput for native model, for the tensor-rt FP32 and FP16 models.

Next, you'll want to leverge transfer learning to train your own model.  See https://pytorch.org/tutorials/beginner/transfer_learning_tutorial.html for an example. You may also look at [training.md](training.md) for addional examples.

Once you have your model trained, use torch-trt.ipynb notebook as starting point and optimize your model, producing both FP32 and FP16 models.  How does the peformace compare to your native model?



For part 2, you'll need to submit:
- your average throughput for native model, for the tensor-rt FP32 and FP16 models from the torch-trt.ipynb notebook
- A description of your data set
- How long you trained your model, how many epochs you specified, and the batch size.
- Native Pytorch baseline
- TensorRT FP32 and FP16 performance numbers.

**DELETE YOUR VM when the homework is complete!**
