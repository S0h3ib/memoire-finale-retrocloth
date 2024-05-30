import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:rayatro_cloth2/provider/FavoritesProvider.dart';
import 'package:rayatro_cloth2/provider/ProductsProvider.dart';

import 'package:rayatro_cloth2/singup.dart'; // Ensure this path is correct
import 'package:rayatro_cloth2/splashscreen.dart';
import 'firebase_options.dart';
import 'home_page.dart';


import 'login.dart';
import 'search_screen.dart';
import 'upload_tap.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

late Size mq;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('========User is currently signed out!');
      } else {
        print('=========User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        //ChangeNotifierProvider(create: (context) => ProductsProvider(),),
      ],
      child: MaterialApp(
        routes: {
          "signup": (context) => SignUp(),
          "login": (context) => Login(),
          "home": (context) => MyHomePage(),
          "search": (context) => SearchScreen(),
          "upload": (context) => UploadTap(),
          "splash": (context) => SplashScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'rétro cloth',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
    if (snapshot.hasError) {
      return Scaffold(
        body: Center(
          child: Text(snapshot.error.toString()),
        ),
      );
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (snapshot.connectionState == ConnectionState.active) {
      if (snapshot.data == null) {
        return SplashScreen(); // Navigate to SplashScreen when user doesn't have an account
      } else {
        return const MyHomePage();
      }
    }
    return Scaffold(
      body: Center(
        child: Text('Something went wrong!'),
      ),
    );
  },
),
      ),
    );
  }
}
