import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/colors.dart';
import '../../models/cart.dart';
import '../../viem_model/cart.vm.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final Cart cartController = Get.put(Cart());

  void deleteCartItem(int index, double priceApp) {
    cartController.removeCartItem(index, priceApp);
  }

  void deleteAppetizer(int cartItemIndex, int appetizerId, double priceApp) {
    cartController.removeAppetizer(cartItemIndex, appetizerId, priceApp);
  }

  var appetizerData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.shopping_cart),
        title: const Text('السلة'),
        backgroundColor: primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: GetBuilder<Cart>(
        builder: (controller) {
          final totalPrice = controller.totalPrice;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: controller.dataList.isEmpty
                      ? buildEmptyCartMessage()
                      : ListView.builder(
                          itemCount: controller.dataList.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<Map<int, Map<String, dynamic>>>(
                              future: fetchAllAppetizers(controller.dataList[index]
                                  ['appetizers']?.cast<int, Map<int, bool>>()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.5));
                                }
                                if (snapshot.hasError || snapshot.data == null) {
                                  return const Center(
                                    child: Text('حدث خطأ ما',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red)),
                                  );
                                }

                                final appetizersData = snapshot.data!;
                                return Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(1),
                                    2: FixedColumnWidth(50),
                                  },
                                  border: TableBorder.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 0.5),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: [
                                    const TableRow(children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 6.0),
                                        child: Text(
                                          'اسم الصنف',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 6.0),
                                        child: Text(
                                          'السعر',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 6.0),
                                        child: Text(
                                          'حذف',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    buildTableRow(
                                      itemName: controller.dataList[index]
                                              ['ItemName'] ??
                                          'No name',
                                      price:
                                          "${controller.dataList[index]['Price'] ?? 'No price'} شيكل",
                                      onDelete: () {
                                        deleteCartItem(
                                            index,
                                            appetizersData.values.fold<double>(
                                                0,
                                                (sum, appetizer) =>
                                                    sum +
                                                    (appetizer["Price"] ?? 0.0)));
                                      },
                                    ),
                                    ...appetizersData.entries.map((entry) {
                                      final appetizerId = entry.key;
                                      appetizerData = entry.value;
                                      return buildTableRow(
                                        itemName: appetizerData['ItemName'] ?? 'No name',
                                        price: "${appetizerData['Price'] ?? 0} شيكل",
                                        onDelete: () {
                                          deleteAppetizer(
                                              index,
                                              appetizerId,
                                              appetizerData['Price']?.toDouble() ??
                                                  0.0);
                                        },
                                      );
                                    }).toList(),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                ),
              ),
              // Payment Method and Total Container
              controller.dataList.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "المجموع : $totalPrice شيكل",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'طريقة الدفع:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Functionality for Pay on Delivery
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                  ),
                                  child: const Text(
                                    'الدفع عند الاستلام',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Functionality for Pay at the Restaurant
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                  ),
                                  child: const Text(
                                    'الدفع في المطعم',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(), // This hides the container when the dataList is empty
            ],
          );
        },
      ),
    );
  }
}

Future<Map<int, Map<String, dynamic>>> fetchAllAppetizers(
    Map<int, Map<int, bool>>? appetizerMap) async {
  final Map<int, Map<String, dynamic>> result = {};
  if (appetizerMap != null) {
    for (var entry in appetizerMap.entries) {
      for (var subEntry in entry.value.entries) {
        if (subEntry.value) {
          final appetizerData =
              await ItemCartVM().fetchItem(subEntry.key.toString());
          result[subEntry.key] = appetizerData.last;
        }
      }
    }
  }
  return result;
}

TableRow buildTableRow({
  required String itemName,
  required String price,
  required VoidCallback onDelete,
}) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        child: Text(
          itemName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        child: Text(
          price,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        child: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red, size: 20),
          onPressed: onDelete,
        ),
      ),
    ],
  );
}

Widget buildEmptyCartMessage() {
  return Center(
    child: Text(
      'سلتك فارغة',
      style: TextStyle(
        color: textColor.withOpacity(0.7),
        fontSize: 14,
      ),
    ),
  );
}
