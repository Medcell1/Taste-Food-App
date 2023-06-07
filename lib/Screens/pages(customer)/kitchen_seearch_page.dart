import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'menu_page.dart';

class KitchenSearchPage extends StatefulWidget {
  const KitchenSearchPage({Key? key}) : super(key: key);

  @override
  State<KitchenSearchPage> createState() => _KitchenSearchPageState();
}

class _KitchenSearchPageState extends State<KitchenSearchPage> {
  Stream<QuerySnapshot>? stream;
  @override
  void initState() {
    stream = FirebaseFirestore.instance.collection('users').snapshots();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                height: height * 0.9,
                child: Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    size: 50,
                    color: Colors.black,
                  ),
                ),
              );
            }
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Column(
              children: [
                SizedBox(
                  height: height * 0.06,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              stream = FirebaseFirestore.instance
                                  .collection('users')
                                  .snapshots();
                            } else {
                              print('$stream---->>>>before');
                              stream = FirebaseFirestore.instance
                                  .collection('users')
                                  .where('name', isGreaterThan: value)
                                  .where('name', isLessThan: '$value\uf8ff')
                                  .snapshots();
                              print('$stream---->>>>after');
                            }
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search For Kitchens',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
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
                                          vendorNumber: documents[index]
                                              ['phone_number'],
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
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
                                            Text(
                                              documents[index]['name'] ?? '',
                                              style: TextStyle(
                                                fontSize: 20,
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
