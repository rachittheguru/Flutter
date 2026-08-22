import 'package:flutter/material.dart';

void main() {
  runApp(const HiveCrudApp());
}

// ==================================================
// DATA MODEL
// ==================================================
class Student {
  final int id;
  String name;
  String course;
  int age;

  Student({
    required this.id,
    required this.name,
    required this.course,
    required this.age,
  });
}

class HiveCrudApp extends StatelessWidget {
  const HiveCrudApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive CRUD - Update Student',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HiveScreen(),
    );
  }
}

// ==================================================
// SCREEN 1 & 3: HIVE CRUD STUDENTS (LIST SCREEN)
// ==================================================
class HiveScreen extends StatefulWidget {
  const HiveScreen({Key? key}) : super(key: key);

  @override
  State<HiveScreen> createState() => _HiveScreenState();
}

class _HiveScreenState extends State<HiveScreen> {
  // Simulating a Hive box database for this UI demonstration
  List<Student> hiveBoxData = [
    Student(id: 1, name: 'Rahul', course: 'BCA', age: 20),
    Student(id: 2, name: 'Aman', course: 'B.Tech', age: 21),
    Student(id: 3, name: 'Priya', course: 'MBA', age: 23),
    Student(id: 4, name: 'Neha', course: 'MCA', age: 22),
    Student(id: 5, name: 'Rohit', course: 'BBA', age: 19),
  ];

  // Tracks the ID of the recently updated student to highlight them in purple
  // (Matching the 3rd phone in the reference image)
  int? _lastUpdatedId;

  // Simulate Hive delete action
  void _deleteStudent(int index) {
    setState(() {
      hiveBoxData.removeAt(index);
    });
  }

  // Navigate to Update Screen and await the returned modified data
  Future<void> _navigateToUpdateScreen(BuildContext context, int index) async {
    final updatedStudent = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateStudentScreen(
          student: hiveBoxData[index],
        ),
      ),
    );

    // If data was returned (Update was clicked, not Cancel)
    if (updatedStudent != null) {
      setState(() {
        hiveBoxData[index] = updatedStudent as Student;
        _lastUpdatedId = updatedStudent.id; // Trigger purple highlight for the updated row
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Hive CRUD Students'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        itemCount: hiveBoxData.length,
        itemBuilder: (context, index) {
          final student = hiveBoxData[index];

          // Check if this specific student was just updated to highlight their name
          final isUpdated = student.id == _lastUpdatedId;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                title: Text(
                  student.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isUpdated ? Colors.deepPurple : Colors.black87,
                  ),
                ),
                subtitle: Text(
                  '${student.course} | Age : ${student.age} | ID : ${student.id}',
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.deepPurple, size: 22),
                      onPressed: () => _navigateToUpdateScreen(context, index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red, size: 22),
                      onPressed: () => _deleteStudent(index),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==================================================
// SCREEN 2: UPDATE STUDENT SCREEN
// ==================================================
class UpdateStudentScreen extends StatefulWidget {
  final Student student;

  const UpdateStudentScreen({Key? key, required this.student}) : super(key: key);

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  late TextEditingController _nameController;
  late TextEditingController _courseController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    // Pre-fill the TextFields with the existing student data
    _nameController = TextEditingController(text: widget.student.name);
    _courseController = TextEditingController(text: widget.student.course);
    _ageController = TextEditingController(text: widget.student.age.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _updateStudent() {
    // Create a new Student instance with the modified TextField data
    final updatedStudent = Student(
      id: widget.student.id,
      name: _nameController.text,
      course: _courseController.text,
      age: int.tryParse(_ageController.text) ?? widget.student.age,
    );

    // Return the updated data back to the HiveScreen list
    Navigator.pop(context, updatedStudent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Update Student'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLabel('Name'),
            _buildTextField(_nameController),
            const SizedBox(height: 20),

            _buildLabel('Course'),
            _buildTextField(_courseController),
            const SizedBox(height: 20),

            _buildLabel('Age'),
            _buildTextField(_ageController, isNumber: true),
            const SizedBox(height: 32),

            // Update Button
            ElevatedButton(
              onPressed: _updateStudent,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('UPDATE STUDENT', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),

            // Cancel Button
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context); // Pops the screen without returning new data
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepPurple,
                side: BorderSide(color: Colors.deepPurple.shade300),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('CANCEL', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the labels above TextFields
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  // Helper widget to build the TextFields with consistent styling
  Widget _buildTextField(TextEditingController controller, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
      ),
    );
  }
}