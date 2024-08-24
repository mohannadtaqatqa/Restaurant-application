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
  double? priceAppetizers = 0.0; // New variable for appetizers' total price

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
      'priceAppetizers': priceAppetizers,
      // 'Appetizers': appetizers?.entries.map((value) => MapEntry(value.key, {
      //       'AppetizerID': value.key.toString(),
      //       'Details': value.value
      //           .map((subKey, subValue) => MapEntry(subKey, subValue)),
      //     })),
    };
    totalPrice += double.parse(price?.value ?? '0.0') + priceAppetizers!;
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

  void removeCartItem(int index, double priceApp) {
    double itemPrice = double.parse(dataList[index]['Price']);
    print(priceApp);
    totalPrice -= itemPrice;
    totalPrice -=  priceApp;

    // var appetizers = dataList[index]['appetizers'] as Map<int, Map<int, bool>>?;

    dataList.removeAt(index);
    update();
  }

  void removeAppetizer(int cartItemIndex, int appetizerId, double priceApp) {
    print("Appetizer ID to remove: $appetizerId");

    // الحصول على العنصر من dataList باستخدام الفهرس المحدد
    var itemData = dataList[cartItemIndex];

    // الحصول على خريطة المقبلات من العنصر المحدد
    var appetizers = itemData['appetizers'] as Map<int, Map<int, bool>>?;

    // التحقق من أن الخريطة ليست null
    if (appetizers != null) {
      totalPrice -= priceApp;
      // التنقل عبر الخريطة الداخلية وحذف القيمة
      for (var entry in appetizers.entries) {
        if (entry.value.containsKey(appetizerId)) {
          entry.value.remove(appetizerId);
          print("Appetizer removed. Updated dataList: \n$dataList");
          break;
        }
      }
    } else {
      print("No appetizers found for this item.");
    }

    // تحديث واجهة المستخدم بعد الحذف
    update();
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

// File: models/cart.dart

// import 'package:foodapp/viem_model/cart.vm.dart';
// import 'package:get/get.dart';

// class Cart extends GetxController {
//   String? itemId;
//   RxString? restaurantID = ''.obs;
//   RxMap<int, Map<int, bool>>? appetizers = <int, Map<int, bool>>{}.obs;
//   RxString? name = ''.obs;
//   RxString? price = ''.obs;
//   RxString? description = ''.obs;
//   RxString? image = ''.obs;
//   RxString? type = ''.obs;

//   List<Map<String, dynamic>> dataList = [];
//   double totalPrice = 0.0;


//   // تحويل البيانات إلى خريطة
//   void toMap() {
//   var data = {
//     'ItemID': itemId,
//     'ItemName': name?.value,
//     'Price': price?.value,
//     'Description': description?.value,
//     'img': image?.value,
//     'type': type?.value,
//     'RestaurantID': restaurantID?.value,
//     "appetizers": appetizers,
//     'Appetizers': appetizers?.entries.map((value) => MapEntry(value.key, {
//           'AppetizerID': value.key.toString(),
//           'Details': value.value.map((subKey, subValue) => MapEntry(subKey, subValue)),
//         })),
//   };

//   // التعامل مع الـ Future باستخدام then
//   ItemCartVM().fetchItem(itemId!).then((dataappetizer) {
//     // هنا نقوم بتحديث السعر الخارجي بالقيمة المسترجعة من الـ Future
//     var priceapp = dataappetizer[0]['price'] ?? 0.0;
//     print("priceapp =========> $priceapp");

//     // تحديث القيمة الخارجية للـ price
//     price?.value = priceapp.toString();
//     totalPrice += double.parse(price?.value ?? '0.0');
//     dataList.add(data);
//   });
// }


//   // تعيين القيم من JSON
//   void setValues(Map<String, dynamic> json) {
//     itemId = json['ItemID']?.toString();
//     name?.value = json['ItemName']?.toString() ?? '';
//     price?.value = json['Price']?.toString() ?? '';
//     description?.value = json['Description']?.toString() ?? '';
//     image?.value = json['img']?.toString() ?? '';
//     type?.value = json['type']?.toString() ?? '';
//     restaurantID?.value = json['RestaurantID']?.toString() ?? '';
//   }

  // حساب سعر السلة الإجمالي
  // void calculateTotalPrice() {
  //   double itemPrice = double.parse(price?.value ?? '0.0');
  //   double appetizersTotal = 0.0;

  //   if (appetizers != null) {
  //     appetizers!.forEach((key, value) {
  //       value.forEach((subKey, selected) {
  //         if (selected) {
  //           appetizersTotal += 10; // افتراض أن سعر كل مقبلات هو 10 شيكل
  //         }
  //       });
  //     });
  //   }

  //   totalPrice.value = itemPrice + appetizersTotal;
  // }
// }
