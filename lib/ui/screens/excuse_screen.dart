import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:mobilt_java22_franzjosef_birch_flutter_v_1/ui/screens/detector_view.dart';

import 'painters/face_detector_painter.dart';


class ExcusePage extends StatelessWidget {
  const ExcusePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Excuse'),
    );
  }
}

class FacePage extends StatefulWidget{
  @override
  createState() => _FacePageState();
}

class _FacePageState extends State<FacePage>{
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;

  @override dispose(){
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
        title: 'FaceDetector',
        customPaint: _customPaint,
        text: _text,
        onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
    /*
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detector'),
      ),
      body: Container(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Pick an image',
        child: Icon(Icons.add_a_photo),
      ),
    );
     */
  }


  Future<void> _processImage(InputImage inputImage) async{
   if(!_canProcess) return;
   if(_isBusy) return;
   _isBusy = true;
   setState(() {
     _text = '';
   });
   final faces = await _faceDetector.processImage(inputImage);
   if (inputImage.metadata?.size != null &&
   inputImage.metadata?.rotation != null) {
     final painter = FaceDetectorPainter(
       faces,
       inputImage.metadata!.size,
       inputImage.metadata!.rotation,
       _cameraLensDirection,
     );
     _customPaint = CustomPaint(painter: painter,);
   }else{
     String text = 'Faces found: ${faces.length}\n\n';
     for (final face in faces){
       text += 'face: ${face.boundingBox}\n\n';
     }
     _text = text;
     _customPaint =null;
   }
   _isBusy = false;
   if(mounted){
     setState(() {

     });
   }
  }
}

/*
final imageFile = await ImagePicker.pickImage(
source: ImageSource.camera
);
//final image =  FirebaseVisionImage.fromFile(imageFile);
final image = FaceDetector.pro(options: options)



 */

