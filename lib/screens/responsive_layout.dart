import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine screen width to drive the layout logic
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Layout Demo')),
      body: Container(
        padding: const EdgeInsets.all(16),
        // Use a wrapping column the span the entire screen height
        child: Column(
          children: [
            // 1. Dynamic Header Container
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Header Section\n(Width: ${screenWidth.toStringAsFixed(0)}px)',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 2. Flexible Content Area adapting to Row or Column
            Expanded(
              child: isWideScreen ? _buildWideLayout(context) : _buildNarrowLayout(context),
            ),
          ],
        ),
      ),
    );
  }

  // Tablet/Desktop: Side-by-side using Row and Expanded
  Widget _buildWideLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2, // Takes twice the horizontal space
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('Left Panel (Expanded Flex: 2)', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1, // Takes one horizontal space unit
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('Right Panel (Expanded Flex: 1)', textAlign: TextAlign.center),
            ),
          ),
        ),
      ],
    );
  }

  // Phone: Vertically stacked using Column and Expanded
  Widget _buildNarrowLayout(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('Top Panel (Stacked)', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('Bottom Panel (Stacked)'),
            ),
          ),
        ),
      ],
    );
  }
}
