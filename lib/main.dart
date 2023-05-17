import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_arkamaya/view/home_screen.dart';
import 'package:technical_arkamaya/viewmodel/providers/add_user_provider.dart';
import 'package:technical_arkamaya/viewmodel/providers/detail_user_provider.dart';
import 'package:technical_arkamaya/viewmodel/providers/list_user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ListUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddUserProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Technical Arkamaya',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen()),
    );
  }
}
