

import 'dart:async';

import 'package:amplify_sample/Storage/storage_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  final VoidCallback shouldLogOut;
  final VoidCallback shouldShowCamera;
  GalleryPage({Key key, this.shouldLogOut, this.shouldShowCamera, this.imageUrlsController})
      : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();


  final StreamController<List<String>> imageUrlsController;
}

class _GalleryPageState extends State<GalleryPage> {

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        actions: [
          GestureDetector(child: Icon(Icons.logout),onTap:widget.shouldLogOut,)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt,),
        onPressed: widget.shouldShowCamera,
      ),
      body: Container(
        child: _gallerygrid(),
      ),
    );
  }

  StorageService _storageService;

  Widget _gallerygrid() {
    return StreamBuilder(
        stream: widget.imageUrlsController.stream,
        builder: (context, snapshot) {
          // 2
          if (snapshot.hasData) {
            // 3
            if (snapshot.data.length != 0) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  // 4
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: snapshot.data[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator()),
                    );
                  });
            } else {
              // 5
              return Center(child: Text('No images to display.'));
            }
          } else {
            // 6
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}

