import 'package:flutter/material.dart';
import 'package:let_them_notice/pin/pin_page.dart';
import 'package:let_them_notice/pull_to_refresh/pull_to_refresh_page.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Let Them Notice')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (context) {
                  return const PinPage();
                },
              );
              Navigator.of(context).push(route);
            },
            child: const Text('Open Pin'),
          ),
          const SizedBox(height: 8.0, width: double.infinity),
          TextButton(
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (context) {
                  return const PullToRefreshPage();
                },
              );
              Navigator.of(context).push(route);
            },
            child: const Text('Open Pull To Refresh'),
          ),
        ],
      ),
    );
  }
}
