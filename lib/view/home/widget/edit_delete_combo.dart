import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/student/student_model.dart';
import '../../add_student/screen_add_student.dart';

class EditDeleteCombo extends StatelessWidget {
  const EditDeleteCombo({super.key, required this.student});
  final Student student;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Get.to(
                  ScreenAddStudent(
                      operation: StudentOperation.Edit, student: student),
                  transition: Transition.circularReveal);
            },
            icon: Icon(
              CupertinoIcons.pencil,
              size: 30,
              color: Colors.grey[900],
            )),
        IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Delete Student',
                middleTextStyle: TextStyle(color: Colors.black),
                middleText: 'Are you sure to delete the student?',
                onConfirm: () {
                  studentController.deleteStudent(student.id);
                  Get.back();
                },
                onCancel: () {},
              );
            },
            icon: Icon(
              CupertinoIcons.delete,
              color: Colors.grey[900],
            ))
      ],
    );
  }
}
