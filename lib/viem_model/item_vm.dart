// viem_model/menu_vm.dart

import 'dart:convert';
import 'package:foodapp/core/constant/endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

class MenuViewModel extends GetxController {
  Future<List<ItemModel>> getItems(int restaurantId) async {
    final response = await http.get(Uri.parse("$itemsApi$restaurantId"));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => ItemModel.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getRestaurant(int restaurantId) async {
    final response = await http.get(Uri.parse("$restaurantsApi$restaurantId"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }
}
