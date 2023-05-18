import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Pages/Hand_Of_God.dart';
import 'Pages/Sans_Buka.dart';
import 'Pages/cart_page.dart';
import 'Reusables/Reusable_Text.dart';

var fontStyle = GoogleFonts.notoSans();
const khomepagestyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontFamily: 'Ubuntu',
);
const khomepagetop = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold);
const kLogpagetop = TextStyle(
  color: Colors.white,
  fontSize: 27,
  fontWeight: FontWeight.bold,
  fontFamily: 'Ubuntu',
);
const kLogpagesec = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold);
const khomepagemid = TextStyle(
    color: Colors.yellow,
    fontSize: 92,
    fontFamily: 'Script',
    fontWeight: FontWeight.bold);
const logpagethird = TextStyle(
    color: Colors.black,
    fontSize: 25,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold);
const logpagefourth = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold);
const logpagefifth = TextStyle(
    color: Colors.black,
    fontSize: 17,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold);
const logpagesixth = TextStyle(
    color: Colors.teal,
    fontSize: 17,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold);
const logpageseventh = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold);

List<String> storeNames = [
  'Hand of God',
  'Boripe Foods',
  'Sans Buka',
  'Mhunis Delicacies',
  'Bee Spicy',
  'Bellefullria',
  'Dalish',
  'Orombos',
  'Tudeetops Food',
  'Mayor Toasts',
  'Dammy Nuts',
  "Keizah's Shawarma",
  'Treats by Edna',
  'Mhiewah Cakes',
  'Fheith cakes',
  'Tee Sauce',
  "Bim's delicious",
  "Nkem's Kitchen",
  'Perry_Lucious',
  'Precify Treat',
];

final List networkStores = [
  'https://cttaste.com/cttaste_files/public/profilePic/hand.png',
  'https://cttaste.com/cttaste_files/public/profilePic/UZoxhZypNqNzDfVditfIodUPArpayaST3Df01Zct.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/XbnmBgeHCw5b93xCryA2F2azdkh3oAyL2d8vjHQ0.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/FkrrRsVfM7bptOnY1PTYalSDtCK7mjgbtFGcu3N4.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/wECXfFRR43rcBpJ9vZ5L6Puvc11eA23IQsUzQWdz.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/T5isQILP7kckHz0N6opaoRPVPj3FXVV7r3uRtZlA.png',
  'https://cttaste.com/cttaste_files/public/profilePic/dalish.jpeg',
  'https://cttaste.com/cttaste_files/public/profilePic/ueP23T9oXbd0cCzs0PwNJVpAqs986xB4FFETr7X2.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/glOhcihWovSq4OlOfuh0kD3ZTm7qtL6T2M7PtuAp.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/s76mzbv3TKvyHy8ImHuvkOCEE8lKtPJdyrzaa1Ew.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/wHeeHshFUyIxyekvTwXjzmYJOMGlT1xQwjmSh29E.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/TdsUBYHyengZiXXkyi4UrQwrsJ0Psrd9TrOigydK.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/Qk5M6gdneUwns0oNyvcyi458muwg05yhjqVUihC1.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/IBiuaSrOrHjbPtUYHbV5Pc8WszJ2q3X5UwRsw0iI.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/tHLpWDxX2iDdlcDjlXE1nmyO8xjWiqXMK6K5iPSY.webp',
  'https://cttaste.com/cttaste_files/public/profilePic/dtM8XivrOJzpmqXesI5e1YGUlRWUr6LhHyevgX43.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/oLxSSAJKftasXKv4kJDOtwBzDrgueYuAy0eqyGVt.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/iGPadC4QciY8I1Ahb06ocR7tWw4gMlpNd8MxiMd6.jpg',
  'https://cttaste.com/cttaste_files/public/profilePic/iAxfPhxut9aujAmunXqpGb5VBiRDN0LAuaFgHNDa.png',
  'https://cttaste.com/cttaste_files/public/profilePic/UDNI8xVfZGXMJNxQtUcRaCZcX3qd1ogqmyRO46no.png',
];

List storeDetails = [
  ReusableText(
    // one: 'Hand Of God',
    two: 'Rice, Bread, Beans and',
    three: 'Swallow',
  ),
  ReusableText(
    // one: 'Boripe Foods',
    two: 'Rice, Bread, Beans and',
    three: 'Swallow',
  ),
  ReusableText(
    // one: 'Sans Buka',
    two: 'Rice and Swallow',
    three: '',
  ),
  ReusableText(
    // one: 'Mhunis Delicacies',
    two: 'Rice, Yam, Porridge and',
    three: 'Pasta',
  ),
  ReusableText(
    // one: 'Bee Spicy',
    two: 'Amala joint and others',
    three: '',
  ),
  ReusableText(
    // one: 'Bellefullria',
    two: 'Rice, Yam, Porridge and',
    three: 'Burger',
  ),
  // ReusableText(
  //   one: 'Hand Of God',
  //   two: 'Rice, Bread, Beans and',
  //   three: 'Swallow',
  // ),
  ReusableText(
    // one: 'Dalish',
    two: 'Rice and Swallow',
    three: '',
  ),
  ReusableText(
    // one: 'Orombos',
    two: 'White Rice and Beans',
    three: '',
  ),
  ReusableText(
    // one: 'Tudeetops Food',
    two: 'Rice and Swallow',
    three: '',
  ),
  ReusableText(
    // one: 'Mayor Toasts',
    two: 'Toast Bread with Milk',
    three: '',
  ),
  ReusableText(
    // one: 'Dammy Nuts',
    two: 'Nuts, Peanuts and ',
    three: 'Candied Nuts',
  ),
  ReusableText(
    // one: "Keziah's Shawarma",
    two: 'Shawarma and Pizza',
    three: '',
  ),
  ReusableText(
    // one: 'Treats by Edna',
    two: 'Tapioka',
    three: '',
  ),
  ReusableText(
    // one: 'Mhiewah Cakes',
    two: 'Cakes and Pasteries',
    three: '',
  ),
  ReusableText(
    // one: 'Fheith cakes',
    two: 'Cakes and Pastries',
    three: '',
  ),
  ReusableText(
    // one: 'Tee Sauce',
    two: 'Chicken and Fish ',
    three: 'Peppersoup',
  ),
  ReusableText(
    // one: "Bim's delicious",
    two: 'Wankye Rice',
    three: '',
  ),
  ReusableText(
    // one: "Nkem's Kitchen",
    two: 'Fish and Chicken',
    three: 'Peppersoup',
  ),
  ReusableText(
    // one: 'Perry_luscious',
    two: 'Chops and Mocktails',
    three: '',
  ),

  ReusableText(
    // one: "Precify's Treat",
    two: 'Smoothies',
    three: '',
  ),
];
final List restaurantPages = [
  HandOfGod(),
  CartPage(),
  Sans(),
];
