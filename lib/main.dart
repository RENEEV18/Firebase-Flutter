import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/controller/providers/api_provider.dart';
import 'package:firebase_project/controller/providers/firebase_login_auth.dart';
import 'package:firebase_project/controller/providers/profile.dart';
import 'package:firebase_project/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthenticateProvider(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) => context.watch<AuthenticateProvider>().user(),
            initialData: null),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ApiProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        // home: const RegisterScreen(),
      ),
    );
  }
}
