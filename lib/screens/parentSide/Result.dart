import 'package:classinsight/firebase_options.dart';
import 'package:get/get.dart';
import 'package:classinsight/Services/Database_Service.dart';
import 'package:classinsight/models/StudentModel.dart';
import 'package:classinsight/utils/AppColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Controller for managing student results
class ResultController extends GetxController {
  var student = Student(
    name: '',
    gender: '',
    bFormChallanId: '',
    fatherName: '',
    fatherPhoneNo: '',
    fatherCNIC: '',
    studentID: '',
    classSection: '',
    feeStatus: '',
    feeStartDate: '',
    feeEndDate: '',
    studentRollNo: '',
  ).obs;
  var examsList = <String>[].obs;
  var subjectsList = <String>[].obs;
  var resultMap = <String, Map<String, String>>{}.obs;
  var isLoading = true.obs;
  final String schoolId;

  ResultController(this.schoolId);

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void setStudent(Student newStudent) {
    student.value = newStudent;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      examsList.value = await Database_Service()
          .fetchExamStructure(schoolId, student.value.classSection);
      subjectsList.value = await Database_Service.fetchSubjects(
          schoolId, student.value.classSection);
      resultMap.value = await Database_Service()
          .fetchStudentResultMap(schoolId, student.value.studentID);
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Result(),
    );
  }
}

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments
    final arguments = Get.arguments as Map<String, dynamic>;
    final Student student = arguments['student'];
    final String schoolId = arguments['schoolId'];

    // Initialize the ResultController with schoolId
    final ResultController controller = Get.put(ResultController(schoolId));
    controller.setStudent(student);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.appOrange),
            ),
          );
        } else {
          // Debug prints to check data
          print('Student: ${controller.student.value}');
          print('Exams List: ${controller.examsList}');
          print('Subjects List: ${controller.subjectsList}');
          print('Result Map: ${controller.resultMap}');
          print('School ID: $schoolId');

          double screenHeight = MediaQuery.of(context).size.height;
          double screenWidth = MediaQuery.of(context).size.width;

          double resultFontSize = screenWidth < 350
              ? (screenWidth < 300 ? (screenWidth < 250 ? 11 : 14) : 14)
              : 16;
          double headingFontSize = screenWidth < 350
              ? (screenWidth < 300 ? (screenWidth < 250 ? 20 : 23) : 25)
              : 33;

          return SingleChildScrollView(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.10,
                      width: screenWidth,
                      child: AppBar(
                        elevation: 0,
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        title: Center(
                          child: Text(
                            'Result',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: resultFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          Container(
                            width: 48.0, // Adjust as needed
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.05 * screenHeight,
                      width: screenWidth,
                      margin: EdgeInsets.only(bottom: 10.0),
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        controller.student.value.name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: headingFontSize,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(() {
                        List<String> exams = controller.examsList;
                        List<String> subjects = controller.subjectsList;
                        Map<String, Map<String, String>> resultMap = controller.resultMap;

                        return DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'Subjects',
                                style: TextStyle(
                                  fontSize: resultFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ...exams.map((exam) => DataColumn(
                                  label: Text(
                                    exam,
                                    style: TextStyle(
                                      fontSize: resultFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            DataColumn(
                              label: Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: resultFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Grade',
                                style: TextStyle(
                                  fontSize: resultFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          rows: subjects.map(
                            (subject) => DataRow(
                              color: MaterialStateColor.resolveWith(
                                  (states) => AppColors.appOrange),
                              cells: [
                                DataCell(Text(
                                  subject,
                                  style: TextStyle(
                                    fontSize: resultFontSize,
                                  ),
                                )),
                                ...exams.map((exam) => DataCell(Text(
                                      resultMap[subject]?[exam] ?? '-',
                                      style: TextStyle(
                                        fontSize: resultFontSize,
                                      ),
                                    ))),
                                DataCell(Text(
                                  '-', // Placeholder for Total
                                  style: TextStyle(
                                    fontSize: resultFontSize,
                                  ),
                                )),
                                DataCell(Text(
                                  '-', // Placeholder for Grade
                                  style: TextStyle(
                                    fontSize: resultFontSize,
                                  ),
                                )),
                              ],
                            ),
                          ).toList(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}