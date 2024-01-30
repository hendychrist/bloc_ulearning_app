import 'package:flutter/material.dart';
import 'package:ulearning_app/pages/course/widgets/course_detail_widgets.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late Map id;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    id = ModalRoute.of(context)!.settings.arguments as Map;
    // print(id.values);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyan,
        appBar: buildAppBarCourse(),
        body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Text('${id.values}'),
        ),

      ),
    );
  }
}