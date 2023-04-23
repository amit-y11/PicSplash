import 'dart:io';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:picsplash/models/imagemodel.dart';
import 'package:picsplash/utils/pref_manager.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagesView extends StatefulWidget {
  const ImagesView({Key? key, required this.images}) : super(key: key);

  final ImageModel images;

  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  bool isLiked = false;

  @override
  void initState() {
    check();
    FlutterDownloader.registerCallback(DownloadCallback.callback);
    super.initState();
  }

  PrefManager prefs = PrefManager();

  check() async {
    bool checkLike = await prefs.isFavorite(widget.images.urls.regular);
    setState(() {
      isLiked = checkLike;
    });
  }

  downloadImage() async {
    final status = await Permission.storage.request();
    var dir = Directory("/sdcard/PicSplash");
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    if (status.isGranted) {
      await FlutterDownloader.enqueue(
        url: widget.images.urls.full,
        savedDir: dir.path,
        fileName: 'image_${widget.images.id}.jpg',
      );
    } else {
      await Permission.storage.request();
    }
  }

  void setWallpaperDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Set wallpaper',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Home Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                  setWallpaper(1);
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Setting Wallpaper')));
                },
              ),
              ListTile(
                title: Text(
                  'Lock Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                  setWallpaper(2);
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Setting Wallpaper')));
                },
              ),
              ListTile(
                title: Text(
                  'Both',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                  setWallpaper(3);
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Setting Wallpaper')));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // static const platform =
  //     const MethodChannel('com.example.picsplash/wallpaper');

  Future<void> setWallpaper(int type) async {
    String url = widget.images.urls.full;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text('Downloading High Quality Image for you...'),
        content: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 16,
              ),
              Text('downloading high quality image...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
    // var file =
    //     await DefaultCacheManager().getSingleFile(widget.images.urls.full);
    if (mounted) Navigator.pop(context);
    late String result;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text('Setting Wallpaper...'),
        content: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 16,
              ),
              Text('setting wallpaper...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    try {
      await AsyncWallpaper.setWallpaper(
        url: widget.images.urls.full,
        wallpaperLocation: type,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      );
    } on PlatformException catch (e) {
      result = e.message ?? 'Unknown Error';
      print(e);
    }
    if (mounted) Navigator.pop(context);
    // var file =
    //     await DefaultCacheManager().getSingleFile(widget.images.urls.full);
    // try {
    //   await platform.invokeMethod('setWallpaper', [file.path, type]);
    // } on PlatformException catch (e) {
    //   print(e);
    // }
  }

  double angle = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Hero(
          tag: widget.images.id,
          transitionOnUserGestures: true,
          child: Stack(children: [
            Container(
                constraints: BoxConstraints.expand(),
                child: InteractiveViewer(
                  onInteractionUpdate: (ScaleUpdateDetails details) {
                    setState(() {
                      angle = details.rotation;
                    });
                  },
                  onInteractionEnd: (ScaleEndDetails details) {
                    setState(() {
                      angle = 0.0;
                    });
                  },
                  child: Transform.rotate(
                    angle: angle,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: widget.images.urls.regular,
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
            SafeArea(
              child: Container(
                height: 56,
                width: 56,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  child: IconButton(
                      tooltip: "Back",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  height: 60,
                  width: 200,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(35),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              tooltip: "Download",
                              onPressed: downloadImage,
                              icon: Icon(Icons.download_sharp)),
                          IconButton(
                              tooltip: "Set as Wallpaper",
                              onPressed: setWallpaperDialog,
                              icon: Icon(Icons.wallpaper)),
                          IconButton(
                              tooltip: "Favorite",
                              onPressed: () {
                                prefs
                                    .toggleFavorite(widget.images.urls.regular);
                                check();
                              },
                              icon: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked ? Colors.red : null,
                              )),
                        ]),
                  ),
                ),
              ),
            )
          ])),
    );
  }
}

class DownloadCallback {
  static void callback(String id, DownloadTaskStatus status, int progress) {
    print(progress);
  }
}
