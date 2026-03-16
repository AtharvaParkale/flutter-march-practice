import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  List<String> quotes = [
    "quote 1",
    "quote 2",
    "quote 3",
    "quote 4",
    "quote 5",
    "quote 6",
    "quote 7",
    "quote 8",
    "quote 9",
    "quote 10",
    "quote 11",
    "quote 12",
    "quote 13",
    "quote 14",
    "quote 15",
    "quote 16",
    "quote 17",
  ];

  late Ticker ticker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels >=
    //       _scrollController.position.maxScrollExtent - 200) {
    //     setState(() {
    //       quotes = quotes + quotes;
    //     });
    //   }
    // });

    ticker = createTicker((elapsed) {
      print(elapsed.inSeconds);
    });

    ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagination")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: quotes.length,
        itemBuilder: (BuildContext context, int idx) {
          return ListTile(title: Text(quotes[idx]));
        },
      ),
    );
  }
}
