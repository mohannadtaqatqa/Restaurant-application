// model/item_model.dart

import 'dart:typed_data';

class ItemModel {
  final int id;
  final String name;
  final double price;
  final int type;
  final Uint8List? imageBytes;

  ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    this.imageBytes,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    Uint8List? imageBytes;

    if (json["img"]['data'] != null && json["img"]['data'].isNotEmpty) {
      try {
        List<int> imageBuffer = List<int>.from(json["img"]['data']);
        imageBytes = Uint8List.fromList(imageBuffer);
      } catch (e) {
        print("Error converting image buffer: $e");
        imageBytes = null;
      }
    }

    return ItemModel(
      id: json['id'],
      name: json['ItemName'] ?? 'No item name',
      price: json['Price'].toDouble(),
      type: json['type'],
      imageBytes: imageBytes,
    );
  }
}
