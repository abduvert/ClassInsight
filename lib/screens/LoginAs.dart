// ignore_for_file: unused_local_variable

import 'package:classinsight/models/SchoolModel.dart';
import 'package:classinsight/utils/fontStyles.dart';
import 'package:classinsight/Widgets/BaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX

// ignore: must_be_immutable
class LoginAs extends StatelessWidget {
  LoginAs({Key? key}) : super(key: key);

  School school = Get.arguments as School;
  
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool parent = false;


    return Scaffold(
      appBar: AppBar(),
      body: BaseScreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login as",
              textAlign: TextAlign.left,
              style: Font_Styles.largeHeadingBold(context),
            ),
            SizedBox(height: screenHeight * 0.015),
            buildButton(context, "Parent", screenHeight, screenWidth,true),
            SizedBox(height: screenHeight * 0.01),
            buildButton(context, "Teacher", screenHeight, screenWidth,false),
            SizedBox(height: screenHeight * 0.01),
            buildButton(context, "Admin", screenHeight, screenWidth,false),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Choose your role: Parent, Teacher, or Admin.",
              style: Font_Styles.labelHeadingRegular(context),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String text, double screenHeight, double screenWidth, bool parent) {
    Rx<Color> borderColor = Colors.black.obs; // Rx variable for border color

    return Obx(() => TextButton(
          onPressed: parent ? () {
            // Get.toNamed("/")         
            }:
            () {
            Get.toNamed("/LoginScreen",arguments: school);        
            }
            ,
          style: TextButton.styleFrom(
            backgroundColor: Colors.white, // Background color remains unchanged
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
              side: BorderSide(
                color: borderColor.value, // Use borderColor for dynamic border color
              ),
            ),
            fixedSize: Size(screenWidth * 0.7, screenHeight * 0.05),
            
          ),
          child: Text(
            text,
            style: Font_Styles.labelHeadingLight(context),
          ),
        ));
  }
}