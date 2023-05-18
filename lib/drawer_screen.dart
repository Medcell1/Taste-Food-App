import 'package:admin_taste/Pages/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'Pages/Sans_Buka.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreenAbsorbPointer: true,
      controller: zoomDrawerController,
      menuScreen: Sans(),
      mainScreen: AdminPage(),
      mainScreenScale: 0.1,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      menuBackgroundColor: Color(0xFF554535),
      closeDragSensitivity: 100,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      style: DrawerStyle.defaultStyle,
      angle: -10,
    );
  }
}
