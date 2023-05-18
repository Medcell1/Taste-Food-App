class MenuModel {
  String? foodName;
  String? price;
  String? foodImage;
  DateTime? dateTime;
  dynamic uid;
  dynamic menuId;
  MenuModel({
    required this.uid,
    required this.foodName,
    required this.foodImage,
    required this.price,
    required this.dateTime,
    required this.menuId,
  });
  Map<String, dynamic> toMap() {
    return {
      "foodName": foodName,
      'foodImage': foodImage,
      'price': price,
      "dateTime": dateTime!.toIso8601String(),
      'uid': uid,
      "menuId": menuId,
    };
  }

  static MenuModel fromMap(Map<String, dynamic> map) {
    return MenuModel(
      menuId: map['menuId'],
      uid: map['uid'],
      foodName: map['foodName'],
      foodImage: map['foodImage'],
      price: map['price'],
      dateTime: DateTime.parse(
        map['dateTime'],
      ),
    );
  }

  // factory MenuModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
  //   Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
  //
  //   return MenuModel(
  //     uid: snapshot.get("uid"),
  //     dateTime: DateTime.now(),
  //     foodName: snapshot.data().toString().contains("foodName")
  //         ? snapshot.get("foodName")
  //         : '',
  //     price: snapshot.data().toString().contains("price")
  //         ? snapshot.get("price")
  //         : '',
  //     foodImage: snapshot.data().toString().contains("foodImage")
  //         ? snapshot.get("foodImage")
  //         : '',
  //   );
  // }
}
