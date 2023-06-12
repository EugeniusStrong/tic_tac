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
  bool _onSwitch = true;
  bool _win = true;
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
  int _scoreX = 0;
  int _scoreO = 0;
  int _containerFillingLimit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Player X',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      _scoreX.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Player O',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      _scoreO.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (gameBoard[index] == '') {
        if (_onSwitch) {
          gameBoard[index] = 'x';
          _containerFillingLimit += 1;
        } else {
          gameBoard[index] = 'o';
          _containerFillingLimit += 1;
        }
        _onSwitch = !_onSwitch;
        _checkWinner();
      }
    });
  }

  void _checkWinner() {
    if (gameBoard[0] == gameBoard[1] &&
        gameBoard[0] == gameBoard[2] &&
        gameBoard[0] != '') {
      _showWinDialog(gameBoard[0]);
      _win = true;
    }
    if (gameBoard[3] == gameBoard[4] &&
        gameBoard[3] == gameBoard[5] &&
        gameBoard[3] != '') {
      _showWinDialog(gameBoard[3]);
      _win = true;
    }
    if (gameBoard[6] == gameBoard[7] &&
        gameBoard[6] == gameBoard[8] &&
        gameBoard[6] != '') {
      _showWinDialog(gameBoard[6]);
      _win = true;
    }
    if (gameBoard[0] == gameBoard[3] &&
        gameBoard[0] == gameBoard[6] &&
        gameBoard[0] != '') {
      _showWinDialog(gameBoard[0]);
      _win = true;
    }
    if (gameBoard[1] == gameBoard[4] &&
        gameBoard[1] == gameBoard[7] &&
        gameBoard[1] != '') {
      _showWinDialog(gameBoard[1]);
      _win = true;
    }
    if (gameBoard[2] == gameBoard[5] &&
        gameBoard[2] == gameBoard[8] &&
        gameBoard[2] != '') {
      _showWinDialog(gameBoard[2]);
      _win = true;
    }
    if (gameBoard[6] == gameBoard[4] &&
        gameBoard[6] == gameBoard[2] &&
        gameBoard[6] != '') {
      _showWinDialog(gameBoard[6]);
      _win = true;
    }
    if (gameBoard[0] == gameBoard[4] &&
        gameBoard[0] == gameBoard[8] &&
        gameBoard[0] != '') {
      _showWinDialog(gameBoard[0]);
      _win = true;
    } else if (_containerFillingLimit == 9 && !_win) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String win) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${win.toUpperCase()} is WINNER!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: const Text('RESTART'),
            ),
          ],
        );
      },
    );
    if (win == 'x') {
      _scoreX += 1;
    } else if (win == 'o') {
      _scoreO += 1;
    }
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('DRAW'),
          actions: [
            ElevatedButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: const Text('RESTART'),
            ),
          ],
        );
      },
    );
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < gameBoard.length; i++) {
        gameBoard[i] = '';
      }
    });
    _containerFillingLimit = 0;
  }
}
