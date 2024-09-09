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
      home: const JankenPage(),
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

  static final Map<String, Results> _map = {
    for (final value in Results.values) value.result: value
  };

  static Results getResultFromString(String value) {
    return _map[value] ?? win;
  }

  static const Map<Hands, Map<Hands, Results>> _resultsMap = {
    Hands.rock: {Hands.rock: Results.draw, Hands.scissors: Results.win, Hands.paper: Results.lose},
    Hands.scissors: {Hands.rock: Results.lose, Hands.scissors: Results.draw, Hands.paper: Results.win},
    Hands.paper: {Hands.rock: Results.win, Hands.scissors: Results.lose, Hands.paper: Results.draw},
  };

  static Results judge(Hands yourHand, Hands othersHand) {
    return _resultsMap[yourHand]?[othersHand] ?? Results.win;
  }
}

enum Titles {
  first('じゃんけん……'),
  draw('あいこで……しょ！'),
  end('じゃんけん……ぽん！');

  const Titles(this.title);
  final String title;
}

class _JankenPageState extends State<JankenPage> {

  Hands myHand = Hands.rock;
  Hands computerHand = Hands.rock;

  Titles title = Titles.first;
  String result = '';

  void selectHand(Hands selectedHand) {
    myHand = selectedHand;
    generateComputerHand();
    showResults(Results.judge(myHand, computerHand));
    setState(() {});
  }

  void generateComputerHand() {
    final randomInt = Random().nextInt(Hands.values.length);
    computerHand = Hands.values[randomInt];
  }

  void showResults(Results results) {
    // 前の結果に合わせてタイトルを修正
    title = Results.getResultFromString(result) == Results.draw ? Titles.draw : Titles.end;

    // 結果表示
    result = results.result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
              title.title,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 54),
            Text(
              '🤖\n${computerHand.hand}',
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              myHand.hand,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectHand(Hands.rock);
                  },
                  child: Text(
                    Hands.rock.hand,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand(Hands.scissors);
                  },
                  child: Text(
                    Hands.scissors.hand,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand(Hands.paper);
                  },
                  child: Text(
                    Hands.paper.hand,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )
                ),
              ],
            ),
            const SizedBox(height: 54),
            Text(
              result,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}