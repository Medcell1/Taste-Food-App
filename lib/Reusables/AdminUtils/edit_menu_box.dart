import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../Screens/pages(vendor_admin)/menu_page.dart';
import '../../provider/providers.dart';
import 'menu_field.dart';

class EditMenuBox extends StatefulWidget {
  final dynamic menuModel;
  final String menuId;
  EditMenuBox({
    Key? key,
    this.menuModel,
    required this.menuId,
  }) : super(key: key);

  @override
  State<EditMenuBox> createState() => _EditMenuBoxState();
}

class _EditMenuBoxState extends State<EditMenuBox> {
  TextEditingController priceController = TextEditingController();
  TextEditingController foodNameController = TextEditingController();
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
      content: Builder(
        builder: (context) {
          return SizedBox(
            height: height * 0.5,
            child: Column(
              children: [
                Text('Create Menu'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MenuField(
                      controller: foodNameController,
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
                      height: 20,
                    ),
                    MenuField(
                      controller: priceController,
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
                      height: 20,
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
                                    mp.editPickImage();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100
                                          .withOpacity(0.78),
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
                          child: Container(
                            height: 40,
                            width: 700,
                            child: TextFormField(
                              onSaved: (value) {
                                mp.editImageController.text = value!;
                              },
                              controller: mp.editImageController,
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
                        mp.editImageController.clear();
                        foodNameController.clear();
                        priceController.clear();
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
                        if (mp.editImageController.text.isNotEmpty &&
                            foodNameController.text.isNotEmpty &&
                            priceController.text.isNotEmpty) {
                          setState(
                            () {
                              isLoading = true;
                            },
                          );
                          await mp.updateMenuItem(
                            context,
                            DateTime.now(),
                            FirebaseAuth.instance.currentUser!.uid,
                            foodNameController.text,
                            priceController.text,
                            widget.menuId,
                          );
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'You have edited this Menu!',
                              customAsset: 'assets/success.gif');
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
          );
        },
      ),
    );
  }
}
