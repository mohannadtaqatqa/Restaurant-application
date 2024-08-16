import 'package:flutter/material.dart';
import '../../viem_model/cart.vm.dart';
import '../constant/colors.dart';

Widget buildCartItem(Map<String, dynamic> itemData) {
  final appetizerMap = itemData['appetizers'] as Map<int, Map<int, bool>>?;

  return Builder(
    builder: (context) {
      return Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FixedColumnWidth(50), // Adjusted width for delete button column
        },
        border: TableBorder.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // اسماء الاعمدة
          const TableRow(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                child: Text(
                  'اسم الصنف',
                  style: TextStyle(
                    fontSize: 16, // Reduced font size
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
                    fontSize: 16, // Reduced font size
                    fontWeight: FontWeight.bold,
                    color: textColor,
          ),)),
          Padding(padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
          child: Text(
            'حذف',
            style: TextStyle(
              fontSize: 16, // Reduced font size
              fontWeight: FontWeight.bold,
              color: textColor
              ,
            ),
          ))
          ]),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                child: Text(
                  itemData['ItemName'] ?? 'No name',
                  style: const TextStyle(
                    fontSize: 16, // Reduced font size
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                child: Text(
                  "${itemData['Price'] ?? 'No price'} شيكل",
                  style: const TextStyle(
                    fontSize: 14, // Reduced font size
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: () {
                    // Add your delete functionality here
                  },
                ),
              ),
            ],
          ),
          if (appetizerMap != null)
            ...appetizerMap.entries.map((entry) {
              final isSelectedMap = entry.value;
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                    child: buildAppetizersList(isSelectedMap),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                    child: FutureBuilder(
                      future: ItemCartVM().item(entry.key.toString()),
                      builder: (context, snapshot) {
                        print("entry.key.toString() =========> ${entry.key.toString()}");
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(strokeWidth: 1.5));
                        }
                        if (snapshot.hasError || snapshot.data == null) {
                          return const Text('حدث خطأ ما',
                              style: TextStyle(fontSize: 12)); // Reduced font size
                        }
                        return Text(
                          "${snapshot.data[snapshot.data.length - 1]['Price']} شيكل",
                          style: const TextStyle(color: primaryColor, fontSize: 14),
                        );
                      },
                    ),
                  ),
                  const SizedBox(), // Empty cell to keep alignment
                ],
              );
            }).toList(),
        ],
      );
    }
  );
}

Widget buildAppetizersList(Map<int, bool> isSelectedMap) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: isSelectedMap.entries.map((subEntry) {
      final subId = subEntry.key;
      final isSelected = subEntry.value;

      if (isSelected) {
        return FutureBuilder(
          future: ItemCartVM().item(subId.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(strokeWidth: 1.5));
            }
            if (snapshot.hasError || snapshot.data == null) {
              return const Text('حدث خطأ ما',
                  style: TextStyle(fontSize: 12)); // Reduced font size
            }
            return Text(
              snapshot.data[snapshot.data.length - 1]['ItemName'],
              style: const TextStyle(color: accentColor, fontSize: 14),
            );
          },
        );
      } else {
        return Container();
      }
    }).toList(),
  );
}

Widget buildEmptyCartMessage() {
  return Center(
    child: Text(
      'سلتك فارغة',
      style: TextStyle(
        color: accentColor.withOpacity(0.7),
        fontSize: 14, // Reduced font size
      ),
    ),
  );
}
