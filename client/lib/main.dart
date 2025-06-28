import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TimeDisplayScreen(),
    );
  }
}

class TimeDisplayScreen extends StatefulWidget {
  const TimeDisplayScreen({super.key});

  @override
  State<TimeDisplayScreen> createState() => _TimeDisplayScreenState();
}

class _TimeDisplayScreenState extends State<TimeDisplayScreen> {
  String _currentTime = 'Fetching time...';

  @override
  void initState() {
    super.initState();
    _fetchTime();
  }

  Future<void> _fetchTime() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/time')); // Use 10.0.2.2 for Android emulator to access host machine's localhost
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _currentTime = data['current_time'];
        });
      } else {
        setState(() {
          _currentTime = 'Failed to load time: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _currentTime = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Time'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'The current time from Flask server is:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              _currentTime,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchTime,
              child: const Text('Refresh Time'),
            ),
          ],
        ),
      ),
    );
  }
}
