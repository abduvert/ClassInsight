// ignore_for_file: prefer_const_constructors

import 'package:classinsight/models/StudentModel.dart';
import 'package:classinsight/screens/adminSide/AdminHome.dart';
import 'package:classinsight/screens/adminSide/ManageStudents.dart';
import 'package:classinsight/utils/AppColors.dart';
import 'package:classinsight/utils/fontStyles.dart';
import 'package:flutter/material.dart';
import 'package:classinsight/widgets/CustomTextField.dart';
import 'package:classinsight/services/Database_Service.dart';
import 'package:get/get.dart';

class EditStudent extends StatelessWidget {
  final Student student;

  const EditStudent({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminHomeController school = Get.put(AdminHomeController());

    return GetBuilder<EditStudentController>(
      init: EditStudentController(
          student), // Initialize the controller with student data
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.appLightBlue,

          appBar: AppBar(
            backgroundColor: AppColors.appLightBlue,
            title: Text("Edit Student", style: Font_Styles.labelHeadingRegular(context),),
            centerTitle: true,
            actions: [
              TextButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child: Container(
                                  color: Colors.white,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                        AppColors.appLightBlue,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );

                          Map<String, dynamic> updatedData = {
                            'Name': controller.nameController.text,
                            'Gender': controller.changedGender,
                            'BForm_challanId':
                                controller.bForm_challanIdController.text,
                            'FatherName':
                                controller.fatherNameController.text,
                            'FatherPhoneNo':
                                controller.fatherPhoneNoController.text,
                            'FatherCNIC':
                                controller.fatherCNICController.text,
                            'StudentRollNo': student.studentRollNo,
                            'ClassSection': controller.changedClass,
                          };

                          print("updated data: $updatedData");

                          await Database_Service.updateStudent(
                            school.schoolId.value,
                            student.studentID,
                            updatedData,
                          ).whenComplete(() => Get.back(result: "student_added"));
                          

                          Get.back(result: "student_added");
                          Get.snackbar("Edits Saved", "Refresh to see the changes");
                          
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.appLightBlue,
                    ),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     // Padding(
                    //     //   padding: EdgeInsets.only(top: 20),
                    //     //   child: IconButton(
                    //     //     icon: const Icon(Icons.arrow_back),
                    //     //     onPressed: () {
                    //     //       Get.back();
                    //     //       // Navigator.of(context).pop();
                    //     //     },
                    //     //   ),
                    //     // ),
                    //     Padding(
                    //       padding: EdgeInsets.only(top: 20,),
                    //       child: Text(
                    //         'Edit Student',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize:
                    //               16,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(top: 20),
                    //       child: TextButton(
                    //         onPressed: () async {
                    //           showDialog(
                    //             context: context,
                    //             barrierDismissible: false,
                    //             builder: (BuildContext context) {
                    //               return Center(
                    //                 child: Container(
                    //                   color: Colors.white,
                    //                   child: Center(
                    //                     child: CircularProgressIndicator(
                    //                       valueColor:
                    //                           AlwaysStoppedAnimation<Color>(
                    //                         AppColors.appLightBlue,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //           );

                    //           Map<String, dynamic> updatedData = {
                    //             'Name': controller.nameController.text,
                    //             'Gender': controller.changedGender,
                    //             'BForm_challanId':
                    //                 controller.bForm_challanIdController.text,
                    //             'FatherName':
                    //                 controller.fatherNameController.text,
                    //             'FatherPhoneNo':
                    //                 controller.fatherPhoneNoController.text,
                    //             'FatherCNIC':
                    //                 controller.fatherCNICController.text,
                    //             'StudentRollNo': student.studentRollNo,
                    //             'ClassSection': controller.changedClass,
                    //           };

                    //           print("updated data: $updatedData");

                    //           await Database_Service.updateStudent(
                    //             school.schoolId.value,
                    //             student.studentID,
                    //             updatedData,
                    //           );

                              
                    //           Get.back();
                    //         },
                    //         child: Text(
                    //           'Save',
                    //           style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 50),
                    child: Text(
                      'Edit Student',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:
                            33,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.82 - 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.toggleEditingName();
                                      },
                                      child: controller.isEditingName
                                          ? SizedBox(
                                              width: 200,
                                              child: TextField(
                                                controller:
                                                    controller.nameController,
                                                decoration: InputDecoration(
                                                  hintText: "Edit name",
                                                  labelText: "Name",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: AppColors
                                                          .appLightBlue,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Text(
                                              student.name.split(' ')[0],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    25, // nameFontSize is removed for simplification
                                              ),
                                            ),
                                    ),
                                    Text(
                                      student.studentRollNo,
                                      style: TextStyle(
                                        fontSize:
                                            22, // rollNoFontSize is removed for simplification
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            13, 0, 0, 0),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            hintText: "Select your gender",
                                            labelText: "Gender",
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              borderSide: BorderSide(
                                                color: AppColors.appLightBlue,
                                                width: 2.0,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          value: controller.selectedGender,
                                          onChanged: (newValue) {
                                            controller.updateSelectedGender(
                                                newValue!);
                                          },
                                          items: ['Male', 'Female', 'Other']
                                              .map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 13, 0),
                                        child: FutureBuilder<List<String>>(
                                          future: controller.classesList,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  AppColors.appLightBlue,
                                                ),
                                              ));
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      'Error: ${snapshot.error}'));
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.isEmpty) {
                                              return Center(
                                                  child:
                                                      Text('No classes found'));
                                            } else {
                                              List<String> classes =
                                                  snapshot.data!;
                                              if (!classes.contains(
                                                  controller.selectedClass)) {
                                                controller.updateSelectedClass(
                                                    classes[0]);
                                              }
                                              return DropdownButtonFormField<
                                                  String>(
                                                value: controller.selectedClass,
                                                decoration: InputDecoration(
                                                  hintText: "Select your class",
                                                  labelText: "Class",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: AppColors
                                                          .appLightBlue,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                                items:
                                                    classes.map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  controller
                                                      .updateSelectedClass(
                                                          newValue!);
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 20),
                                child: CustomTextField(
                                  controller:
                                      controller.bForm_challanIdController,
                                  hintText: student.bFormChallanId,
                                  labelText: 'B-Form/Challan ID',
                                  isValid: controller.bForm_challanIdValid,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 20),
                                child: CustomTextField(
                                  controller: controller.fatherNameController,
                                  hintText: student.fatherName,
                                  labelText: "Father's name",
                                  isValid: controller.fatherNameValid,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 20),
                                child: CustomTextField(
                                  controller:
                                      controller.fatherPhoneNoController,
                                  hintText: student.fatherPhoneNo,
                                  labelText: "Father's phone no.",
                                  isValid: controller.fatherPhoneNoValid,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 20),
                                child: CustomTextField(
                                  controller: controller.fatherCNICController,
                                  hintText: student.fatherCNIC,
                                  labelText: "Father's CNIC",
                                  isValid: controller.fatherCNICValid,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EditStudentController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController bForm_challanIdController;
  late TextEditingController fatherNameController;
  late TextEditingController fatherPhoneNoController;
  late TextEditingController fatherCNICController;

  late bool isEditingName;
  late String selectedGender;
  late String selectedClass;
  late String changedGender;
  late String changedClass;

  late bool bForm_challanIdValid;
  late bool fatherNameValid;
  late bool fatherPhoneNoValid;
  late bool fatherCNICValid;

  late Future<List<String>> classesList;

  final AdminHomeController school =
      Get.put(AdminHomeController()); // Accessing AdminHomeController

  EditStudentController(Student student) {
    nameController = TextEditingController(text: student.name);
    bForm_challanIdController =
        TextEditingController(text: student.bFormChallanId);
    fatherNameController = TextEditingController(text: student.fatherName);
    fatherPhoneNoController =
        TextEditingController(text: student.fatherPhoneNo);
    fatherCNICController = TextEditingController(text: student.fatherCNIC);

    isEditingName = false;
    selectedGender = student.gender;
    selectedClass = student.classSection;
    changedGender = student.gender;
    changedClass = student.classSection;

    bForm_challanIdValid = true;
    fatherNameValid = true;
    fatherPhoneNoValid = true;
    fatherCNICValid = true;

    classesList = Database_Service.fetchAllClasses(school.schoolId.value);
  }

  void toggleEditingName() {
    isEditingName = !isEditingName;
    // Update text controller with current value when entering edit mode
    if (isEditingName) {
      nameController.text = nameController.text;
    }
    update();
  }

  void updateSelectedGender(String newValue) {
    selectedGender = newValue;
    changedGender = newValue;
    update();
  }

  void updateSelectedClass(String newValue) {
    selectedClass = newValue;
    changedClass = newValue;
    update();
  }
}
