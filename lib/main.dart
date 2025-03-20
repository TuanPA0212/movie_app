import 'package:flutter/material.dart';
import 'package:movie_app/viewmodels/movie_view_model.dart';
import 'package:movie_app/viewmodels/navigation_view_model.dart';
import 'package:movie_app/viewmodels/textFieldProvider.dart';
import 'package:movie_app/views/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieViewModel()),
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
        ChangeNotifierProvider(create: (_) => TextFieldProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black, // Màu chính
        scaffoldBackgroundColor: Colors.black, // Màu nền
        appBarTheme:  AppBarTheme(
          backgroundColor: Colors.white.withOpacity(0.1),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
        ),
        bottomNavigationBarTheme:  BottomNavigationBarThemeData(
          // backgroundColor: AppColors.primary,
          backgroundColor: Colors.white.withOpacity(0.1),
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        useMaterial3: true
      ),
      home: const Home(),
    );
  }
}
