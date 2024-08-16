import 'dart:convert';

import 'package:foodapp/core/constant/endpoints.dart';
import 'package:foodapp/models/cart.dart';
import 'package:http/http.dart';

class ItemCartVM {
  Cart cart = Cart();
  Future item(String id) async {
    final response = await get(Uri.parse("$itemApi$id"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // print(jsonResponse[0]);
      // cart.setValues(jsonResponse[0]);
      print("========================> ${jsonResponse[0]['ItemName']}...........................................");
      return jsonResponse;
    } else {
      print("Error cartvm");
      return "Error";
    }
  }
}
