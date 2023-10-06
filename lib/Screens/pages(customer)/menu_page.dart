import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../Reusables/VendorUtils/floating_price_button.dart';
import '../../Reusables/VendorUtils/kitchen_tile.dart';
import '../../model/cart_model.dart';
import '../../provider/providers.dart';
import 'confirmation_page.dart';

int quantity = 0;

class VendorMenuScreen extends StatefulWidget {
  final String vendorId;
  final String vendorName;
  final dynamic vendorNumber;

  const VendorMenuScreen(
      {Key? key,
      required this.vendorId,
      required this.vendorName,
      this.vendorNumber})
      : super(key: key);

  @override
  State<VendorMenuScreen> createState() => _VendorMenuScreenState();
}

class _VendorMenuScreenState extends State<VendorMenuScreen> {
  @override
  Widget build(BuildContext context) {
    Future<bool> onTap() async {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Do you want to go back?'),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);

                  ///dont forget to clear data
                  Provider.of<CartProvider>(context, listen: false).clearData();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('No'),
              ),
            ],
          );
        },
      );
      return shouldPop!;
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    Provider.of<CartProvider>(context, listen: false)
                        .clearData();
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(),
        builder: ( context, box, child) {
          final isDark = box.get('isDark' , defaultValue: false);
          return Scaffold(
            backgroundColor: Colors.black,
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('menu')
                  .where(
                'uid',
                isEqualTo: widget.vendorId,
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
                } else if (snapshot.connectionState == ConnectionState.waiting) {
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

                return Column(
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, true);
                                  Provider.of<CartProvider>(context, listen: false)
                                      .clearData();
                                },
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
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          color: isDark? Color(0xff212121) : Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Image(
                              width: width * 0.85,
                              image: AssetImage('assets/animemap.png'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${widget.vendorName}'s Kitchen",
                                      style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(
                                            fontSize: 20,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: CupertinoColors.systemYellow,
                                        size: 20,
                                      ),
                                      Text(
                                        '4.8',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
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
                              child: Material(
                                elevation: 4,
                                child: Container(
                                  width: double.maxFinite,
                                  // height: height + height,
                                  decoration: BoxDecoration(
                                    color: isDark ? Color(0xff212121) : Colors.grey.shade300,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),

                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: 20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(30),
                                                  color: Colors.black,
                                                ),
                                                height: 40,
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    'Most Popular',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(30),
                                                  color: Colors.black,
                                                ),
                                                height: 40,
                                                width: 100,
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
                                                height: 40,
                                                width: 100,
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
                                        ),
                                        documents.isNotEmpty
                                            ? SizedBox(
                                          height: double.maxFinite,
                                          child: ListView.builder(
                                            physics:
                                            NeverScrollableScrollPhysics(),
                                            itemCount: documents.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return KitchenTile(
                                                documents: documents,
                                                width: width,
                                                height: height,
                                                index: index,
                                                isDark: isDark,
                                              );
                                            },
                                          ),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: Consumer<CartProvider>(
              builder: (context, cartProvider, _) {
                CartProvider cartProvider = context.watch<CartProvider>();
                double totalPrice = 0;
                print('Cart -> ${cartProvider.cartItems}');
                for (CartItemModel item in cartProvider.cartItems) {
                  totalPrice +=
                  (int.parse(item.price ?? '0') * (item.quantity ?? 0));
                }
                print("$totalPrice-------->>price!!");
                return PriceButton(
                    label: "₦$totalPrice",
                    onPressed: () async {
                      if (totalPrice != 0.0) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ConfirmationPage(
                                number: widget.vendorNumber,
                                total: totalPrice,
                                vendorName: widget.vendorName,
                              );
                            },
                          ),
                        );
                      }
                    });
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        },

      ),
    );
  }
}
