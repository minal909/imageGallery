import 'package:flutter/material.dart';
import 'package:image_gallery/model/ImagesModel.dart';

class FullScreenImage extends StatefulWidget {
  final Hit? imageInfo;
  const FullScreenImage({super.key, required this.imageInfo});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool showBottomBar = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            widget.imageInfo!.userImageUrl.split("/").last,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.028),
          ),
          leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.arrow_circle_left_sharp,
                color: Colors.black26),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showBottomBar = !showBottomBar;
              });
            },
            child: Center(
              child: Image.network(
                widget.imageInfo!.largeImageUrl,
                fit: BoxFit.fill,
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          if (showBottomBar)
            Positioned(
              bottom: 0,
              child: AnimatedOpacity(
                opacity: showBottomBar ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  color: Colors.black54,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.favorite, color: Colors.white, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        widget.imageInfo!.likes.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                      const Icon(Icons.visibility,
                          color: Colors.white, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        widget.imageInfo!.views.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
