import 'package:flutter/material.dart';
import 'package:let_them_notice/pin/pin_page.dart';

void main() {
  runApp(const LetThemNotice());
}

class LetThemNotice extends StatelessWidget {
  const LetThemNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Let Them Notice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PinPage(),
    );
  }
}
