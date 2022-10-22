import 'dart:developer';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scrollController = ScrollController();
  bool? isList = true;

  @override
  void initState() {
    scrollController.addListener(listener);
    super.initState();
  }

  // on tap control
  void listener() {
    // scrol nech apexselga borgannini bilish uchun
    log('scrollController.position.pixels');

    // sharti
    if (scrollController.position.pixels > 1100) {
      isList = false;
      setState(() {});
    } else {
      isList = true;
      setState(() {});
    }
  }

// cesh yig'masligi uchun
  @override
  void dispose() {
    scrollController.removeListener(listener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.black),

      // packge
      body: LiquidPullToRefresh(
        backgroundColor: Colors.white,
        borderWidth: 2,
        color: Colors.black,
        height: 200,

        // after page
        onRefresh: () async {
          isList = true;
          setState(() {});
        },
        child: StatefulBuilder(builder: (context, setStateLocal) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // shart true bolsa yonga skrol boladi
              isList!
                  ? SizedBox(
                      height: 50,
                      child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(10),
                            color: Colors.grey[300],
                            child: Center(child: Text('$index salomlar')),
                          );
                        },
                        itemCount: 120,
                      ),
                    )
                  // folse bolsa GridView boladi
                  : Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: 120,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          color: Colors.grey[300],
                          child: Center(child: Text('$index salomlar')),
                        ),
                      ),
                    )
            ],
          );
        }),
      ),
    );
  }
}
