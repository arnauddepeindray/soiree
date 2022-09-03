import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soiree/auth.dart';
import 'package:soiree/pages/splash/splash_screen.dart';
import 'package:soiree/provider.dart';
import 'package:soiree/style/theme.dart';
import 'package:soiree/utils/messageProvider.dart';
import 'firebase_options.dart';
import 'package:soiree/AppTheme/my_behaviour.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {}
  });
  Key key = UniqueKey();
  runApp(MyApp(key: key,));
}

class MyApp extends StatelessWidget {
  const MyApp({required Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
        auth: AuthService(),
        messageProvider: MessageProvider(),
        key: key!,
        child: MaterialApp(
          title: 'RAFPLES',
          builder: (context,  child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            );
          },
          theme: ThemeApp.getTheme(),
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
