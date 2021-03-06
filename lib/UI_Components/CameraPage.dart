import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;
  final ValueChanged didProvideImagePath;

  CameraPage({Key key, this.camera, this.didProvideImagePath})
      : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            {
              return CameraPreview(this._controller);
            }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: _takerPicture,
      ),
    );
  }

  void _takerPicture() async {
    try {
      await _initializeControllerFuture;
      final tmpDirectory = await getTemporaryDirectory();
      final filePath = '${DateTime.now().millisecondsSinceEpoch}.png';
      final path = join(tmpDirectory.path, filePath);
      await _controller.takePicture(filePath);
      widget.didProvideImagePath(path);
    } catch (e) {
      print(e);
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
