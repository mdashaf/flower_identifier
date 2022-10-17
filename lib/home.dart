import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';





class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();


  @override
  void initState(){
    super.initState();
    loadModel().then((value){
      setState(() {

      });
    });
  }


  dectectImage(File image) async {

    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5
    );

    setState(() {

      _output = output;
      _loading = false;

    });
  }


  loadModel() async{
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite',
        labels: 'assets/labels.txt'
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  pickImage()async{
    var image = await picker.getImage(source: ImageSource.camera);
        if(image == null) return null;

        setState(() {
          _image = File(image.path);
        });

        dectectImage(_image);
  }

  pickGalleryImage()async{
    var image = await picker.getImage(source: ImageSource.gallery);
    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    dectectImage(_image);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          Text(
            'Md. Ashaf Uddaula presents-',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 40,
                fontFamily: "Signatra",
          ),
          ),
          SizedBox(height: 5),
          Text(
            'Flower Identifier Application',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 30,
                fontFamily: "Signatra"
            ),
          ),
          SizedBox(height: 50),
          Center(child: _loading ?
          Container(
            width: 350,
            child: Column(children: <Widget>[
              Image.asset('assets/flowers.png'),
              SizedBox(height: 50),
            ],),
          ) : Container(
            child: Column(children: <Widget>[
              Container(
                height: 250,
                child: Image.file(_image),
              ),
              SizedBox(height: 20),
              _output != null
                  ? Text('${_output[0]['label']}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),
              )
                  : Container(),
              SizedBox(height: 10),
            ],),
          ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox.fromSize(
                  size: Size(100, 100), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () 
                        {
                          pickImage();
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.camera_alt, size: 40,), // icon
                            Text("Camera"), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 25),
                SizedBox.fromSize(
                  size: Size(100, 100), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: ()
                        {
                          pickGalleryImage();
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.photo, size: 40,), // icon
                            Text("Gallery"), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          ],),
          ),
        ],
        )
      )
    );
  }
}
