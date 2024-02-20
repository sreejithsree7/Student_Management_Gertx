import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database_getx/view/add_student/widgets/text_field.dart';

import '../../condroller/getx/student_controller.dart';
import '../../core/constants.dart';
import '../../model/student/student_model.dart';
import 'functions/botom_sheet.dart';
import 'widgets/save_button.dart';

enum StudentOperation { Add, Edit }

final studentController = Get.put(StudentController());

class ScreenAddStudent extends StatelessWidget {
  ScreenAddStudent({super.key, this.student, required this.operation});
  final nameController = TextEditingController();
  final placeController = TextEditingController();
  final ageController = TextEditingController();
  final mobileController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Student? student;
  StudentOperation operation;
  XFile? imagePath;

  initTextControllers() {
    if (student != null) {
      nameController.text = student!.name;
      placeController.text = student!.place;
      ageController.text = student!.age;
      mobileController.text = student!.mobile;
      studentController.imagePath.value = student!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (operation == StudentOperation.Edit) {
      initTextControllers();
    } else {
      studentController.imagePath.value =
          imagePath != null ? imagePath!.path : '';
    }
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            operation == StudentOperation.Add ? 'Add Student' : 'Edit Student',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Column(
                  children: [
                    kHight10,
                    InkWell(
                        onTap: () async {
                          imagePath = await showBottomSheetWidget();
                          if (imagePath != null) {
                            studentController.setImage(imagePath!.path);
                            Get.back();
                          }
                        },
                        child: Obx(() => CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 70,
                              child: Container(
                                // height: height * .15,
                                // width: width * .35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80),
                                    border: Border.all(width: .5),
                                    image: studentController
                                            .imagePath.value.isNotEmpty
                                        ? DecorationImage(
                                            image: FileImage(File(
                                                studentController
                                                    .imagePath.value)),
                                            fit: BoxFit.cover)
                                        : null),
                                child: studentController.imagePath.value.isEmpty
                                    ? const Center(
                                        child: Icon(
                                            CupertinoIcons.photo_on_rectangle),
                                      )
                                    : null,
                              ),
                            ))),
                    kHight50,
                    TextFieldWidget(
                      nameController: nameController,
                      text: 'Name',
                      type: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null; // Return null when the input is valid
                      },
                    ),
                    kHight20,
                    TextFieldWidget(
                      nameController: placeController,
                      text: 'Place',
                      type: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a place';
                        }
                        return null; // Return null when the input is valid
                      },
                    ),
                    kHight20,
                    TextFieldWidget(
                      nameController: ageController,
                      text: 'Age',
                      type: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Age';
                        }
                        return null; // Return null when the input is valid
                      },
                    ),
                    kHight20,
                    TextFieldWidget(
                      nameController: mobileController,
                      text: 'Mobile No',
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Mobile No';
                        }
                        return null; // Return null when the input is valid
                      },
                    ),
                    kHight20,
                    SaveButton(
                      width: width,
                      formKey: formKey,
                      nameController: nameController,
                      placeController: placeController,
                      ageController: ageController,
                      mobileController: mobileController,
                      student: student,
                      studentController: studentController,
                      operation: operation,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
