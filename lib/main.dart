import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Stateless Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

// Stateful Widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isFollowing ? "Following Profile" : "Flutter Profile",
        ),
        backgroundColor:
        isFollowing ? Colors.green : Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 70,

            ),

            const SizedBox(height: 20),

            const Text(
              "John Doe",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Flutter Developer",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "john@example.com",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                isFollowing ? Colors.green : Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                setState(() {
                  isFollowing = !isFollowing;
                });
              },
              icon: Icon(
                isFollowing
                    ? Icons.check
                    : Icons.person_add_alt_1,
                color: Colors.white,
              ),
              label: Text(
                isFollowing ? "Following" : "Follow",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}