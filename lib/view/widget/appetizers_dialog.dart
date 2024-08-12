import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/colors.dart';
import '../../models/cart.dart';
import '../../viem_model/menu_vm.dart';

class AppetizersDialog extends StatefulWidget {
  final Map<String, dynamic> item;
  final MenuViewModel viewModel;
  final Map<int, Map<int, bool>> selectedItemsState;

  const AppetizersDialog({
    super.key,
    required this.item,
    required this.viewModel,
    required this.selectedItemsState,
  });

  @override
  _AppetizersDialogState createState() => _AppetizersDialogState();
}

class _AppetizersDialogState extends State<AppetizersDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        "هل تريد الإضافة للسلة؟",
        style: TextStyle(color: Colors.black),
      ),
      content: SizedBox(
        height: 300,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                IntrinsicHeight(
                  child: FutureBuilder(
                    future: widget.viewModel
                        .getAppetizers(widget.item['RestaurantID']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('لا يوجد بيانات'));
                      }

                      return SizedBox(
                        height: snapshot.data!.length * 80,
                        width: 300,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var appetizer = snapshot.data![index];
                            bool isSelected =
                                widget.selectedItemsState[widget.item['ItemID']]
                                        ?[appetizer['ItemID']] ??
                                    false;

                            return CheckboxListTile(
                              activeColor: primaryColor,
                              title: Text(appetizer['ItemName']),
                              subtitle:
                                  Text("السعر : ${appetizer['Price']} شيكل"),
                              value: isSelected,
                              onChanged: (value) {
                                print(value);
                                // widget.item.addAll(appetizer);
                                setState(() {
                                  widget.selectedItemsState[
                                          widget.item['ItemID']]
                                      ![appetizer['ItemID']] = value!;
                                });
                                print(" ${widget.selectedItemsState}");
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "وصف (اختياري)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child:
              const Text("إضافة للسلة", style: TextStyle(color: Colors.blue)),
          onPressed: () {
            // widget.item.addAll();
            //using getx
            final cart = Get.put(Cart(),permanent: true);
            cart.appetizers = widget.selectedItemsState.obs;
            cart.setValues(widget.item);
            print(widget.item);
            print("${cart.itemId}+${cart.appetizers}");
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("إلغاء", style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
