import 'package:flutter/material.dart';
import 'package:top_stories/core/core.dart';

class ImagePlaceholderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Images.placeholder,
          ),
        ),
      ),
    );
  }
}
