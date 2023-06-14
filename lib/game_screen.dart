import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static var gameScreenFontStyle = GoogleFonts.schoolbell(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 40,
    ),
  );
  static var gameScreenBlackFontStyle = GoogleFonts.schoolbell(
    textStyle: const TextStyle(
      color: Colors.black87,
      fontSize: 30,
    ),
  );
  bool _onSwitch = true;

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
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Player X',
                      style: gameScreenFontStyle,
                    ),
                    Text(
                      _scoreX.toString(),
                      style: gameScreenFontStyle,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Player O',
                      style: gameScreenFontStyle,
                    ),
                    Text(
                      _scoreO.toString(),
                      style: gameScreenFontStyle,
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
                        style: gameScreenFontStyle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[900],
              alignment: Alignment.topCenter,
              transform: Matrix4.rotationZ(0.1),
              child: TextButton(
                child: Text(
                  'TIC TAC TOE',
                  style: gameScreenFontStyle,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
          gameBoard[index] = 'X';
          _containerFillingLimit++;
        } else {
          gameBoard[index] = 'O';
          _containerFillingLimit++;
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
    } else if (_containerFillingLimit == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String win) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: Text(
            '${win.toUpperCase()} is WINNER!',
            style: gameScreenFontStyle,
          ),
          actions: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              ),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: Text(
                'RESTART',
                style: gameScreenBlackFontStyle,
              ),
            ),
          ],
        );
      },
    );
    if (win == 'X') {
      _scoreX += 1;
    } else if (win == 'O') {
      _scoreO += 1;
    }
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: Text(
            'DRAW',
            style: gameScreenFontStyle,
          ),
          actions: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              ),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: Text(
                'RESTART',
                style: gameScreenBlackFontStyle,
              ),
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
