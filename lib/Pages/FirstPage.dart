import 'package:admin_taste/Pages/vendor_menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

int _selectedItemPosition = 0;

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.white,
                child: Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.white,
                      child: Row(
                        children: [
                          SizedBox(
                            height: height * 0.15,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * 0.05),
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 2, color: Colors.grey),
                            ),
                            child: Icon(
                              CupertinoIcons.search,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.18,
                          ),
                          Image(
                            image: AssetImage(
                              'assets/logobig.png',
                            ),
                            height: 30,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: width * 0.2,
                          ),
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              CupertinoIcons.bell_solid,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.001,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: height * 0.2,
                      width: width * 0.92,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20, left: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      'Claim your daily',
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          fontSize: 23,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'free delivery now!',
                                      style: GoogleFonts.kanit(
                                        fontSize: 23,
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.black,
                                ),
                                child: Center(
                                  child: Text(
                                    'Order Now',
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.156,
                            child: Image(
                              image: AssetImage(
                                'assets/burger-hungry.gif',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.white,
                          child: Text(
                            'Featured',
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: 10,
                      padding: EdgeInsets.all(2.0),
                      itemBuilder: (BuildContext context, int index) {
                        // print("VendorId => ${snapshot.data?.docs[index].id}");
                        return GestureDetector(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                width: (width / 2) - 15,
                                height: height * 0.04,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://i.pinimg.com/564x/b7/4a/64/b74a649b1c6320fb87181d215b19d86e.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade400,
                                    highlightColor: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            15.0,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Text(
                                              '',
                                              style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ), /* add child content here */
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: height * 0.15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.05),
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.grey),
                      ),
                      child: Icon(
                        CupertinoIcons.search,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.18,
                    ),
                    Image(
                      image: AssetImage(
                        'assets/logobig.png',
                      ),
                      height: 30,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: width * 0.2,
                    ),
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.bell_solid,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: height * 0.2,
                  width: width * 0.92,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 20),
                            child: Column(
                              children: [
                                Text(
                                  'Claim your daily',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: 23,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  'free delivery now!',
                                  style: GoogleFonts.kanit(
                                    fontSize: 23,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                'Order Now',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.156,
                        child: Image(
                          image: AssetImage(
                            'assets/burger-hungry.gif',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Featured',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimationLimiter(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: documents.length,
                    padding: EdgeInsets.all(2.0),
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 2,
                        duration: const Duration(milliseconds: 375),
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                if (snapshot.data?.docs[index].id != null ||
                                    documents[index]['name'] != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return VendorMenuScreen(
                                          vendorId:
                                              snapshot.data!.docs[index].id,
                                          vendorName: documents[index]['name'],
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  width: (width / 2) - 15,
                                  height: height * 0.04,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        documents[index]['profile_pic'] ??
                                            'https://i.pinimg.com/564x/b7/4a/64/b74a649b1c6320fb87181d215b19d86e.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            15.0,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // Text(
                                            //   documents[index].id ?? '',
                                            //   style: TextStyle(
                                            //     fontSize: 23,
                                            //     fontWeight: FontWeight.w500,
                                            //     color: Colors.white,
                                            //   ),
                                            // ),
                                            Text(
                                              documents[index]['name'] ?? '',
                                              style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ), /* add child content here */
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
