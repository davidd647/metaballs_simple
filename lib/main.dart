import 'package:flutter/material.dart';

import './metaballs_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metaball Shader',
      darkTheme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColorDark: Colors.deepOrange,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.8, 0.95],
              colors: [
                Colors.blue.shade900,
                Colors.deepOrange.shade600,
                Colors.orange.shade600,
              ],
            ),
          ),
          child: MetaballsContainer(maxHeight: maxHeight, maxWidth: maxWidth),
        );
      }),
    );
  }
}
