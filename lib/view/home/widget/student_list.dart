import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../add_student/screen_add_student.dart';
import '../../view_student/screen_view_student.dart';
import 'edit_delete_combo.dart';

class StudentListWidget extends StatelessWidget {
  const StudentListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        final student = studentController.students[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: FileImage(File(student.image)),
          ),
          title: Text(student.name),
          subtitle: Text(student.place),
          trailing: SizedBox(
            width: MediaQuery.of(context).size.width * .25,
            child: EditDeleteCombo(student: student),
          ),
          onTap: () => {
            Get.to(ScreenViewStudent(student: student),
                transition: Transition.downToUp)
          },
        );
      },
      separatorBuilder: (_, index) {
        return const Divider(height: .5, thickness: 1);
      },
      itemCount: studentController.students.length,
    );
  }
}
