import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soiree/auth.dart';
import 'package:soiree/pages/home.dart';
import 'package:soiree/provider.dart';
import 'package:soiree/utils/messageProvider.dart';
import 'firebase_options.dart';
import 'package:soiree/AppTheme/my_behaviour.dart';
import 'package:soiree/pages/spashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {}
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        auth: AuthService(),
        messageProvider: MessageProvider(),
        child: MaterialApp(
          title: 'RAFPLES',
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child,
            );
          },
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF8A2BE2),
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xFF2874F0),
            accentColor: Colors.blueAccent,
            primaryColorLight: const Color(0xFFFDE400),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.white,
            ),
          ),
          home: MyHomePage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
    );
  }
}
