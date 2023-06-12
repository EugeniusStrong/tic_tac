import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onSwitch = true;
  List<String> gameBoard = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _tapped(index);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.grey,
                )),
                child: Center(
                  child: Text(
                    gameBoard[index],
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (onSwitch) {
        if (gameBoard[index] == '') {
          gameBoard[index] = 'x';
        }
      } else {
        if (gameBoard[index] == '') {
          gameBoard[index] = 'o';
        }
      }
      onSwitch = !onSwitch;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (gameBoard[0] == gameBoard[1] &&
        gameBoard[0] == gameBoard[2] &&
        gameBoard[0] != '') {
      _showWinDialog(gameBoard[0]);
    }
    if (gameBoard[3] == gameBoard[4] &&
        gameBoard[3] == gameBoard[5] &&
        gameBoard[3] != '') {
      _showWinDialog(gameBoard[3]);
    }
    if (gameBoard[6] == gameBoard[7] &&
        gameBoard[6] == gameBoard[8] &&
        gameBoard[6] != '') {
      _showWinDialog(gameBoard[6]);
    }
    if (gameBoard[0] == gameBoard[3] &&
        gameBoard[0] == gameBoard[6] &&
        gameBoard[0] != '') {
      _showWinDialog(gameBoard[0]);
    }
    if (gameBoard[1] == gameBoard[4] &&
        gameBoard[1] == gameBoard[7] &&
        gameBoard[1] != '') {
      _showWinDialog(gameBoard[1]);
    }
    if (gameBoard[2] == gameBoard[5] &&
        gameBoard[2] == gameBoard[8] &&
        gameBoard[2] != '') {
      _showWinDialog(gameBoard[2]);
    }
    if (gameBoard[6] == gameBoard[4] &&
        gameBoard[6] == gameBoard[2] &&
        gameBoard[6] != '') {
      _showWinDialog(gameBoard[6]);
    }
    if (gameBoard[0] == gameBoard[4] &&
        gameBoard[0] == gameBoard[8] &&
        gameBoard[0] != '') {
      _showWinDialog(gameBoard[0]);
    }
  }

  void _showWinDialog(String win) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${win.toUpperCase()} is WINNER!'),
          );
        });
  }
}
