import 'package:admin_taste/constants.dart';
import 'package:admin_taste/provider/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/Splash_screen.dart';
import 'Screens/pages(vendor_admin)/admin_page.dart';
const darkModeBox = 'darkModeTutorial';
void main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  try {
    WidgetsFlutterBinding.ensureInitialized();

    if (kIsWeb) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constant.apikey,
            appId: Constant.appId,
            messagingSenderId: Constant.messageSenderId,
            projectId: Constant.projectId),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    print('this======> $e');
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // ThemeData lightTheme = ThemeData(
  //   primarySwatch: Colors.green,
  //   brightness: Brightness.dark,
  // );
  MyApp({super.key});
  final authChange = FirebaseAuth.instance.authStateChanges();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WhatsAppProvider()),
        ChangeNotifierProvider(create: (_) => QuantityState()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context , _) {
          return ValueListenableBuilder(
            valueListenable: Hive.box('settings').listenable(),
            builder: (context, box,child) {
              final isDark = box.get('isDark' , defaultValue: false);
              return MaterialApp(
                theme: isDark ? ThemeData.dark() : ThemeData.light(),
                // themeMode: darkMode?ThemeMode.dark : ThemeMode.light,
                // darkTheme: ThemeData.dark(),
                debugShowCheckedModeBanner: false,
                home: StreamBuilder(
                  stream: authChange,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        return AdminPage();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    }
                    return Splash();
                  },
                ),
              );
            },

          );
        },
      ),
    );
  }
}
