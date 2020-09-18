import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_sell/screens/home_screen.dart';
import 'package:home_sell/screens/seller_profile_screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ImageCapture extends StatefulWidget {

  ImageCapture({this.imageExisting});

  final File imageExisting;

  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;
  bool showSpinner = false;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source,);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  void delete() async {
    setState(() {
      showSpinner=true;
    });
    final FirebaseStorage _storage =
    FirebaseStorage(storageBucket: 'gs://hivegrocery.appspot.com');
    await _storage.ref().child('images/$userUid.png').delete().then((value){
      showSpinner=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, SellerProfileScreen.id, (route)=>route.isFirst);
              },
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.deepOrange[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                IconButton(
                  icon: Icon(Icons.photo_library),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: ListView(
                    children: <Widget>[
                        _imageFile!=null? Container(child: Image.file(_imageFile),color: Colors.white,):Container(height: 300,),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.black,
                      shape: CircleBorder(),
                      child: Icon(Icons.crop,color: Colors.deepOrange[400],),
                      onPressed: _cropImage,
                    ),
                    FlatButton(
                      color: Colors.black,
                      shape: CircleBorder(),
                      child: Icon(Icons.refresh,color: Colors.deepOrange[400],),
                      onPressed: _clear,
                    ),
                    FlatButton(
                      color: Colors.black,
                      shape: CircleBorder(),
                      child: Icon(Icons.delete,color: Colors.deepOrange[400],),
                      onPressed: delete,
                    ),
                  ],
                ),
                Uploader(
                  file: _imageFile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  Uploader({this.file});

  final File file;

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://stores-connect.appspot.com');

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/$userUid.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;

          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;

          return Column(
            children: <Widget>[
              if (_uploadTask.isComplete) Text('Upload Complete'),
              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _uploadTask.resume,
                ),
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),
              Container(
                width: MediaQuery.of(context).size.width/1.3,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  value: progressPercent,
                  backgroundColor: Colors.black,
                ),
              ),
              Text(
                '${(progressPercent * 100).toStringAsFixed(2)} %',
              ),
            ],
          );
        },
      );
    } else {
      return FlatButton(
        color: Colors.black,
        disabledColor: Colors.grey,
        onPressed: widget.file!=null ? _startUpload:null,
        child: Text('Upload',style: GoogleFonts.lato(color: Colors.white,fontSize: 14,),),
      );
    }
  }
}
