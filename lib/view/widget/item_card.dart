import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'image_widget.dart';

class ItemCard extends StatelessWidget {
  final dynamic item;
  final Uint8List? imageBytes;
  final int type;

  const ItemCard({super.key, required this.item, required this.imageBytes, required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        shadowColor: Colors.blueAccent.withOpacity(0.5),
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageWidget(imageBytes: imageBytes),
            const SizedBox(height: 5),
            Text(
              type == 3 ? item['Name'] : item['ItemName'] ?? 'No item name',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "${item['Price']} شيكل",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
