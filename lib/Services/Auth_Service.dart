// ignore_for_file: unused_local_variable

import 'package:classinsight/models/SchoolModel.dart';
import 'package:classinsight/utils/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Auth_Service {
  
static FirebaseAuth auth = FirebaseAuth.instance;

static Future<void> login(String email, String password, School school) async {

  try {
      print("HEREEE" + school.schoolId);
      if (school.adminEmail == email) {
        print("HWEFBHEBH"+school.schoolId);

        Get.snackbar('Logging In', '',
          backgroundColor: Colors.white, 
          showProgressIndicator: true,
          progressIndicatorBackgroundColor: AppColors.appDarkBlue
          );


        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        Get.offAllNamed('/AdminHome', arguments: school);
        Get.snackbar('Logged in Successfully', "Welcome, Admin - ${school.name}");

        print("Logged IN");
      } else {
        // Email does not match
        Get.snackbar('Login Error', 'Email does not match the admin email for the school');
      }
    
  } on FirebaseAuthException catch (e) {
    // Handle authentication error
    Get.snackbar('Login Error', e.message ?? 'An error occurred');
  } catch (e) {
    // Handle other errors
    Get.snackbar('Error', e.toString());
  }
}


static Future<void> logout(BuildContext context) async {
    try {
      Get.snackbar('Logging out', '',
          backgroundColor: Colors.white, 
          showProgressIndicator: true,
          progressIndicatorBackgroundColor: AppColors.appDarkBlue
          );

      await Future.delayed(Duration(seconds: 2));

      await auth.signOut();

      Get.deleteAll();

      Get.snackbar('Logged out successfully!', '',
          backgroundColor: Colors.white, duration: Duration(seconds: 2));

      Get.offAllNamed("/onBoarding");
    } catch (e) {
      print('Error logging out: $e');
      Get.snackbar('Error logging out', e.toString(),
          backgroundColor: Colors.red, duration: Duration(seconds: 2));
    }
  }

}