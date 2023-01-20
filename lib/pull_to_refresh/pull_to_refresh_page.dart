import 'package:delayed_future/delayed_future.dart';
import 'package:flutter/material.dart';

class PullToRefreshPage extends StatefulWidget {
  const PullToRefreshPage({Key? key}) : super(key: key);

  @override
  State<PullToRefreshPage> createState() => _PullToRefreshPageState();
}

class _PullToRefreshPageState extends State<PullToRefreshPage> {
  int maxItems = 0;

  Future<void> _simulateFetchingData() {
    return Future.delayed(const Duration(milliseconds: 35));
  }

  /// Pretty quick method to increase amount of numbers in the list.
  ///
  /// ❗️ PLEASE NOTE
  /// It is important to delay the call of [_simulateFetchingData]
  /// and not the call of [_refresh].
  /// The reason is [_refresh] changes the state of the app **within it**,
  /// and the [delayed_future] library doesn't delay it.
  ///
  /// Instead, we must delay operations that return the results.
  Future<void> _refresh() async {
    await _simulateFetchingData().delayResult();

    setState(() {
      maxItems += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pull to Refresh')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: maxItems + 1,
          padding: const EdgeInsets.all(12.0),
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return maxItems == 0
                  ? const Text('No items here ... Try pull to refresh.')
                  : const SizedBox();
            }
            return Text(index.toString());
          },
        ),
      ),
    );
  }
}
