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
class _JankenPageState extends State<JankenPage> {

  String myHand = Hands.rock.hand;
  String computerHand = Hands.rock.hand;

  void selectHand(String selectedHand) {
    myHand = selectedHand;
    print(myHand);
    generateComputerHand();
    setState(() {});
  }

  void generateComputerHand() {
    final randomInt = Random().nextInt(Hands.values.length);
    computerHand = Hands.values[randomInt].hand;
    print(computerHand);
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
              computerHand,
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 48),
            Text(
              myHand,
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
                    selectHand(Hands.rock.hand);
                  },
                  child: Text(Hands.rock.hand)),
                ElevatedButton(
                  onPressed: () {
                    selectHand(Hands.scissors.hand);
                  },
                  child: Text(Hands.scissors.hand)),
                ElevatedButton(
                  onPressed: () {
                    selectHand(Hands.paper.hand);
                  },
                  child: Text(Hands.paper.hand)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}