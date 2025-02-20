import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_form/cart_model.dart';
import 'provider.dart';
import 'package:provider/provider.dart'; 
import 'package:flutter/services.dart';
void main() async{
   // here initialize the Hive to store users data
  WidgetsFlutterBinding.ensureInitialized(); // This is crucial for ensuring that flutter framework properly set up before application starts running
  await Hive.initFlutter(); //intialized the Hive 

  await Hive.openBox('userBox');// this opens specific box named userbox






  runApp(

    ChangeNotifierProvider(
      create:(context) => CartProvider(),
      child:MyApp(),
    )

    
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Primary Brand Color (Similar to Flipkart)
          brightness: Brightness.light, // Light Mode for better readability
        ),
        scaffoldBackgroundColor: Colors.white, // Clean Background
        primaryColor: Colors.blue.shade800, // Primary Blue
        appBarTheme: AppBarTheme(
          backgroundColor:
              Colors.blue.shade900, // Flipkart's signature deep blue
          elevation: 0,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ), // White icons for contrast
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: Colors.grey.shade300,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Smooth rounded corners
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade800, // Amazon-style CTA color
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue.shade900,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey.shade600),
        ),
      ),
    );
  }
}
