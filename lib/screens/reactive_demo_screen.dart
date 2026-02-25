import 'package:flutter/material.dart';

class ReactiveDemoScreen extends StatefulWidget {
  const ReactiveDemoScreen({super.key});

  @override
  State<ReactiveDemoScreen> createState() => _ReactiveDemoScreenState();
}

class _ReactiveDemoScreenState extends State<ReactiveDemoScreen> {
  // State variables
  int _clickCount = 0;
  bool _isDarkMode = false;
  bool _isVisible = true;

  void _handleButtonClick() {
    setState(() {
      _clickCount++;
      _isDarkMode = !_isDarkMode;
    });
  }
  
  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Understand the Widget Tree Concept
    // The build method directly returns the root of our widget tree for this screen.
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey.shade900 : Colors.white,
      appBar: AppBar(
        title: const Text('Widget Tree & Reactive UI Demo'),
        backgroundColor: _isDarkMode ? Colors.grey.shade800 : Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // 2. Explore the Reactive UI Model
            // The children here will rebuild when setState is called
            children: [
              if (_isVisible)
                Card(
                  elevation: 4,
                  color: _isDarkMode ? Colors.grey.shade800 : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.flutter_dash,
                          size: 80,
                          color: _isDarkMode ? Colors.blue.shade200 : Colors.blue,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'You clicked the button $_clickCount times.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isDarkMode ? Colors.white : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              // Interactive elements
              ElevatedButton.icon(
                onPressed: _handleButtonClick,
                icon: const Icon(Icons.touch_app),
                label: const Text('Change State (Count & Color)'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _toggleVisibility,
                icon: Icon(_isVisible ? Icons.visibility_off : Icons.visibility),
                label: Text(_isVisible ? 'Hide Dashboard' : 'Show Dashboard'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _isDarkMode ? Colors.white : Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
