import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery/Controller/getImage.dart';
import 'package:image_gallery/View/fullScreen.dart';
import 'package:image_gallery/model/ImagesModel.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  ImagesModel? allImageList;
  @override
  void initState() {
    super.initState();
    findImage();
  }

  findImage() async {
    var response = await GetImages.getImageList();
    setState(() {
      allImageList = response;
    });
  }

  int _selectedIndex = 0;
  void _onImageTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FullScreenImage(
        imageInfo: allImageList?.hits[_selectedIndex],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    int columnsCount = MediaQuery.of(context).size.width ~/
        100; // Adjust 150 according to your needs
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Image Gallery'),
        ),
        body: allImageList == null
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: allImageList!.hits.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnsCount,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final imageInfo = allImageList!.hits[index];
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                              () => FullScreenImage(
                                    imageInfo: allImageList?.hits[index],
                                  ),
                              transition: Transition.zoom);
                        },
                        child: Image.network(
                          imageInfo.largeImageUrl,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(4),
                          color: Colors.black54,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.favorite,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                imageInfo.likes.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.visibility,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  imageInfo.views.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}
