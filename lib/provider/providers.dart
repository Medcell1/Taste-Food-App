import 'dart:io';

import 'package:admin_taste/database/database.dart';
import 'package:admin_taste/model/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp/whatsapp.dart';

import '../Screens/who_are_you.dart';
import '../model/menu_model.dart';

class MenuProvider extends ChangeNotifier {
  Database db = Database();
  String foodImage = '';
  String editFoodImage = '';
  String menuId = '';
  TextEditingController foodNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Stream<QuerySnapshot> getMenuStream() {
    final collectionRef = FirebaseFirestore.instance.collection('menu');
    return collectionRef.orderBy('createdDate', descending: true).snapshots();
  }

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (file == null) return;
    String url = file!.path.toString();
    print('$url>>>>>>>>');
    imageController.text = url;

    notifyListeners();
  }

  editPickImage() async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (file == null) return;
    String url = file!.path.toString();
    print('$url>>>>>>>>');
    editImageController.text = url;

    notifyListeners();
  }

  User? userInfo;

  TextEditingController imageController = TextEditingController();
  TextEditingController editImageController = TextEditingController();
  XFile? file;

  getUserInfo() {
    userInfo = FirebaseAuth.instance.currentUser;
  }

  CollectionReference menuCollection =
      FirebaseFirestore.instance.collection('menu');
  Future<void> deleteMenu(String menuId) async {
    menuCollection.doc(menuId).delete();
  }

  List<MenuModel> menuList = [];
  Future<void> addMenuItem(BuildContext context, DateTime dateTime, uid,
      String foodName, String price) async {
    final CollectionReference menuCollection =
        FirebaseFirestore.instance.collection('menu');
    if (file != null) {
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference root = FirebaseStorage.instance.ref();
      Reference dirImages = root.child('images');
      Reference uploadImage = dirImages.child(fileName);
      try {
        await uploadImage.putFile(File(file!.path));
      } catch (e) {
        print(e);
      }
      foodImage = await uploadImage.getDownloadURL();
    }

    final menuItem = MenuModel(
      menuId: menuId,
      uid: uid,
      foodName: foodName,
      foodImage: foodImage,
      price: price,
      dateTime: dateTime,
    );
    menuCollection.add(menuItem.toMap());
    print("$menuId------->>>>>MenuId!!!!");
    Navigator.pop(context);

    imageController.clear();
    foodNameController.clear();
    priceController.clear();
    notifyListeners();
  }

  Future<void> updateMenuItem(BuildContext context, DateTime dateTime, uid,
      String foodName, String price, String menuId) async {
    CollectionReference menuCollection =
        FirebaseFirestore.instance.collection('menu');
    final menuItemRef = menuCollection.doc(menuId);
    if (file != null) {
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference root = FirebaseStorage.instance.ref();
      Reference dirImages = root.child('images');
      Reference uploadImage = dirImages.child(fileName);
      try {
        await uploadImage.putFile(File(file!.path));
      } catch (e) {
        print(e);
      }
      editFoodImage = await uploadImage.getDownloadURL();
    }
    final editedMenuItem = MenuModel(
        uid: uid,
        foodName: foodName,
        foodImage: editFoodImage,
        price: price,
        dateTime: dateTime,
        menuId: menuId);
    await menuItemRef.update(editedMenuItem.toMap());
    Navigator.pop(context);
    editImageController.clear();
    notifyListeners();
  }

  List<MenuModel> foundMenu = [];
  Future<void> filterMenu(
      String enteredMenu, List<MenuModel> menuModels) async {
    List<MenuModel> results = [];
    if (enteredMenu.isEmpty) {
      results = menuModels;
    } else {
      results = await menuModels
          .where(
            (element) =>
                element.foodName!.toString().toLowerCase().contains(
                      enteredMenu.toLowerCase(),
                    ) ||
                element.price!.toString().toLowerCase().contains(
                      enteredMenu.toLowerCase(),
                    ),
          )
          .toList();
    }
    foundMenu = results;
    notifyListeners();
  }
}

class AuthProvider extends ChangeNotifier {
  logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      print('Signed out sucesssfulyy!!!!!!!!!!!!');
    } catch (e) {
      print("log out error-->>>>>>>>>$e");
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfilePage(),
        ),
        (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        animation: null,
        content: Text('Logged Out Successfully'),
      ),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}

class CartProvider extends ChangeNotifier {
  List<CartItemModel> cartItems = [];
  void clearData() {
    cartItems.clear();
    notifyListeners();
  }

  void addItemToCart(CartItemModel cartItem) {
    bool itemExists = cartItems
        .where((element) => element.foodName == cartItem.foodName)
        .toList()
        .isNotEmpty;

    if (itemExists) {
      int index = cartItems
          .indexWhere((element) => element.foodName == cartItem.foodName);
      cartItems[index].quantity = cartItem.quantity;
    } else {
      cartItems.add(cartItem);
    }
    notifyListeners();
    print(cartItems);
    print(cartItems[0].quantity);
  }

  void removeItemFromCart(CartItemModel cartItem) {
    cartItems.removeWhere((element) => element.foodName == cartItem.foodName);
    print(cartItems);
    notifyListeners();
  }
}

class WhatsAppProvider extends ChangeNotifier {
  WhatsApp whatsApp = WhatsApp();

  void openWhatsAppLink(String message, String number) async {
    var whatsappUrl =
        "https://api.whatsapp.com/send/?phone=$number&text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(
      Uri.parse(whatsappUrl),
    )) {
      await launchUrl(
        Uri.parse(whatsappUrl),
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  void openLink(String message, dynamic number) async {
    await whatsApp.short(
      to: int.parse(number),
      message: message,
      compress: true,
    );
  }
}

class QuantityState extends ChangeNotifier {
  int _quantity = 0;

  int get quantity => _quantity;

  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    if (_quantity > 0) {
      _quantity--;
      notifyListeners();
    }
  }

  Future<void> loadQuantity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _quantity = prefs.getInt('quantity') ?? 0;
    notifyListeners();
  }

  Future<void> saveQuantity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quantity', _quantity);
  }
}
