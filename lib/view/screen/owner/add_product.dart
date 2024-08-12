
import 'package:flutter/material.dart';
import 'package:foodapp/core/constant/colors.dart';
import 'package:foodapp/viem_model/addproduct_viewmodel.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final viewModel = AddProductViewModel();

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      viewModel.saveProduct();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ المنتج بنجاح')),
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إضافة منتج',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'اسم المنتج',
                    labelStyle: const TextStyle(color: primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  style: const TextStyle(color: primaryColor),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال اسم المنتج';
                    }
                    return null;
                  },
                  onChanged: viewModel.setName,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: viewModel.type.isNotEmpty ? viewModel.type : null,
                  decoration: InputDecoration(
                    labelText: 'اختر القسم',
                    labelStyle: const TextStyle(color: primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  items: viewModel.items
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category,
                                style: const TextStyle(color: primaryColor)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      viewModel.setType(value!);
                    });
                  },
                  style: const TextStyle(color: primaryColor),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى اختيار القسم';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'السعر',
                    labelStyle: const TextStyle(color: primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  style: const TextStyle(color: primaryColor),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال السعر';
                    }
                    return null;
                  },
                  onChanged: viewModel.setPrice,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'الوصف (اختياري)',
                    labelStyle: const TextStyle(color: primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  style: const TextStyle(color: primaryColor),
                  maxLines: 3,
                  onChanged: viewModel.setDescription,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: viewModel.isOnSale,
                      onChanged: (value) {
                        setState(() {
                          viewModel.setIsOnSale(value!);
                        });
                      },
                    ),
                    const Text(
                      'هل هناك عرض؟',
                      style: TextStyle(color: primaryColor),
                    ),
                  ],
                ),
                if (viewModel.isOnSale)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'سعر العرض',
                      labelStyle: const TextStyle(color: primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    style: const TextStyle(color: primaryColor),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      // اذا كان مدح
                      if (viewModel.isOnSale &&
                          (value == null || value.isEmpty )) {
                        return 'يرجى إدخال سعر العرض';
                      }
                      return null;
                    },
                    onChanged:((value) {viewModel.setSalePrice(double.parse(value));}),
                  ),
                const SizedBox(height: 16),

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                     viewModel.saveProduct();
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'حفظ المنتج',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
