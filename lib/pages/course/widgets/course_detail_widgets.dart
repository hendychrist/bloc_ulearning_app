import 'package:flutter/material.dart';
import 'package:ulearning_app/common/widget/base_text_widget.dart';

AppBar buildAppBarCourse(){
  return AppBar(
    centerTitle: true,
    title: reusableText("Course Detail")
  );
}