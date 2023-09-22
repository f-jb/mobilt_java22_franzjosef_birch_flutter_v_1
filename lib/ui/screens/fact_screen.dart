import 'package:flutter/material.dart';

import '../../data/fact_repository.dart';
import '../../model/fact.dart';

class FactPage extends StatefulWidget {
  const FactPage({super.key});

  @override
  State<FactPage> createState() => _FactPageState();
}

class _FactPageState extends State<FactPage> {
  late Future<Fact> futureFact;

  @override
  void initState() {
    super.initState();
    futureFact = getTodaysFact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Fact>(
          future: futureFact,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(child: Text(snapshot.data!.text));
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return const CircularProgressIndicator();
          }),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
                futureFact = getRandomFact();
              }),
          tooltip: "Get random fact",
          child: const Icon(Icons.refresh)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
