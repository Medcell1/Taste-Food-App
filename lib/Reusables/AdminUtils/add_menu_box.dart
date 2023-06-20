import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../Screens/pages(vendor_admin)/menu_page.dart';
import '../../provider/providers.dart';
import 'menu_field.dart';

class AddMenuBox extends StatefulWidget {
  final int? number;
  AddMenuBox({Key? key, this.number}) : super(key: key);

  @override
  State<AddMenuBox> createState() => _AddMenuBoxState();
}

class _AddMenuBoxState extends State<AddMenuBox> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    MenuProvider mp = Provider.of<MenuProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: SizedBox(
        height: height * 0.5,
        child: Column(
          children: [
            Text('Create Menu'),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MenuField(
                  controller: mp.foodNameController,
                  one: 'Name',
                  three: 'e.g fried rice, full chicken, chocolate cake',
                  two: '*',
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'Please enter a Name';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                MenuField(
                  controller: mp.priceController,
                  one: 'Price(#)',
                  three: 'Input Food Price',
                  two: '*',
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'Please enter a valid price';
                    } else {
                      return null;
                    }
                  },
                  keyType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Row(
                        children: [
                          Text(
                            'Image',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xFF3A4068),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '*',
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Material(
                            elevation: 3,
                            child: GestureDetector(
                              onTap: () {
                                mp.pickImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100.withOpacity(0.78),
                                ),
                                height: 25,
                                width: 100,
                                child: Center(
                                  child: Text(
                                    'Choose File',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: SizedBox(
                        height: 40,
                        width: 700,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Pick an Image';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            mp.imageController.text = value!;
                          },
                          controller: mp.imageController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: '',
                            hintStyle: TextStyle(
                              color: Color(0XffBCB8B2),
                              fontWeight: FontWeight.w900,
                            ),
                            filled: true,
                            fillColor: Color(0xffDCDAD7),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(scaffoldKey.currentContext!).pop();
                    mp.foodNameController.clear();
                    mp.priceController.clear();
                    mp.imageController.clear();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    height: height * 0.06,
                    width: width * 0.25,
                    child: Center(
                      child: Text(
                        'Discard',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0XffBCB8B2),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * .12,
                ),
                GestureDetector(
                  onTap: () async {
                    if (mp.foodNameController.text.isNotEmpty &&
                        mp.priceController.text.isNotEmpty &&
                        mp.imageController.text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                      await mp.addMenuItem(
                        context,
                        DateTime.now(),
                        FirebaseAuth.instance.currentUser!.uid,
                        mp.foodNameController.text,
                        mp.priceController.text,
                      );
                      QuickAlert.show(
                        confirmBtnColor: Colors.teal,
                        width: width * 0.4,
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Menu saved!',
                        customAsset: 'assets/success.gif',
                      );
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffB69C3D)),
                    height: height * 0.06,
                    width: width * 0.25,
                    child: Center(
                      child: isLoading == true
                          ? CircularProgressIndicator()
                          : Text(
                              'Submit',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white,
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
  }
}
