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

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://pbs.twimg.com/profile_images/1782305774544564224/ujx6tKey_400x400.jpg'),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text('おはる'),
                      SizedBox(width: 8),
                      Text('2024/08/28'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('こんにちは！'),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.favorite_border),
                      ),
                      IconButton(
                        onPressed: (){}, 
                        icon: const Icon(Icons.chat_bubble_outline)
                      ),
                      IconButton(
                        onPressed: (){}, 
                        icon: const Icon(Icons.send_outlined)
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        )

      ),
    );
  }
}