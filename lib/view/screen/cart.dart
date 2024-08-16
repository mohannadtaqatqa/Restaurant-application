import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/colors.dart';
import '../../core/fun/cart_fun.dart';
import '../../models/cart.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final Cart cartController = Get.put(Cart());

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GetBuilder<Cart>(
                init: cartController,
                builder: (controller) {
                  if (controller.dataList.isEmpty) {
                    return buildEmptyCartMessage();
                  } else {
                    return ListView.builder(
                      itemCount: controller.dataList.length,
                      itemBuilder: (context, index) {
                        return buildCartItem(controller.dataList[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ),
          if(cartController.dataList.isNotEmpty)
          Container(
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
                Text("المجموع : ${cartController.totalPrice} شيكل",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                        child: const Text('الدفع عند الاستلام',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
                        child: const Text('الدفع في المطعم',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
