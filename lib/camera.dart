import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

List<CameraDescription> cameras;
CameraController controller;
String model;
class CameraActivity extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Activity'),
      ),
      body: CameraWidget(),
    );  
  }
} 

class Camera extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Center(child: Text("Hello"),);
  }
}

class CameraWidget extends StatefulWidget{
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget>{
  void getCameras() async{
    cameras = await availableCameras();
  }
  void loadModel() async{
    model = await Tflite.loadModel(
      model: 'assets/mobilenet_v1_1.0_224.tflite',
      labels: 'assets/labels.txt',
      numThreads: 1
    );
  }
  @override
  void initState(){
    super.initState();
    getCameras();
    loadModel();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if(!mounted){
        print("Not mounted");
      }
      setState(() {
        
      });
      //TODO: Object detection on image streaming, not working 
      //TODO: Error: Cannot copy between a TensorFlowLite tensor with shape [1, 1001] and a Java object with shape [1, 1001, 4].
      /*controller.startImageStream((CameraImage img) {
        Tflite.detectObjectOnFrame(
          bytesList: img.planes.map((plane){
            return plane.bytes;
          }).toList(),
          model: "SSDMobileNet",
          imageHeight: img.height,
          imageWidth: img.width,
          imageMean: 127.5,
          imageStd: 127.5,
          numResultsPerClass: 2,
          threshold: 0.4,
          asynch: true,
        ).then((recognitions){
          print(recognitions);
        });
      });*/
    });
  }

  @override
  Widget build(BuildContext context){
    if(!controller.value.isInitialized){
      return Container();
    }
    return Center(
      child: Container(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
        margin: EdgeInsets.symmetric(vertical: 30),
      ),
    );
  }

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }
}