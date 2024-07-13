import 'package:classinsight/firebase_options.dart';
import 'package:classinsight/routes/mainRoutes.dart';
import 'package:classinsight/screens/adminSide/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    
  } catch (e) {
    print(e.toString());
  }
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  User? user;


   @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    // userSubscription = Database_Service.getUserDetails(user!.uid).toString();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute:_getInitialLocation(user),
      getPages: MainRoutes.routes,
      // home: LoginScreen(),
    );
  }


    String _getInitialLocation(User? user) {
    if (user != null) {
      if (user.email!=null) {
        return '/AdminHome';
      } else {
        return '/';
      }
    } else {
      return '/onBoarding';
    }
  }
}

