import 'package:amplify_sample/Storage/storage_service.dart';
import 'package:amplify_sample/UI_Components/CameraPage.dart';
import 'package:amplify_sample/UI_Components/Galery/GalleryPage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraFlow extends StatefulWidget {
  final VoidCallback shouldLogOut;
  CameraFlow({Key key,this.shouldLogOut})
      : super(key: key);
  @override
  _CameraFlowState createState() => _CameraFlowState();

}

class _CameraFlowState extends State<CameraFlow> {
  bool _shouldCameraShow = false;
  CameraDescription _camera;
  void _getCamera() async{
    final camerasList=await availableCameras();
    setState(() {
      final firstCamera=camerasList.first;
      this._camera=firstCamera;
    });
  }

  List<MaterialPage> get _pages {
    return [
      MaterialPage(
          child: GalleryPage(
        shouldLogOut: widget.shouldLogOut,
        shouldShowCamera: () => _toggleCameraOpen(true),
            imageUrlsController: _storageService.imageUrlsController,
      )),
      if (_shouldCameraShow)
        MaterialPage(
            child: CameraPage(
              camera: _camera,
              didProvideImagePath: (imagePath){
                this._storageService.uploadImageAtPath(imagePath);
              },
            )),
    ];
  }

  void _toggleCameraOpen(bool isOpen) {
    setState(() {
      this._shouldCameraShow = isOpen;
    });
  }

  StorageService _storageService;
@override
  void initState() {
    super.initState();
    _getCamera();
    _storageService = StorageService();
    _storageService.getImages();
  }
  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: _pages,
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
