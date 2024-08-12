// models/order_model.dart
class OrderModel {
  final String id;
  final String productName;
  final int quantity;
  final String status;
  final String customerName;
  final String ownerName;

  OrderModel({
    required this.id,
     this.productName ="بيزا",
     this.quantity=4,
     this.status= "Pending",
     this.customerName  = "محمد",
     this.ownerName ="يوسف",
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      productName: json['productName'],
      quantity: json['quantity'],
      status: json['status'],
      customerName: json['customerName'],
      ownerName: json['ownerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'quantity': quantity,
      'status': status,
      'customerName': customerName,
      'ownerName': ownerName,
    };
  }
}
