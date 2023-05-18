class CartItemModel {
  String? foodName;
  String? price;
  String? foodImage;
  int? quantity;
  CartItemModel({
    required this.foodName,
    required this.foodImage,
    required this.price,
    required this.quantity,
  });
  Map<String, dynamic> toMap() {
    return {
      "foodName": foodName,
      'foodImage': foodImage,
      'price': price,
    };
  }

  static CartItemModel fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      foodName: map['foodName'],
      foodImage: map['foodImage'],
      price: map['price'],
      quantity: null,
    );
  }
}
