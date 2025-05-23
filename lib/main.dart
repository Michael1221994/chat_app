import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/Services/Auth/auth_gate.dart';
import 'package:minimal_chat_app/Services/Auth/login_or_register.dart';
import 'package:minimal_chat_app/firebase_options.dart';
import 'package:minimal_chat_app/pages/login_page.dart';
import 'package:minimal_chat_app/themes/light_mode.dart';
import 'package:minimal_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
   ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
    ) 
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}