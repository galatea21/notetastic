import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notetastic/screens/login_screen.dart';
import 'package:notetastic/services/auth.dart';

import './screens/home_screen.dart';
import './screens/note_edit_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notetastic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFF4CE6A),
        accentColor: const Color(0xFFFF6666),
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print("Error occurred: ${snapshot.error.toString()}");
            return const Scaffold(body: Text("Error"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Root();
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      routes: {
        "/home": (context) => HomeScreen(),
        "/test": (context) => NoteEditScreen(),
      },
    );
  }
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth(auth: _auth).user,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid == null) {
            return LoginScreen(
              auth: _auth,    
              firestore: _firestore,
            );
          } else {
            return HomeScreen();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
