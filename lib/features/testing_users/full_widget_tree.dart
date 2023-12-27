import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('My App')),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showDetails = false;

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Welcome to My App'),
        ToggleButton(
          onPressed: _toggleDetails,
          text: _showDetails ? 'Hide Details' : 'Show Details',
        ),
        if (_showDetails)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Additional information about the app...'),
          ),
      ],
    );
  }
}

class ToggleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const ToggleButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      );
}
