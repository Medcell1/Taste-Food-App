import 'package:admin_taste/helper/helper.dart';
import 'package:admin_taste/model/cart_model.dart';
import 'package:admin_taste/provider/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class KitchenTile extends StatefulWidget {
  const KitchenTile({
    Key? key,
    required this.documents,
    required this.width,
    required this.height,
    this.index, this.isDark,
  }) : super(key: key);

  final List<DocumentSnapshot<Object?>> documents;
  final double width;
  final double height;
  final dynamic index;
  final dynamic isDark;

  @override
  State<KitchenTile> createState() => _KitchenTileState();
}

class _KitchenTileState extends State<KitchenTile> {
  Future<void> saveQuantity(int quantity) async {
    await HelperFunction.saveQuantity(quantity);
  }

  Future<void> _loadQuantity() async {
    int quantity = await HelperFunction.getQuantity();
    setState(() {
      quantity = quantity;
    });
  }

  int quantity = 0;

  void increment() {
    setState(() {
      quantity++;
      saveQuantity(quantity);
    });
  }

  void decrement() {
    if (quantity > 0) {
      setState(() {
        quantity--;
        saveQuantity(quantity);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadQuantity();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<CartProvider, AuthProvider, MenuProvider>(
      builder: (context, cp, ap, mp, child) {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 10),
          child: GestureDetector(
            child: Material(
              elevation: 3,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white)
                  // border: widget.isDark ? Border.all(
                  //   color: Colors.purple.shade600,
                  // ) : null,
                ),
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 11,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.documents[widget.index]['foodImage'],
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.documents[widget.index]['foodName'],
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color:  Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            color: Colors.teal,
                          ),
                          height: 30,
                          width: 60,
                          child: Center(
                            child: Text(
                              '₦${widget.documents[widget.index]['price']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: widget.width * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        decrement();

                        var itemJson = widget.documents[widget.index].data()
                            as Map<String, dynamic>;
                        print(widget.documents[widget.index].data());

                        CartItemModel tempItem = CartItemModel.fromMap(itemJson)
                          ..quantity = quantity;
                        setState(() {});
                        if (quantity >= 1) {
                          cp.addItemToCart(tempItem);
                        } else {
                          cp.removeItemFromCart(tempItem);
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(quantity.toString()),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        increment();
                        if (quantity >= 1) {
                          var itemJson = widget.documents[widget.index].data()
                              as Map<String, dynamic>;
                          print(widget.documents[widget.index].data());

                          CartItemModel tempItem = CartItemModel.fromMap(itemJson)
                            ..quantity = quantity;
                          setState(() {});
                          cp.addItemToCart(tempItem);
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
