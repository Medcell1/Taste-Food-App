import 'package:admin_taste/Reusables/Reusablefield.dart';
import 'package:admin_taste/Screens/pages(vendor_admin)/SignUpPage.dart';
import 'package:admin_taste/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../provider/providers.dart';
import 'admin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ScaffoldMessengerState? snackBar;
  String email = '';
  String password = '';
  bool isLoading = false;
  bool visibilitySecure2 = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    snackBar = ScaffoldMessenger.of(context);
  }

  @override
  void dispose() {
    snackBar?.removeCurrentSnackBar();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.13,
            ),
            Column(
              children: [
                Image.asset(
                  'assets/logobig.png',
                  scale: 2.2,
                  color: Colors.teal,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Sign In to CT_Taste',
                  style: kLogpagetop.copyWith(fontSize: 30, color: Colors.teal),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'New Here?',
                      style: kLogpagetop.copyWith(
                          color: Colors.grey, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Create an Account',
                        style: kLogpagetop.copyWith(
                            color: Color(0xFF83673D), fontSize: 20),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 60,
            ),
            ReusableField(
              obscureText: false,
              one: 'Email',
              three: '',
              two: '',
              onSaved: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ReusableField(
              obscureText: visibilitySecure2,
              prefixIcon: InkWell(
                onTap: () {
                  visibilitySecure2 = !visibilitySecure2;
                  setState(() {});
                },
                child: visibilitySecure2
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
              inputType: TextInputType.visiblePassword,
              one: 'Password',
              three: '',
              two: '',
              onSaved: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 60,
              width: 200,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.teal,
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  String res =
                      await AuthServices().logInUser(email, password, context);
                  await Provider.of<MenuProvider>(context, listen: false)
                      .getUserInfo();
                  if (res == 'Successful') {
                    snackBar!.showSnackBar(
                      SnackBar(
                        content: Text('Login Successful'),
                      ),
                    );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => AdminPage()),
                        (route) => false);
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  }
                  setState(() {
                    isLoading = false;
                  });
                },
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
