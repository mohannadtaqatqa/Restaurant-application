import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final Uint8List? imageBytes;

  const ImageWidget({super.key, this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return imageBytes != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.memory(
              imageBytes!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          )
        : Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.image,
              size: 50,
              color: Colors.grey[500],
            ),
          );
  }
}
