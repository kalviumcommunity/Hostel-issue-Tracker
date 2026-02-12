import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Issue Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200EE), // Primary Purple
          secondary: const Color(0xFF03DAC6), // Teal Accent
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LoginScreen();
        return const HomeScreen();
      },
    );
  }
}

// -------------------- RESPONSIVE LOGIN SCREEN --------------------

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _authAction(Future<UserCredential> Function() action) async {
    setState(() { _isLoading = true; _errorMessage = null; });
    try {
      await action();
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message);
    } catch (e) {
      setState(() => _errorMessage = 'An error occurred: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isTablet ? 400 : double.infinity),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home_work, size: 64, color: Theme.of(context).primaryColor),
                        const SizedBox(height: 16),
                        Text(
                          'Welcome Back',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Report & Track Hostel Issues', style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 32),
                        if (_errorMessage != null)
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.red.shade100,
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),
                        if (_isLoading)
                          const CircularProgressIndicator()
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: () => _authAction(() => FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                )),
                                child: const Text('Login'),
                              ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () => _authAction(() => FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                )),
                                child: const Text('Create Account'),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------- RESPONSIVE HOME SCREEN --------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _addTask(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report New Issue'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Describe the issue (e.g., Leaking tap in Room 202)',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                FirebaseFirestore.instance.collection('issues').add({
                  'description': controller.text,
                  'createdAt': Timestamp.now(),
                  'status': 'Open',
                  'userId': FirebaseAuth.instance.currentUser?.uid,
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Submit Report'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint for Tablet/Desktop
        final isWideScreen = constraints.maxWidth > 600;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            centerTitle: false,
            actions: [
              IconButton(onPressed: () => FirebaseAuth.instance.signOut(), icon: const Icon(Icons.logout))
            ],
          ),
          body: Row(
            children: [
              if (isWideScreen)
                NavigationRail(
                  selectedIndex: 0,
                  onDestinationSelected: (int index) {},
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Issues')),
                    NavigationRailDestination(icon: Icon(Icons.person), label: Text('Profile')),
                  ],
                ),
              if (isWideScreen) const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('issues').orderBy('createdAt', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                    final docs = snapshot.data!.docs;
                    if (docs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline, size: 80, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            const Text('No issues reported. Everything is good!', style: TextStyle(fontSize: 18, color: Colors.grey)),
                          ],
                        ),
                      );
                    }

                    // Adaptive Grid for Wide Screens, List for Mobile
                    return isWideScreen
                        ? GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: docs.length,
                            itemBuilder: (context, index) => _buildIssueCard(context, docs[index]),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: docs.length,
                            itemBuilder: (context, index) => _buildIssueCard(context, docs[index]),
                          );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
            label: const Text('Report Issue'),
          ),
        );
      },
    );
  }

  Widget _buildIssueCard(BuildContext context, QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final status = data['status'] ?? 'Open';
    final isClosed = status == 'Resolved';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(status),
                  backgroundColor: isClosed ? Colors.green.shade100 : Colors.orange.shade100,
                  labelStyle: TextStyle(color: isClosed ? Colors.green.shade900 : Colors.orange.shade900),
                ),
                Text(
                  (data['createdAt'] as Timestamp?)?.toDate().toString().split(' ')[0] ?? '',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Text(
                data['description'] ?? 'No Description',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
