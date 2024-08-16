import 'package:get/get.dart';

class Cart extends GetxController {
  String? itemId;
  RxString? restaurantID = ''.obs;
  RxMap<int, Map<int, bool>>? appetizers = <int, Map<int, bool>>{}.obs;
  RxString? name = ''.obs;
  RxString? price = ''.obs;
  RxString? description = ''.obs;
  RxString? image = ''.obs;
  RxString? type = ''.obs;

  // تخزين جميع البيانات في المتغيرات الخاصة بالكائن
  List<Map<String, dynamic>> dataList = [];
  double totalPrice = 0.0;
  toMap() {
    var data = {
      'ItemID': itemId,
      'ItemName': name?.value,
      'Price': price?.value,
      'Description': description?.value,
      'img': image?.value,
      'type': type?.value,
      'RestaurantID': restaurantID?.value,
      "appetizers": appetizers,
      'Appetizers': appetizers?.entries.map((value) => MapEntry(value.key, {
            'AppetizerID': value.key.toString(),
            'Details': value.value
                .map((subKey, subValue) => MapEntry(subKey, subValue)),
          })),
    };
    totalPrice += double.parse(price?.value ?? '0.0');
    // إضافة البيانات الجديدة إلى القائمة
    dataList.add(data);
    // dataList  = dataList.add(data);
    print("appetizers =========> $appetizers");
    print("dataList =========> $dataList");
    return dataList;
  }

  void setValues(Map<String, dynamic> json) {
    itemId = json['ItemID']
        ?.toString(); // Using json['ItemID'] to get the correct value
    name?.value = json['ItemName']?.toString() ?? '';
    price?.value = json['Price']?.toString() ?? '';
    description?.value = json['Description']?.toString() ??
        ''; // Defaulting to empty string if null
    image?.value = json['img']?.toString() ?? '';
    type?.value = json['type']?.toString() ?? '';
    restaurantID?.value = json['RestaurantID']?.toString() ?? '';

    // You may need to handle the appetizers data structure here depending on how it's passed in the JSON.
  }
}

/*

List<Map<String, dynamic>> toMap() {
    final  List<Map<String, dynamic>> data = [];
    data['ItemID'] = itemId;
    data['ItemName'] = name?.value;
    data['Price'] = price?.value;
    data['Description'] = description?.value;
    data['img'] = image?.value;
    data['type'] = type?.value;
    data['RestaurantID'] = restaurantID?.value;
     data['Appetizers'] = appetizers?.map((key, value) {
    return MapEntry(key.toString(), value);
  });
    print("data =========> $data");
    return data;
  }
*/