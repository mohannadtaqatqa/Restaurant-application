
class AddProductModel {
  final String name;
  final String price;
  final String description;
  var image;
  final String type;
  final bool isOnSale;
  final double salePrice;

  AddProductModel({
    required this.name,
    required this.price,
    this.description = '',
    this.image ,
    required this.type,
    this.isOnSale = false,
    this.salePrice = 0.0,
  });



  // factory AddProductModel.fromJson(Map<String, dynamic> json) {
  //   return AddProductModel(
  //     name: json["name"],
  //     price: json["price"],
  //     description: json["description"] ?? '',
  //     image: json["image"] ?? '',
  //     type: json["type"],
  //     isOnSale: json["isOnSale"] ?? false,
  //     salePrice: json["salePrice"] ?? '',
  //   );
  // }
  AddProductModel copyWith({
    String? name,
    String? price,
    String? description,
    String? image,
    String? type,
    bool? isOnSale,
    double? salePrice,
  }) {
    return AddProductModel(
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      type: type ?? this.type,
      isOnSale: isOnSale ?? this.isOnSale,
      salePrice: salePrice ?? this.salePrice,
    );
  }
}
