import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_database_getx/view/add_student/widgets/add.dart';

import '../../../condroller/getx/student_controller.dart';
import '../../../model/student/student_model.dart';
import '../../home/screen_home.dart';
import '../screen_add_student.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.width,
    required this.formKey,
    required this.nameController,
    required this.placeController,
    required this.ageController,
    required this.mobileController,
    required this.student,
    required this.studentController,
    required this.operation,
  });

  final double width;
  final StudentOperation operation;
  final StudentController studentController;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController placeController;
  final TextEditingController ageController;
  final TextEditingController mobileController;
  final Student? student;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width - 100,
      child:
       ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            final name = nameController.text;
            final place = placeController.text;
            final age = ageController.text;
            final mobile = mobileController.text;
            final student = Student(
              id: operation == StudentOperation.Edit ? this.student!.id : 0,
              name: name,
              place: place,
              age: age,
              mobile: mobile,
              image: studentController.imagePath.value,
            );
            operation == StudentOperation.Add
                ? studentController.addStudent(student)
                : studentController.updateStudent(student);
            Get.offAll(const ScreenHome());
          }
        },
        child: operation == StudentOperation.Add
            ? const Text('Save')
            : const Text('Update')
      ),
    );
  }
}
