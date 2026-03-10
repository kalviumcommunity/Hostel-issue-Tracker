import 'package:flutter/material.dart';

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key})

  @override
  Widget build(BuildContext context) {
    // 2. Implement Responsiveness with MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return Scaffold(
      // 1. A header section
      appBar: AppBar(
        title: const Text('Responsive Layout Demo'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      // 3. Apply Flexible and Adaptive Widgets using LayoutBuilder
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isTablet) {
            // Displaying a two-column grid for tablets
            return _buildTabletLayout(context);
          } else {
            // Displaying a single-column layout for phones
            return _buildMobileLayout(context);
          }
        },
      ),
      // 1. A footer or button section for actions
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Action Clicked!')),
                  );
                },
                icon: const Icon(Icons.rocket_launch),
                label: const Text('Primary Action'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Single-column layout for mobile
  Widget _buildMobileLayout(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              child: Text('${index + 1}'),
            ),
            title: Text('Item ${index + 1}'),
            subtitle: const Text('Detailed description for this item goes here.'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }

  // Two-column grid layout for tablets and desktops
  Widget _buildTabletLayout(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 3 / 1, // Adjust aspect ratio as needed
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                child: Text('${index + 1}'),
              ),
              title: Text(
                'Tablet Item ${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Wider layout requires more content spacing.'),
              trailing: IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {},
              ),
            ),
          ),
        );
      },
    );
  }
}
