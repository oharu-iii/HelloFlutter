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

  List imageList = [];

  Future<void> fetchImages(String text) async {
    Response response = await Dio().get(
      'https://pixabay.com/api/?key=46126743-24df09ce9aa7b42620cea4475&q=$text&image_type=photo'
    );
    imageList = response.data['hits'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // 最初に一度だけ画像データ取得
    fetchImages('りんご');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
          ),
          onFieldSubmitted: (text) {
            print(text);
            fetchImages(text);
          },
        ),
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> image = imageList[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                image['previewURL'],
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.thumb_up_alt_outlined,
                        size: 14,
                      ),
                      Text(image['likes'].toString()),
                    ],
                  )
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

