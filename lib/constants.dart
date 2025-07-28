import 'package:flutter/material.dart';

/// Navigator Key
final navigatorKey = GlobalKey<NavigatorState>();

/// Default padding
const double kDefaultPadding = 12;
const double kFieldsPadding = 12;

/// Urls
const String kMyWebsiteUrl = 'https://devgero.com';
const String kProjectsUrl = '$kMyWebsiteUrl/proyectos';
const String kAlbumsUrl = 'https://jsonplaceholder.typicode.com/albums';

/// Colors
const Color kPrimaryColor = Colors.blue;
const Color kBackgroundColor = Color(0xFFF8F8F8);
const Color kDarkGreyColor = Color(0xFF222222);

/// Text Styles
const kHeader1TextStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
const kButtonTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

/// List
final List<String> kItemsList = List.generate(4, (index) => 'Item $index');
