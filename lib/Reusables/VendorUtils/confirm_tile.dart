import 'package:admin_taste/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConfirmTile extends StatefulWidget {
  const ConfirmTile({
    Key? key,
    required this.width,
    required this.height,
    this.index,
    this.quantity,
    this.foodName,
    this.price,
    this.foodImage,
  }) : super(key: key);
  final dynamic quantity;
  final double width;
  final double height;
  final dynamic foodName;
  final dynamic index;
  final dynamic price;
  final dynamic foodImage;

  @override
  State<ConfirmTile> createState() => _ConfirmTileState();
}

class _ConfirmTileState extends State<ConfirmTile> {
  @override
  Widget build(BuildContext context) {
    dynamic totalOfEach;
    totalOfEach = (int.parse(widget.price ?? '0') * (widget.quantity ?? 0));

    return Consumer3<CartProvider, AuthProvider, MenuProvider>(
      builder: (context, cp, ap, mp, child) {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 10),
          child: GestureDetector(
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
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
                      image: DecorationImage(
                          image: NetworkImage(widget.foodImage),
                          fit: BoxFit.cover),
                      color: Colors.grey,
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
                        '${widget.foodName}',
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff4A5661),
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
                        width: 100,
                        child: Center(
                          child: Text(
                            'Quantity: ${widget.quantity}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: widget.width * 0.05,
                  ),
                  Text(
                    '₦${totalOfEach.toString()}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
