import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_page.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // // open a box
  var box = await Hive.openBox('mybox');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initilization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initilization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something went wrong.");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
              title: 'Flutter Application',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              // home: const LoginPage()
              home: HomePage());
        }
        return CircularProgressIndicator();
      },
    );
  }
}
