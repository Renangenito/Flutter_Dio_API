import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio_flutter_api/screens/home_screen.dart';
import 'package:dio_flutter_api/providers/data_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DataProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dio API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
