import 'package:flutter/material.dart';

void main() {
  runApp(const BelegscannerApp());
}

class BelegscannerApp extends StatelessWidget {
  const BelegscannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belegscanner MVP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PlaceholderHome(),
    );
  }
}

class PlaceholderHome extends StatelessWidget {
  const PlaceholderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belegscanner MVP'),
      ),
      body: const Center(
        child: Text('Projektstruktur angelegt. Features folgen.'),
      ),
    );
  }
}
