
## Part 2: Optimiazation and Quantization

This is a very simple image classification example based on [PTQ_example.ipynb](https://github.com/tensorflow/tensorrt/blob/master/tftrt/examples-py/PTQ_example.ipynb) from the TensorFlow/TF-TRT project. You'll learn how to use TensorFlow 2.x to convert a Keras model to three tf-trt models, a fp32, fp16, and int8. A simple set of test images will be used to both validate and benchmark both the native model and the three tf-trt ones.

### Running 
1. Create an AWS VM with GPU enabled*
2. Once the VM is created nvcr.io/nvidia/tensorflow:22.12-tf2-py3 (review https://github.com/MIDS-scaling-up/v3/tree/main/week05/hw)
