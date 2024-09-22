import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PixabayPage(),
    );
  }
}

class PixabayPage extends StatefulWidget {
  const PixabayPage({super.key});

  @override
  State<PixabayPage> createState() => _PixabayPageState();
}

class _PixabayPageState extends State<PixabayPage> {

  Future<void> fetchImages() async {
    Response response = await Dio().get(
      'https://pixabay.com/api/?key=46126743-24df09ce9aa7b42620cea4475&q=yellow+flowers&image_type=photo'
    );
    print(response);
  }

  @override
  void initState() {
    super.initState();
    // 最初に一度だけ画像データ取得
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

