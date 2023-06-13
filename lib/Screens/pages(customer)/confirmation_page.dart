import 'package:admin_taste/Reusables/confirm_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/providers.dart';

class ConfirmationPage extends StatefulWidget {
  final dynamic number;
  final dynamic total;
  const ConfirmationPage({
    Key? key,
    this.number,
    this.total,
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
      body: Column(children: [
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
          onTap: () async {
            var message = '';
            for (var item in cp.cartItems) {
              message +=
                  '${item.foodName.toString()}: ${item.quantity.toString()}\n';
            }
            wp.openWhatsAppLink(message, widget.number);
            print(message);
          },
          child: Container(
            color: Colors.black,
            width: double.maxFinite,
            height: 70,
            child: Center(
              child: Text(
                'Proceed → ${widget.total}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
