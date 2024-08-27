import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: const Text(
            'おはる',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          elevation: 0.5,
          backgroundColor: Colors.blue,
        ),

        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('おはる'),
                  SizedBox(width: 8),
                  Text('2024/08/28'),
                ],
              ),
              SizedBox(height: 4),
              Text('こんにちは！'),
            ],
          ),
        )

      ),
    );
  }
}