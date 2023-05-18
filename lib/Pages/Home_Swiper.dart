import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Swiper(
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return PageSwiper(
              index: index,
            );
          },
          itemCount: 3,
          pagination: SwiperPagination(),
          control: SwiperControl(color: Colors.transparent),
        ),
      ),
    );
  }
}
