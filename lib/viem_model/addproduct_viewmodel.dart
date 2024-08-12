import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/core/constant/endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/add_product_model.dart';

class AddProductViewModel {
  List items = ['مشروبات', 'وجبات', 'عصائر', 'حلويات'];
  AddProductModel _model = AddProductModel(
    name: '',
    price: '',
    type: '',
    image: Image,
    salePrice: 0.0,
    description: '',
  );
  var  productImage;
  String get name => _model.name;
  String get price => _model.price;
  String get description => _model.description;
  String get image => _model.image;
  String get type => _model.type;
  bool get isOnSale => _model.isOnSale;
  double get salePrice => _model.salePrice;
  
  void setName(String value) => _model = _model.copyWith(name: value);
  void setPrice(String value) => _model = _model.copyWith(price: value);
  void setDescription(String value) =>
      _model = _model.copyWith(description: value);
  void setImage(String value) => _model = _model.copyWith(image: value);
  void setType(String value) => _model = _model.copyWith(type: value);
  void setIsOnSale(bool value) => _model = _model.copyWith(isOnSale: value);
  void setSalePrice(double value) => _model = _model.copyWith(salePrice: (value));

  

  Future<void> saveProduct() async {
    final response = await http.post(
      Uri.parse(addProductApi),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(toJson()),
    );

    print("${_model.name} ${_model.price} ${_model.type}");
    print(response.statusCode);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('تم حفظ المنتج بنجاح'),
        ),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('حدث خطأ ما'),
        ),
      );
    }
  }
    Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "description": description,
    "image": image,
    "type": items.indexOf(type)+1,
    "isOnSale": isOnSale,
    "offer": salePrice,
  };
}
