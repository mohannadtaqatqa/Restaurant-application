// viewmodels/order_viewmodel.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/order_owner.dart';

class OrderViewModel extends GetxController {
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.11:5000/orders'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        orders.value = jsonResponse.map((order) => OrderModel.fromJson(order)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print(e);
      // Handle error
    }
  }

  Future<void> updateOrderStatus(String id, String status) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.1.11:5000/orders/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'status': status}),
      );
      if (response.statusCode == 200) {
        fetchOrders();
      } else {
        throw Exception('Failed to update order status');
      }
    } catch (e) {
      print(e);
      // Handle error
    }
  }
}
