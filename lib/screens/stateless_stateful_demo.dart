import 'package:flutter/material.dart';

class StatelessStatefulDemoScreen extends StatelessWidget {
  const StatelessStatefulDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless vs Stateful Demo'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Stateless Widget for static header
            DemoHeader(title: 'Interactive Counter App'),
            SizedBox(height: 48),
            // Stateful Widget for interactive content
            Expanded(child: InteractiveArea()),
          ],
        ),
      ),
    );
  }
}

// 1. Stateless Widget
// This widget only relies on the data passed in its constructor.
// It does not change its state internally.
class DemoHeader extends StatelessWidget {
  final String title;

  const DemoHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.widgets, size: 48, color: Colors.deepPurple),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'This header is a StatelessWidget. It remains static.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// 2. Stateful Widget
// This widget maintains mutable state. When the state changes,
// it rebuilds to reflect the updated data.
class InteractiveArea extends StatefulWidget {
  const InteractiveArea({super.key});

  @override
  State<InteractiveArea> createState() => _InteractiveAreaState();
}

class _InteractiveAreaState extends State<InteractiveArea> {
  int _counter = 0;
  bool _isDarkMode = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
      debugPrint('Counter updated to $_counter');
    });
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _isDarkMode ? Colors.grey[900] : Colors.grey[100];
    final textColor = _isDarkMode ? Colors.white : Colors.black87;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'This area is a StatefulWidget.',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // Counter interaction
          Text(
            'Count: $_counter',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _incrementCounter,
            icon: const Icon(Icons.add),
            label: const Text('Increase'),
          ),
          
          const SizedBox(height: 48),
          
          // Theme toggler interaction
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.light_mode, color: _isDarkMode ? Colors.grey : Colors.amber),
              const SizedBox(width: 8),
              Switch(
                value: _isDarkMode,
                onChanged: _toggleTheme,
              ),
              const SizedBox(width: 8),
              Icon(Icons.dark_mode, color: _isDarkMode ? Colors.indigoAccent : Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _isDarkMode ? 'Dark Mode Active' : 'Light Mode Active',
            style: TextStyle(color: textColor),
          )
        ],
      ),
    );
  }
}
