import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
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
      home: const PixabayPage(),
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
  String fieldText = 'りんご';

  Future<void> fetchImages(String text) async {
    final Response response = await Dio().get(
        'https://pixabay.com/api/',
        queryParameters: {
          'key' : dotenv.get('API_KEY'),
          'q' : text,
          'image_type' : 'photo'
        },
    );
    imageList = response.data['hits'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // 最初に一度だけ画像データ取得
    fetchImages(fieldText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: fieldText,
          ),
          onFieldSubmitted: (text) {
            fieldText = text;
            fetchImages(fieldText);
          },
        ),
        backgroundColor: Colors.blue,
      ),
      // 並べて表示
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          // 表示する画像をリストから取得
          Map<String, dynamic> image = imageList[index];
          return InkWell(
            // 画像タップでシェア
            onTap: () async {
              final Directory dir = await getTemporaryDirectory();

              final Response response = await Dio().get(
                image['webformatURL'],
                options: Options(responseType: ResponseType.bytes),
              );

              final File imageFile = await File('${dir.path}/image.png')
                  .writeAsBytes(response.data);

              await Share.shareXFiles([
                XFile.fromData(
                  imageFile.readAsBytesSync(),
                  name: 'image.png',
                  mimeType: 'image/png',
                )
              ], subject: fieldText);
            },
            // タップする画像を表示
            child: Stack(
              fit: StackFit.expand,
              children: [
                image['previewURL'] != null
                    ? Image.network(
                        image['previewURL'],
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(),
                // いいねアイコンを右下に表示
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
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
