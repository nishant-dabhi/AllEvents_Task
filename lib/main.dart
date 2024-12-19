import 'package:allevents_task/pages/home_page.dart';
import 'package:allevents_task/auth/login.dart';
import 'package:allevents_task/utils/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 237, 248, 255),
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromARGB(255, 237, 248, 255)),
          cardColor: Colors.white,
          listTileTheme: ListTileThemeData(
            tileColor: Color.fromARGB(255, 237, 248, 255),
          ),
          textTheme: AppTextTheme.textTheme),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) =>
            snapshot.hasData ? HomePage() : LoginForm(),
      ),
    );
  }
}
