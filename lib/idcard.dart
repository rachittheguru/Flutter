import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentIDCard(),
    );
  }
}

class StudentIDCard extends StatelessWidget {
  const StudentIDCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student ID Card"),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(2, 4),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [

              Icon(
                Icons.account_circle,
                size: 110,
                color: Colors.blue,
              ),

              SizedBox(height: 20),

              Text(
                "Rahul Sharma",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "B.Tech CSE",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Roll No: 101",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}