import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_counterapp/utils/observer.dart';
import 'package:riverpod_counterapp/view/product_view.dart';
import 'package:riverpod_counterapp/view/user_view.dart';


void main() {
  runApp(ProviderScope(observers: [Observer()],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductView(),
    );
  }
}
