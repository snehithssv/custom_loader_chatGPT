import 'package:flutter/material.dart';
import 'package:loader_animate/custom_container.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          body: const Center(
            child: CustomAnimatedContiner(50, 250),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            },
            child: const Icon(Icons.refresh),
          ),
        );
      }),
    );
  }
}
