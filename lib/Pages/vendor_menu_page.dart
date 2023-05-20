import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../Reusables/floating_price_button.dart';
import '../Reusables/kitchen_tile.dart';
import '../model/cart_model.dart';
import '../provider/providers.dart';

int quantity = 0;

class VendorMenuScreen extends StatelessWidget {
  final String vendorId;
  final String vendorName;

  const VendorMenuScreen(
      {Key? key, required this.vendorId, required this.vendorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer3<CartProvider, AuthProvider, MenuProvider>(
        builder: (context, cp, ap, mp, child) {
          return SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('menu')
                  .where(
                    'uid',
                    isEqualTo: vendorId,
                  )
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.9,
                        child: Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.9,
                        child: Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                return AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) {
                        return SlideAnimation(
                          delay: Duration(milliseconds: 100),
                          horizontalOffset: 50,
                          child: FlipAnimation(
                            delay: Duration(milliseconds: 100),
                            child: widget,
                          ),
                        );
                      },
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.white24,
                                        width: 1,
                                      ),
                                    ),
                                    height: 50,
                                    width: 50,
                                    margin: EdgeInsets.only(left: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.white24,
                                        width: 1,
                                      ),
                                    ),
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 2,
                              ),
                              Image(
                                width: width * 0.985,
                                image: AssetImage('assets/animemap.png'),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "$vendorName's Kitchen",
                                        style: GoogleFonts.ubuntu(
                                          textStyle: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black,
                                    ),
                                    height: 25,
                                    width: 50,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: CupertinoColors.systemYellow,
                                        ),
                                        Text(
                                          '4.8',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: Container(
                                  width: double.maxFinite,
                                  height: height,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.black,
                                            ),
                                            height: 42,
                                            width: 110,
                                            child: Center(
                                              child: Text(
                                                'Most Popular',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.black,
                                            ),
                                            height: 45,
                                            width: 110,
                                            child: Center(
                                              child: Text(
                                                'Under #10',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.black,
                                            ),
                                            height: 45,
                                            width: 110,
                                            child: Center(
                                              child: Text(
                                                'Combo Meals',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      documents.isNotEmpty
                                          ? ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: documents.length,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return KitchenTile(
                                                  documents: documents,
                                                  width: width,
                                                  height: height,
                                                  index: index,
                                                );
                                              },
                                            )
                                          : SizedBox(
                                              height: height * 0.4,
                                              child: Center(
                                                child: Text(
                                                  'No Food Yet!',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          CartProvider cartProvider = context.watch<CartProvider>();
          double totalPrice = 0;
          print('Cart -> ${cartProvider.cartItems}');
          for (CartItemModel item in cartProvider.cartItems) {
            totalPrice += (int.parse(item.price ?? '0') * (item.quantity ?? 0));
          }
          print("$totalPrice-------->>price!!");
          return PriceButton(label: "$totalPrice");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget bottomNavigation() {
    return Column(
      children: [
        Container(
          height: 155,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7),
            ),
            color: Color(0xFFC71B45),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 75,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Color(0xFF8E0636),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.home,
                              size: 35,
                              color: Color(0xFFFBD68B),
                            ),
                          ),
                          Text(
                            'Home',
                            style: TextStyle(color: Color(0xFFFBD68B)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
