import 'package:classinsight/Services/Database_Service.dart';
import 'package:classinsight/models/StudentModel.dart';
import 'package:classinsight/utils/AppColors.dart';
import 'package:classinsight/utils/fontStyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  TextEditingController datepicker = TextEditingController();
  RxList<Student> studentsList = RxList<Student>();
  RxString selectedHeaderValue = ''.obs;
  String schoolId = 'buwF2J4lkLCdIVrHfgkP';

  Future<void> fetchStudents() async {
    studentsList.value = await Database_Service.getStudentsOfASpecificClass(schoolId, '1-A');
  }

  void updateRowSelection(int index, String value) {
    studentsList[index].attendance[datepicker.text] = value;
    studentsList.refresh();
    _updateHeaderValue();
  }

  void updateColumnSelection(String value) {
    for (var student in studentsList) {
      student.attendance[datepicker.text] = value;
    }
    studentsList.refresh();
    selectedHeaderValue.value = value;
  }

  void _updateHeaderValue() {
    var values = studentsList.map((student) => student.attendance[datepicker.text]).toSet();
    if (values.length == 1) {
      selectedHeaderValue.value = values.first!;
    } else {
      selectedHeaderValue.value = '';
    }
  }

  Map<String, String> getStudentStatusMap() {
    Map<String, String> studentStatusMap = {};
    for (var student in studentsList) {
      studentStatusMap[student.studentID] = student.attendance[datepicker.text] ?? '';
    }
    return studentStatusMap;
  }

}

class MarkAttendance extends StatelessWidget {
  MarkAttendance({super.key});
  final AttendanceController controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Attendance', style: Font_Styles.labelHeadingRegular(context)),
        actions: [
          TextButton(
            onPressed: () async {
              await Database_Service.updateAttendance(controller.schoolId,controller.getStudentStatusMap(),controller.datepicker.text);
            },
            child: Text('Submit', style: Font_Styles.labelHeadingRegular(context, color: Colors.black)),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Text('Students', style: Font_Styles.mediumHeadingBold(context, color: Colors.black)),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: TextField(
              controller: controller.datepicker,
              readOnly: true,
              decoration: InputDecoration(
                label: Text('Select Date', style: Font_Styles.labelHeadingRegular(context, color: Colors.black)),
                suffixIcon: Icon(FontAwesomeIcons.calendarDay),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Expanded(
            child: FutureBuilder<void>(
              future: controller.fetchStudents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading students', style: Font_Styles.labelHeadingRegular(context)));
                } else {
                  return Obx(() {
                    if (controller.studentsList.isEmpty) {
                      return Center(child: Text('No students found', style: Font_Styles.labelHeadingRegular(context)));
                    } else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            dataRowColor: MaterialStateColor.resolveWith((states) => AppColors.appDarkBlue),
                            columns: [
                              DataColumn(
                                label: Text("Roll No", style: Font_Styles.labelHeadingRegular(context)),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text("Student Name", style: Font_Styles.labelHeadingRegular(context)),
                              ),
                              DataColumn(
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Present", style: Font_Styles.labelHeadingRegular(context)),
                                    Obx(() => Radio<String>(
                                      value: 'Present',
                                      groupValue: controller.selectedHeaderValue.value,
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.updateColumnSelection(value);
                                        }
                                      },
                                    )),
                                  ],
                                ),
                              ),
                              DataColumn(
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Absent", style: Font_Styles.labelHeadingRegular(context)),
                                    Obx(() => Radio<String>(
                                      value: 'Absent',
                                      groupValue: controller.selectedHeaderValue.value,
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.updateColumnSelection(value);
                                        }
                                      },
                                    )),
                                  ],
                                ),
                              ),
                              DataColumn(
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Leave", style: Font_Styles.labelHeadingRegular(context)),
                                    Obx(() => Radio<String>(
                                      value: 'Leave',
                                      groupValue: controller.selectedHeaderValue.value,
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.updateColumnSelection(value);
                                        }
                                      },
                                    )),
                                  ],
                                ),
                              ),
                            ],
                            rows: controller.studentsList.asMap().entries.map((entry) {
                              int index = entry.key;
                              Student student = entry.value;
                              return DataRow(
                                cells: [
                                  DataCell(Text(student.studentRollNo)),
                                  DataCell(Text(student.name)),
                                  DataCell(
                                    Radio<String>(
                                      value: 'Present',
                                      groupValue: student.attendance[controller.datepicker.text],
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.updateRowSelection(index, value);
                                        }
                                      },
                                    ),
                                  ),
                                  DataCell(
                                    Radio<String>(
                                      value: 'Absent',
                                      groupValue: student.attendance[controller.datepicker.text],
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.updateRowSelection(index, value);
                                        }
                                      },
                                    ),
                                  ),
                                  DataCell(
                                    Radio<String>(
                                      value: 'Leave',
                                      groupValue: student.attendance[controller.datepicker.text],
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.updateRowSelection(index, value);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.datepicker.text = "${picked.toLocal()}".split(' ')[0];
    }
  }
}