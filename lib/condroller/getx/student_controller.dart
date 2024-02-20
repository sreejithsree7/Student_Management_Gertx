import 'package:get/get.dart';

import '../../model/student/student_model.dart';
import '../db_services/student_db_services.dart';
import '../functions/show_failure_message.dart';
import '../functions/show_success_message.dart';


class StudentController extends GetxController {
  final studentServices = StudentServices();
  RxList<Student> students = <Student>[].obs;
  RxString imagePath = ''.obs;

  void setImage(String image) {
    imagePath.value = image;
  }

  getAllStudents() async {
    List<Student> list = await studentServices.getStudents();
    students.assignAll(list);
  }

  addStudent(Student student) async {
    await studentServices.insert(student).then((value) {
      getAllStudents();
      if (value > 0) {
        showSuccessMessage('Inserted', 'Student inserted successfully');
      } else {
        showFailureMessage('Not inserted', 'Unable to insert student');
      }
    });
  }

  updateStudent(Student student) async {
    await studentServices.update(student).then((value) {
      if (value > 0) {
        showSuccessMessage('Updated', "Student updated successfully");
      } else {
        showFailureMessage('Not updated', 'Unable to update student');
      }
      getAllStudents();
    });
  }
  deleteStudent(int id) async {
    await studentServices.delete(id).then((value) {
      if (value > 0) {
        showSuccessMessage('Deleted', "Student deleted successfully");
      } else {
        showFailureMessage('Not deleted', 'Unable to delete student');
      }
      getAllStudents();
    });
  }

  searchResult(String query) async {
    List<Student> list = await studentServices.getStudents();
    List<Student> filteredList = list
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    students.assignAll(filteredList);
  }
}