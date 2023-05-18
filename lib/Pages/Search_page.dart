import 'package:flutter/material.dart';

import '../constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  List<String> currentList = [];
  List<String> searchList = [];

  @override
  Widget build(BuildContext context) {
    // if (controller.text.isEmpty) {
    //   currentList = storeNames;
    // } else {
    //   currentList = storeNames
    //       .where((element) => element.contains(controller.text.toLowerCase()))
    //       .toList();
    //   // currentList = storeNames;
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE9B668),
        toolbarHeight: 70,
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search for Food in Funaab',
          ),
          onChanged: (String? val) {
            if (controller.text.isEmpty) {
              currentList = storeNames;
            } else {
              currentList = storeNames
                  .where((element) => element
                      .toString()
                      .toLowerCase()
                      .contains(controller.text.toLowerCase()))
                  .toList();
              // currentList = storeNames;
            }
            print("====SEARCH_LIST=====> $currentList");
            setState(() {});
            print("ListLength => ${currentList.length}");
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 1.2,
                  // crossAxisSpacing: 5.0,
                  mainAxisSpacing: 20,
                ),
                itemCount: currentList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          networkStores[index],
                        ),
                        fit: BoxFit.cover,
                      ),
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return restaurantPages[index];
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 70,
                            width: 910,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.grey.shade100,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  currentList[index],
                                  style: TextStyle(
                                    color: Colors.yellow.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                storeDetails[index],
                              ],
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
        ),
      ),
    );
  }
}
