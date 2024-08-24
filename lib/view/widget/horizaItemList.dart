import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../viem_model/menu_vm.dart';
import 'appetizers_dialog.dart';
import 'item_card.dart';

class HorizontalItemList extends StatefulWidget {
  final List items;
  final int type;

  const HorizontalItemList(
      {super.key, required this.items, required this.type});

  @override
  State<HorizontalItemList> createState() => _HorizontalItemListState();
}

class _HorizontalItemListState extends State<HorizontalItemList> {
  MenuViewModel viewModel = MenuViewModel();
  Map<int, Map<int, bool>> selectedItemsState = {};

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox(
        height: 30,
        child: Center(
          child: Text(
            "لا يوجد بيانات",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }
    print("selectedItemsState: $selectedItemsState");
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          var item = widget.items[index];
          Uint8List? imageBytes;

          if (item["img"]['data'] != null && item["img"]['data'].isNotEmpty) {
            try {
              List<int> imageBuffer = List<int>.from(item["img"]['data']);
              imageBytes = Uint8List.fromList(imageBuffer);
            } catch (e) {
              print("Error converting image buffer: $e");
              imageBytes = null;
            }
          }

          if (item['type'] == widget.type) {
            return InkWell(
              onTap: () {
                if (!selectedItemsState.containsKey(item['ItemID'])) {
                  selectedItemsState[item['ItemID']] = {};
                }

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AppetizersDialog(
                      item: item,
                      viewModel: viewModel,
                      selectedItemsState: selectedItemsState,
                    );
                  },
                );
              },
              child: ItemCard(
                item: item,
                imageBytes: imageBytes,
                type: widget.type,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
