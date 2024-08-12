import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  Cart get cartController => Get.put(Cart());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (cartController.itemId != null) ...[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Obx(() => Text(cartController.name?.value ?? 'No name')),
                  subtitle: Obx(() => Text(cartController.description?.value ?? 'No description')),
                  trailing: Obx(() => Text("${cartController.price?.value ?? 'No price'} شيكل")),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Appetizers:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Expanded(
                child: Obx(() {
                  print(cartController.name!.value);
                  if (cartController.appetizers?.isEmpty ?? true) {
                    return const Center(child: Text('No appetizers selected.'));
                  }

                  return ListView.builder(
                    itemCount: cartController.appetizers?.length ?? 0,
                    itemBuilder: (context, index) {
                      final appetizerId = cartController.appetizers?.keys.elementAt(index);
                      final isSelected = cartController.appetizers?[appetizerId]?.values.any((selected) => selected) ?? false;

                      return isSelected
                          ? ListTile(
                              title: Text('Appetizer $appetizerId'), // Customize this with actual data
                              trailing: Icon(Icons.check_circle, color: Colors.green),
                            )
                          : Container();
                    },
                  );
                }),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Add payment handling logic here
                },
                child: const Text('Proceed to Payment'),
              ),
            ] else
              const Center(child: Text('Your cart is empty.')),
          ],
        ),
      ),
    );
  }
}
