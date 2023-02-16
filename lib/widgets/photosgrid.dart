import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:picsplash/models/imagemodel.dart';
import 'package:picsplash/widgets/imagesview.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotosView extends StatelessWidget {
  /// PhotosView is used to display Grid view
  ///
  /// Required Values are:
  ///
  /// * [images] which is a list of [ImageModel]
  /// * [scrollController]
  ///
  /// [isNormalGrid] is optional
  ///
  /// set [isNormalGrid] to true if you want to show normal grid view instead
  /// of staggered grid view
  const PhotosView({
    Key? key,
    required this.images,
    required this.scrollController,
    this.isNormalGrid = false,
  }) : super(key: key);

  final List<ImageModel> images;
  final ScrollController scrollController;

  /// Pass true if you don't want staggered grid view
  ///
  /// Default value is false
  final bool isNormalGrid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: SingleChildScrollView(
        child: StaggeredGrid.count(
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
          crossAxisCount: 2,
          children: [
            for (int index = 0; index < images.length; index++)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ImagesView(images: images[index])));
                },
                child: Hero(
                  tag: images[index].id,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: isNormalGrid
                            ? images[index].urls.regular
                            : images[index].urls.small,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
