import 'dart:math';

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
      home: JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({super.key});

  @override
  State<JankenPage> createState() => _JankenPageState();
}

enum Hands {
  rock('✊'),
  scissors('✌️'),
  paper('🖐️');

  const Hands(this.hand);
  final String hand;

  static final Map<String, Hands> _map = {
    for (final value in Hands.values) value.hand: value
  };

  static Hands getHandFromString(String value) {
    return _map[value] ?? rock;
  }
}

enum Results {
  win('あなたの勝ち！🥳'),
  draw('あいこ🤔'),
  lose('あなたの負け…🫠');

  const Results(this.result);
  final String result;

  static Results judge(Hands yourHand, Hands othersHand) {
    if (yourHand == othersHand) {
      // あいこ
      return Results.draw;
    } else {
      // その他
      switch (yourHand) {
        case Hands.rock:
          return othersHand == Hands.scissors ? Results.win : Results.lose;
        case Hands.scissors:
          return othersHand == Hands.paper ? Results.win : Results.lose;
        case Hands.paper:
          return othersHand == Hands.rock ? Results.win : Results.lose;
      }
    }
  }
}

enum Titles {
  first('じゃんけん……'),
  draw('あいこで……'),
  other('じゃんけん……ぽん！');

  const Titles(this.title);
  final String title;
}

class _JankenPageState extends State<JankenPage> {

  Hands myHand = Hands.rock;
  Hands computerHand = Hands.rock;

  String title = Titles.first.title;
  String result = '';

  void selectHand(Hands selectedHand) {
    myHand = selectedHand;
    print(myHand);
    generateComputerHand();
    showResults(Results.judge(myHand, computerHand));
    setState(() {});
  }

  void generateComputerHand() {
    final randomInt = Random().nextInt(Hands.values.length);
    computerHand = Hands.values[randomInt];
    print(computerHand);
  }

  void showResults(Results results) {
    // 結果表示
    result = results.result;

    // タイトルを修正
    if (results == Results.draw) {
      title = Titles.draw.title;
    } else {
      title = Titles.other.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'じゃんけん',
          style: TextStyle(
            color: Colors.white,
          ),),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 54),
            Text(
              '🤖\n'+computerHand.hand,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 48),
            Text(
              myHand.hand,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectHand(Hands.rock);
                  },
                  child: Text(Hands.rock.hand)),
                ElevatedButton(
                  onPressed: () {
                    selectHand(Hands.scissors);
                  },
                  child: Text(Hands.scissors.hand)),
                ElevatedButton(
                  onPressed: () {
                    selectHand(Hands.paper);
                  },
                  child: Text(Hands.paper.hand)),
              ],
            ),
            SizedBox(height: 54),
            Text(
              result,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}