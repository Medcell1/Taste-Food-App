import 'package:admin_taste/Reusables/VendorUtils/confirm_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/providers.dart';

class ConfirmationPage extends StatefulWidget {
  final dynamic number;
  final dynamic total;
  final dynamic vendorName;
  const ConfirmationPage({
    Key? key,
    this.number,
    this.total,
    this.vendorName,
  }) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    dynamic message;
    CartProvider cp = Provider.of<CartProvider>(context, listen: false);
    WhatsAppProvider wp = Provider.of<WhatsAppProvider>(context, listen: false);
    print(cp.cartItems);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Flexible(
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cp.cartItems.length,
                itemBuilder: (context, index) {
                  return ConfirmTile(
                    width: width,
                    height: height,
                    quantity: cp.cartItems[index].quantity!,
                    foodName: cp.cartItems[index].foodName!,
                    price: cp.cartItems[index].price!,
                    foodImage: cp.cartItems[index].foodImage!,
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              color: Colors.black,
              width: double.maxFinite,
              height: 70,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/whatsapp.png',
                      ),
                      height: 40,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Proceed → ₦${widget.total}',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () async {
              var message = '';
              for (var item in cp.cartItems) {
                message +=
                    '${item.foodName.toString()}:  ${item.quantity.toString()}\n';
              }
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    content: Builder(
                      builder: (context) {
                        return SizedBox(
                          height: height * 0.5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  "${widget.vendorName}'s Kitchen.",
                                  style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        color: Colors.teal),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(right: width * 0.35),
                                      child: Text(
                                        message,
                                        style: GoogleFonts.akayaKanadaka(
                                            textStyle: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ),
                                    ),
                                    Text(
                                      "Total: ₦${widget.total}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.23,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        wp.openWhatsAppLink(
                                            message, widget.number);
                                        print(message);
                                      },
                                      child: Container(
                                        height: height * 0.05,
                                        width: width * 0.6,
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Confirm',
                                            style: GoogleFonts.ubuntu(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 21,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
// var message = '';
// for (var item in cp.cartItems) {
// message +=
// '${item.foodName.toString()}: ${item.quantity.toString()}\n; Total Price: ₦${widget.total}';
// }
