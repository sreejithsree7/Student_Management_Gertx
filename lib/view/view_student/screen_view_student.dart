import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_database_getx/view/add_student/widgets/add.dart';

import '../../model/student/student_model.dart';
import '../add_student/screen_add_student.dart';
import 'widgets/student_details.dart';

class ScreenViewStudent extends StatelessWidget {
  const ScreenViewStudent({super.key, required this.student});
  final Student student;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(ScreenAddStudent(
                    operation: StudentOperation.Edit, student: student));
              },
              icon: const Icon(
                CupertinoIcons.pen,
                color: Colors.white,
              )),
        ],
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: .5),
          ),
          child: StudentDetailsWidget(student: student),
        ),
      ),
    );
  }
}
