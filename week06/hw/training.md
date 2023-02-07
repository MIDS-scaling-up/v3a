# ImageNet training in PyTorch

The repo https://github.com/dusty-nv/pytorch-classification provides a nice example on how to train.  This requires a GPU enabled system.

To install, clone the repo `git clone https://github.com/dusty-nv/pytorch-classification` and run the command `pip3 install -r requirements.txt`.

## Training examples
Detailed steps on train can be found in the repo and at https://github.com/dusty-nv/jetson-inference/blob/master/docs/pytorch-cat-dog.md, https://github.com/dusty-nv/jetson-inference/blob/master/docs/pytorch-plants.md, and https://github.com/dusty-nv/jetson-inference/blob/master/docs/pytorch-collect.md.

I'll summarize the dog/cat example here.

```
$ cd data
$ wget https://nvidia.box.com/shared/static/o577zd8yp3lmxf5zhm38svrbrv45am3y.gz -O cat_dog.tar.gz
$ tar xvf cat_dog.tar.gz
```

By default, the training script `train.py` set to train a ResNet-18 model, but you can change that with the --arch flag.

Start training by running the following command `python3 train.py --model-dir=models/cat_dog data/cat_dog`.

As training starts, you should see something similar to:
```
Use GPU: 0 for training
=> dataset classes:  2 ['cat', 'dog']
=> using pre-trained model 'resnet18'
...
Epoch: [0][  0/625]  Time  2.140 ( 2.140)  Data  0.137 ( 0.137)  Loss 8.0172e-01 (8.0172e-01)  Acc@1  50.00 ( 50.00)  Acc@5 100.00 (100.00)
Epoch: [0][ 10/625]  Time  0.028 ( 0.211)  Data  0.015 ( 0.017)  Loss 3.0120e+00 (1.5143e+01)  Acc@1  50.00 ( 42.05)  Acc@5 100.00 (100.00)
Epoch: [0][ 20/625]  Time  0.063 ( 0.123)  Data  0.051 ( 0.015)  Loss 2.7744e+01 (1.3808e+01)  Acc@1  50.00 ( 45.83)  Acc@5 100.00 (100.00)
Epoch: [0][ 30/625]  Time  0.023 ( 0.090)  Data  0.010 ( 0.013)  Loss 7.3640e+00 (1.1398e+01)  Acc@1  37.50 ( 47.98)  Acc@5 100.00 (100.00)
Epoch: [0][ 40/625]  Time  0.013 ( 0.073)  Data  0.000 ( 0.012)  Loss 2.0611e+00 (9.3734e+00)  Acc@1  50.00 ( 49.09)  Acc@5 100.00 (100.00)
Epoch: [0][ 50/625]  Time  0.013 ( 0.063)  Data  0.000 ( 0.011)  Loss 2.1857e+00 (8.1106e+00)  Acc@1  62.50 ( 50.49)  Acc@5 100.00 (100.00)
Epoch: [0][ 60/625]  Time  0.013 ( 0.056)  Data  0.000 ( 0.010)  Loss 1.4194e+00 (7.1636e+00)  Acc@1  62.50 ( 50.00)  Acc@5 100.00 (100.00)
```
By default, train will run for 35 epochs.

See  https://github.com/dusty-nv/jetson-inference/blob/master/docs/pytorch-cat-dog.md for additional details.

