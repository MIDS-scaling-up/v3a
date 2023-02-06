
## Part 1: GStreamer
This will run locally in a VM.  If you'd like to run with a Jetson device, see old version.  Note, you may need to build a new contaier instance on that lastest version of Jetpack that is available for your device.

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

**DELETE YOUR VM when the lap is complete!**
