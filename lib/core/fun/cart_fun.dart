import 'package:flutter/material.dart';
import '../../viem_model/cart.vm.dart';
import '../constant/colors.dart';

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> itemData;
  final Function onDeleteItem; // وظيفة لحذف العنصر الرئيسي من السلة
  final Function(int) onDeleteAppetizer; // وظيفة لحذف المقبلات

  CartItemWidget({
    required this.itemData,
    required this.onDeleteItem,
    required this.onDeleteAppetizer,
  });

  @override
  Widget build(BuildContext context) {
    final appetizerMap = itemData['appetizers'] as Map<int, Map<int, bool>>?;

    return FutureBuilder<Map<int, Map<String, dynamic>>>(
      future: fetchAllAppetizers(appetizerMap),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 1.5));
        }
        if (snapshot.hasError || snapshot.data == null) {
          return const Center(
            child: Text('حدث خطأ ما', style: TextStyle(fontSize: 12, color: Colors.red)),
          );
        }

        final appetizersData = snapshot.data!;
        return Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FixedColumnWidth(50),
          },
          border: TableBorder.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            // أسماء الأعمدة
            const TableRow(children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
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
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
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
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
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
            // عرض بيانات العنصر الرئيسي
            buildTableRow(
              itemName: itemData['ItemName'] ?? 'No name',
              price: "${itemData['Price'] ?? 'No price'} شيكل",
              onDelete: () {
                onDeleteItem(); // استدعاء وظيفة حذف العنصر الرئيسي
              },
            ),
            // عرض بيانات المقبلات
            ...appetizersData.entries.map((entry) {
              final appetizerId = entry.key;
              final appetizerData = entry.value;
              return buildTableRow(
                itemName: appetizerData['ItemName'] ?? 'No name',
                price: "${appetizerData['Price']} شيكل",
                onDelete: () {
                  onDeleteAppetizer(appetizerId); // استدعاء وظيفة حذف المقبلات
                },
              );
            }).toList(),
          ],
        );
      },
    );
  }

  Future<Map<int, Map<String, dynamic>>> fetchAllAppetizers(
      Map<int, Map<int, bool>>? appetizerMap) async {
    final Map<int, Map<String, dynamic>> result = {};
    if (appetizerMap != null) {
      for (var entry in appetizerMap.entries) {
        for (var subEntry in entry.value.entries) {
          if (subEntry.value) {
            final appetizerData = await ItemCartVM().fetchItem(subEntry.key.toString());
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
