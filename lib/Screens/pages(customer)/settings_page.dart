import 'package:admin_taste/provider/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  final dynamic onchanged;
  final dynamic value;

  const SettingsPage({super.key, this.onchanged, this.value});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, child) {
        final isDark = box.get('isDark', defaultValue: false);
        return Scaffold(
            backgroundColor: isDark ? Color(0xff212121) : Colors.white,
            appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                backgroundColor: isDark ? Color(0xff212121) : Colors.white,
                title: isDark
                    ? Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Settings',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5.0),
                  child: SizedBox(
                    height: height / 10,
                    child: Card(
                      color: isDark ? Color(0xff212121) : Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isDark
                              ? Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Switch to LightMode',
                                    style: TextStyle(color: Colors.white, fontSize: 19),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Switch to DarkMode',
                                    style: TextStyle(color: Colors.black , fontSize: 19),
                                  ),
                                ),
                          CupertinoSwitch(
                            value: isDark,
                            onChanged: (val) {
                              box.put('isDark', val);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
