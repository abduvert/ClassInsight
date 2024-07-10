// ignore_for_file: prefer_const_constructors

import 'package:classinsight/Widgets/CustomBlueButton.dart';
import 'package:classinsight/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:classinsight/Const/AppColors.dart';

void main() {
  runApp(AddStudent());
}

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  double addStdFontSize = 16;
  double headingFontSize = 30;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    TextEditingController nameController = TextEditingController();
    bool nameValid = true;

    if (screenWidth < 350) {
      addStdFontSize = 14;
      headingFontSize = 25;
    }
    if (screenWidth < 300) {
      addStdFontSize = 14;
      headingFontSize = 23;
    }
    if (screenWidth < 250) {
      addStdFontSize = 11;
      headingFontSize = 18;
    }
    if (screenWidth < 230) {
      addStdFontSize = 8;
      headingFontSize = 14;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Appcolors.appLightBlue,
        body: Container(
          height: screenHeight,
          width: screenWidth,
          child: Center(
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.12,
                  width: screenWidth,
                  child: AppBar(
                    backgroundColor: Appcolors.appLightBlue,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Center(
                      child: Text(
                        'Add Student',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: addStdFontSize,
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
                  height: 0.08 * screenHeight,
                  width: screenWidth,
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Add New Student',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: headingFontSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 0.80 * screenHeight,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Shadow color with opacity
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 40, 30, 30),
                            child: CustomTextField(
                                controller: nameController,
                                hintText: 'name',
                                labelText: 'Name',
                                isValid: nameValid)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                            child: CustomTextField(
                                controller: nameController,
                                hintText: '35202xxxxxx78',
                                labelText: 'B-Form/Challan ID',
                                isValid: nameValid)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                            child: CustomTextField(
                                controller: nameController,
                                hintText: "Father's name",
                                labelText: "Father's name",
                                isValid: nameValid)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                            child: CustomTextField(
                                controller: nameController,
                                hintText: "Father's phone no.",
                                labelText: "Father's phone no.",
                                isValid: nameValid)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                            child: CustomTextField(
                                controller: nameController,
                                hintText: "Father's CNIC",
                                labelText: "35202xxxxxx78",
                                isValid: nameValid)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                            child: CustomTextField(
                                controller: nameController,
                                hintText: "Student's Roll no. (given by Admin)",
                                labelText: "Student's Roll no.",
                                isValid: nameValid)),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
                          child: CustomBlueButton(
                            buttonText: 'Add',
                            onPressed: () {
                              // Define the action when the button is pressed
                              print('Button pressed!');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}