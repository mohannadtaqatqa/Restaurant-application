import 'dart:convert';
import 'package:foodapp/core/constant/endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// class MenuViewModel {
//   Future<List<dynamic>?> getAppetizers(int id) async {
//     final response = await get(Uri.parse("$appetizersApi/${id.toString()}"));

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse;
//     } else if (response.statusCode == 404) {
//       print(response.body);
//       return null;
//     }
//     return null;
//   }

// }

// viem_model/menu_vm.dart

class MenuViewModel extends GetxController {
  Future<List<dynamic>?> getAppetizers(int id) async {
    final response = await http.get(Uri.parse("$appetizersApi/${id.toString()}"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else if (response.statusCode == 404) {
      print("<===== Error: ${response.body} =====>");
      return null;
    }
    return null;
  }

  Future<List<dynamic>> getRestaurant(int restaurantId) async {
    final response = await http
        .get(Uri.parse("$restaurantsApi$restaurantId"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }
    List<int> selectedItems = [];
    bool isSelected = false;
  void toggleSelection(int itemId) {
    if (selectedItems.contains(itemId)) {
      selectedItems.remove(itemId);
    } else {
      selectedItems.add(itemId);
      print("add $selectedItems");
    }
    update(); // لتحديث الـ UI
  }
  Future<List> getItems(int id) async {
    final response =
        await http.get(Uri.parse("$itemsApi$id"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }
}

