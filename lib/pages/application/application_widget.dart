// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';

Widget buildPage(int index){

  List<Widget> _widget = [
    Center(child: Text('Home')),
    Center(child: Text('Search')),
    Center(child: Text('Course')),
    Center(child: Text('Chat')),
    Center(child: Text('Profile')),
  ];

  return _widget[index];
}