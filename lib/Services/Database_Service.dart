import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:classinsight/Model/StudentModel.dart';

class Database_Service {
  static Future<void> saveStudent(String school, Student student) async {
    try {
      // Reference to the school's collection of students
      CollectionReference studentsRef = FirebaseFirestore.instance
          .collection('Schools')
          .doc(school)
          .collection('Students');

      // Generate a new document reference
      DocumentReference docRef = studentsRef.doc();

      // Set the studentID to the document's ID
      student.studentID = docRef.id;

      // Save student data to Firestore
      await docRef.set({
        'Name': student.name,
        'Gender': student.gender,
        'BForm_challanId': student.bForm_challanId,
        'FatherName': student.fatherName,
        'FatherPhoneNo': student.fatherPhoneNo,
        'FatherCNIC': student.fatherCNIC,
        'StudentRollNo': student.studentRollNo,
        'StudentID': student.studentID,
        'ClassSection': student.classSection,
      });
    } catch (e) {
      print('Error saving student: $e');
    }
  }

  static Future<List<Student>> getAllStudents(String school) async {
    List<Student> students = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Schools')
          .doc(school)
          .collection('Students')
          .get();

      for (var doc in querySnapshot.docs) {
        students.add(Student.fromJson(doc.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print('Error getting students: $e');
    }
    return students;
  }

  static Future<List<Student>> getStudentsOfASpecificClass(String school, 
      String classSection) async {
    List<Student> students = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Schools')
          .doc(school)
          .collection('Students')
          .where('ClassSection', isEqualTo: classSection)
          .get();

      for (var doc in querySnapshot.docs) {
        students.add(Student.fromJson(doc.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print('Error getting students of class $classSection: $e');
    }
    return students;
  }
}
