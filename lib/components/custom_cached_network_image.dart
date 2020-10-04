import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:top_stories/core/core.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  ///The full url to get the image from
  final String imageUrl;

  const CustomCachedNetworkImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      placeholder: (BuildContext context, String string) => Image.asset(
        Images.placeholder,
      ),
    );
  }
}
