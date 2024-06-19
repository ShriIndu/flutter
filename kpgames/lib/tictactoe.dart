import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}
class _TicTacToeGameState extends State<TicTacToeGame>{
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));
  String currentPlayer = 'X';
  bool gameOver = false;
  String result = '';

  void _resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      currentPlayer = 'X';
      gameOver = false;
      result = '';
    });
  }

  void _makeMove(int row, int col) {
    if (board[row][col] == '' && !gameOver) {
      setState(() {
        board[row][col] = currentPlayer;
        if (_checkWinner(row, col)) {
          gameOver = true;
          result = currentPlayer == 'X' ? 'You Win!!!' : 'You Lost!!!';
        } else if (_isBoardFull()) {
          gameOver = true;
          result = 'Draw!!!';
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          if (currentPlayer == 'O') {
            Future.delayed(Duration(seconds: 1), _cpuMove);
          }
        }
      });
    }
  }

  bool _checkWinner(int row, int col) {
    bool checkLine(List<String> line) => line.every((cell) => cell == currentPlayer);
    return checkLine(board[row]) ||
        checkLine([board[0][col], board[1][col], board[2][col]]) ||
        (row == col && checkLine([board[0][0], board[1][1], board[2][2]])) ||
        (row + col == 2 && checkLine([board[0][2], board[1][1], board[2][0]]));
  }

  bool _isBoardFull() {
    return board.every((row) => row.every((cell) => cell != ''));
  }

  void _cpuMove() {
    if (!_playToWinOrBlock('O') && !_playToWinOrBlock('X')) {
      _playRandomMove();
    }
  }

  bool _playToWinOrBlock(String player) {
    for (int i = 0; i < 3; i++)
    {if (_tryMove(i, 0, i, 1, i, 2, player) || _tryMove(0, i, 1, i, 2, i, player)) return true;}
    return _tryMove(0, 0, 1, 1, 2, 2, player) || _tryMove(0, 2, 1, 1, 2, 0, player);
  }

  bool _tryMove(int r1, int c1, int r2, int c2, int r3, int c3, String player) {
    if (board[r1][c1] == player && board[r2][c2] == player && board[r3][c3] == '') {
      _makeMove(r3, c3);
      return true;
    }
    if (board[r1][c1] == player && board[r3][c3] == player && board[r2][c2] == '') {
      _makeMove(r2, c2);
      return true;
    }
    if (board[r2][c2] == player && board[r3][c3] == player && board[r1][c1] == '') {
      _makeMove(r1, c1);
      return true;
    }
    return false;
  }

  void _playRandomMove() {
    List<int> emptySpots = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          emptySpots.add(i * 3 + j);
        }
      }
    }

    if (emptySpots.isNotEmpty) {
      Random random = Random();
      int index = random.nextInt(emptySpots.length);
      int position = emptySpots[index];
      int row = position ~/ 3;
      int col = position % 3;
      _makeMove(row, col);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFFF69B4),
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentPlayer == 'X' ? 'Your Turn' : 'Player 2 Turn',
              style: TextStyle(fontSize: 30, color: Color(0xFFFF69B4)),
            ),
            for (int row = 0; row < 3; row++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int col = 0; col < 3; col++)
                    GestureDetector(
                      onTap: () => _makeMove(row, col),
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFEFA8CC), width: 3),
                        ),
                        child: Center(
                          child: Text(board[row][col], style: TextStyle(fontSize: 40, color: Colors.black)),
                        ),
                      ),
                    ),
                ],
              ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 30)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _resetGame,
              child: Text('Restart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF69B4),
                foregroundColor: Colors.white,
                minimumSize: Size(320, 50),
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 5),
            Text('PLACE 3 IN A ROW', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.grey)),
          ],
        ),
      ),
    );
  }
}
