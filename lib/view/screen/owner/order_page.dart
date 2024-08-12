// views/owner_orders_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../viem_model/order_owner_vm.dart';

class OwnerOrdersPage extends StatelessWidget {
  OwnerOrdersPage({super.key});
  final OrderViewModel viewModel = Get.put(OrderViewModel());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلبات'),
      ),
      body: Obx(() {
        if (viewModel.orders.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: viewModel.orders.length,
          itemBuilder: (context, index) {
            final order = viewModel.orders[index];
            return ListTile(
              title: Text(order.productName),
              subtitle: Text('Quantity: ${order.quantity} - Status: ${order.status}'),
              trailing: DropdownButton<String>(
                value: order.status,
                onChanged: (newStatus) {
                  if (newStatus != null) {
                    viewModel.updateOrderStatus(order.id, newStatus);
                  }
                },
                items: ['Pending', 'In Progress', 'Completed', 'Cancelled']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
              ),
            );
          },
        );
      }),
    );
  }
}
