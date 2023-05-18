import 'package:flutter/material.dart';

class SwiperOne extends StatefulWidget {
  final dynamic index;
  const SwiperOne({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<SwiperOne> createState() => _SwiperOneState();
}

class _SwiperOneState extends State<SwiperOne> {
  List networkFoodVendors = [
    'https://cttaste.com/cttaste_files/public/profilePic/dalish.jpeg',
    'https://cttaste.com/cttaste_files/public/profilePic/UZoxhZypNqNzDfVditfIodUPArpayaST3Df01Zct.jpg',
    'https://cttaste.com/cttaste_files/public/profilePic/dalish.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [
                // Colors.white,
                Color(0xFF7A60A5),
                Color(0xFFE9B668),
                // Color(0xFF82C3DF),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [
                0.0,
                1.0,
              ],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 2,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Trending for this week',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                      fontSize: 30),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                height: 120,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      networkFoodVendors[widget.index],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
