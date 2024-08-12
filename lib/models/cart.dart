import 'package:get/get.dart';

class Cart extends GetxController {
  String? itemId;
  RxString? restaurantID;
  RxMap<int, Map<int, bool>>? appetizers ;
  RxString? name;
  RxString? price;
  RxString? description;
  RxString? image;
  RxString? type;
  // RxBool? isOnSale;
  // RxDouble? salePrice;

void setValues(Map<String, dynamic> json) {
  itemId = json['ItemID']?.toString();  // استخدم json['ItemID'] للوصول إلى القيمة الصحيحة
  name = json['ItemName']?.toString().obs;
  price = json['Price']?.toString().obs;
  description = json['Description']?.toString().obs ?? ''.obs; // إذا كانت null, استخدم قيمة افتراضية مثل ''
  image = json['img']?.toString().obs;
  type = json['type']?.toString().obs;
  restaurantID = json['RestaurantID']?.toString().obs;
  // appetizers = json['appetizers'];
  }
 }
