import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constant/endpoints.dart';

class ItemCartVM {
  // جلب البيانات من API
  Future<List<dynamic>> fetchItem(String id) async {
    final response = await http.get(Uri.parse("$itemApi$id"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Error fetching item data");
      return [];
    }
  }
}
