import 'package:flutter/material.dart';
import 'package:kpgames/tictactoe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: options(),
    );
  }
}

class options extends StatefulWidget {
  @override
  _optionsState createState() => _optionsState();
}
class _optionsState extends State<options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Games', style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.purple[300],
    ),
      body:  Center(
    child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicTacToeGame()),
              );
            },
            child: Text('Play Tic Tac Toe'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[300],
              foregroundColor: Colors.white,
              minimumSize: Size(200, 50),
              textStyle: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicTacToe()),
              );
            },
            child: Text('play xyz'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[300],
              foregroundColor: Colors.white,
              minimumSize: Size(200, 50),
              textStyle: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}
class _TicTacToeState extends State<TicTacToe>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ],
      ),
    );
  }
}
