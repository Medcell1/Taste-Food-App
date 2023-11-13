import 'dart:io';

import 'package:admin_taste/Screens/pages(vendor_admin)/Login_Page.dart';
import 'package:admin_taste/Screens/pages(vendor_admin)/admin_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

import '../../Reusables/Reusablefield.dart';
import '../../constants.dart';
import '../../services/authentication_service.dart';

XFile? file;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ScaffoldMessengerState? snackBar;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    snackBar = ScaffoldMessenger.of(context);
  }

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String email = '';
  String password = '';
  String number = '';
  String name = '';
  String imageUrl = '';
  bool isChecked = false;
  bool _visibilitySecure2 = true;
  TextEditingController imageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  uploadImage() async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    Reference root = FirebaseStorage.instance.ref();
    Reference dirImages = root.child('images');
    Reference uploadImage = dirImages.child(fileName);
    try {
      await uploadImage.putFile(File(file!.path));
      await uploadImage.getDownloadURL();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
            backgroundColor:  Color(0xff1C172B) ,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      color:  Color(0xff0DF5E3),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 20, left: 20),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Icon(Icons.arrow_back),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Image.asset(
                            'assets/logobig.png',
                            scale: 1.5,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Welcome to CTtaste',
                            style: kLogpagetop.copyWith(
                              color: Colors.black
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'No 1 Food Ordering platform',
                            style: kLogpagesec.copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          Text(
                            'for students',
                            style: kLogpagesec.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Create an Account',
                      style: logpagethird.copyWith(
                        color:Colors.white ,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFADA8A6),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Sign in here',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text(
                          'Sign in with Google',
                          style: logpagefourth,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: Divider(
                                color: Color(0xFFADA8A6),
                                height: 36,
                              )),
                        ),
                        Text("OR" , style: TextStyle(color: Colors.white),) ,
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Colors.white,
                              height: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ReusableField(
                      obscureText: false,
                      onSaved: (value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please Enter Restaurant Name';
                        } else {
                          return null;
                        }
                      },
                      text: 'KITCHEN NAME',
                      prefixIcon: Icon(Icons.person_2_outlined),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ReusableField(
                      obscureText: false,
                      onSaved: (value) {
                        email = value;
                      },
                      controller: emailController,
                      validator: (value) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)
                            ? null
                            : 'Please enter a valid email';
                      },
                      text: 'EMAIL',
                      prefixIcon: Icon(Icons.mail),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ReusableField(
                      obscureText: false,
                      validator: (value) {
                        if (value == null) {
                          return 'Enter a Phone Number';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        number = value;
                      },
                      text: 'PHONE',
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Colors.white,
                      ),
                    ),

                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            cursorHeight: 18,
                            cursorColor: Colors.white,
                            controller: imageController,
                            onSaved: (value) {
                              imageController.text = value!;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 18,
                                height: 4,
                              ),
                              prefixIcon: Icon(Icons.image, color: Colors.white,),
                              suffix: InkWell(
                                onTap: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  file = await imagePicker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (file == null) return;
                                  String url = file!.path.toString();
                                  print('$url>>>>>>>>');
                                  setState(() {
                                    imageController.text = url;
                                  });
                                },
                                child: Container(
                                  height: 25,
                                  width: 70,
                                  color: Colors.teal,
                                  child: Center(child: Text('Choose' , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
                                ),
                              ),
                              labelText: 'DISPLAY IMAGE',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        cursorHeight: 18,
                        cursorColor: Colors.white,
                        controller: passwordController,
                        onChanged: (value) {
                          password = value;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        // keyboardType: TextInputType.none,
                        obscureText: _visibilitySecure2,
                        validator: (value) {
                          if (value!.length < 6 || value == null) {
                            return 'Password must be at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 18,
                            height: 4,
                          ),
                          prefixIcon: InkWell(
                              onTap: () {
                                _visibilitySecure2 = !_visibilitySecure2;
                                setState(() {});
                              },
                              child: _visibilitySecure2
                                  ? Icon(Icons.visibility_off, color: Colors.white,)
                                  : Icon(Icons.visibility, color: Colors.white,),),

                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,

                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              thickness: 4,
                              height: 36,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)),
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              thickness: 4,
                              height: 36,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade100.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)),
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              thickness: 4,
                              height: 36,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              thickness: 4,
                              height: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'Use 8 or more characters with a mix of letters, numbers & symbols.',
                        style: TextStyle(
                          color: Color(0xFFADA8A6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            isChecked = !isChecked;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.tealAccent,
                            ),
                            child: Visibility(
                                visible: isChecked,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'I Agree to the',
                          style: logpagefifth.copyWith(
                            color:  Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Terms and Condition',
                          style: logpagesixth,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        AuthServices auth = AuthServices();
                        setState(() {
                          isLoading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (file != null) {
                            String fileName = DateTime.now()
                                .microsecondsSinceEpoch
                                .toString();
                            Reference root = FirebaseStorage.instance.ref();
                            Reference dirImages = root.child('images');
                            Reference uploadImage = dirImages.child(fileName);
                            try {
                              await uploadImage.putFile(File(file!.path));
                            } catch (e) {
                              print(e);
                            }
                            imageUrl = await uploadImage.getDownloadURL();
                          }
                          await auth.signUpUser(
                              name, email, password, number, imageUrl, context);
                          snackBar!.showSnackBar(
                            SnackBar(
                              content: Text('Registration Successful'),
                            ),
                          );
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return AdminPage();
                          }), (route) => false);
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                          color:  Color(0xff0DF5E3),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Create Account',
                                  style: logpageseventh,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
      ),
    );

  }
}

