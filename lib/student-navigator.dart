import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Information Navigator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      // Defining named routes for the application
      routes: {
        '/editCourse': (context) => const EditCourseScreen(),
      },
    );
  }
}

// ==================================================
// 1. HOME SCREEN
// ==================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();

  String? _selectedCourse = 'Flutter';
  String? _updatedCourse; // To store the returned course

  final List<String> _courses = ['Flutter', 'Java', 'Python', 'AI'];

  @override
  void dispose() {
    _nameController.dispose();
    _rollNoController.dispose();
    super.dispose();
  }

  // Function to navigate and wait for data to return
  Future<void> _navigateToDetails() async {
    if (_formKey.currentState!.validate()) {

      // Navigator.push() - Home to Student Details
      // Navigating and passing data through the constructor
      final returnedCourse = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentDetailsScreen(
            name: _nameController.text,
            rollNumber: _rollNoController.text,
            course: _selectedCourse!,
          ),
        ),
      );

      // Updating the home screen if a new course was returned
      if (returnedCourse != null) {
        setState(() {
          _updatedCourse = returnedCourse as String;
          _selectedCourse = _updatedCourse; // Update dropdown selection too
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Information', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Placeholder for student image as seen in reference
                const Icon(
                  Icons.school,
                  size: 100,
                  color: Colors.amber,
                ),
                const SizedBox(height: 20),

                // Student Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Student Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter Student Name' : null,
                ),
                const SizedBox(height: 15),

                // Roll Number Field
                TextFormField(
                  controller: _rollNoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Roll Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter Roll Number' : null,
                ),
                const SizedBox(height: 15),

                // Select Course Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCourse,
                  decoration: const InputDecoration(
                    labelText: 'Select Course',
                    border: OutlineInputBorder(),
                  ),
                  items: _courses.map((String course) {
                    return DropdownMenuItem<String>(
                      value: course,
                      child: Text(course),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCourse = newValue;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // View Details Button
                ElevatedButton.icon(
                  onPressed: _navigateToDetails,
                  icon: const Icon(Icons.open_in_new, color: Colors.white),
                  label: const Text('View Details', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Display updated course block (only if updated course exists)
                if (_updatedCourse != null)
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Updated Course:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _updatedCourse!,
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================================================
// 2. STUDENT DETAILS SCREEN
// ==================================================
class StudentDetailsScreen extends StatefulWidget {
  final String name;
  final String rollNumber;
  final String course;

  const StudentDetailsScreen({
    Key? key,
    required this.name,
    required this.rollNumber,
    required this.course,
  }) : super(key: key);

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  late String _currentCourse;

  @override
  void initState() {
    super.initState();
    // Initialize state with passed data
    _currentCourse = widget.course;
  }

  // Navigate to Edit screen and wait for result
  Future<void> _editCourse() async {
    // Navigator.pushNamed() - Student Details to Edit Course
    // Passing current course as an argument
    final result = await Navigator.pushNamed(
      context,
      '/editCourse',
      arguments: _currentCourse,
    );

    // If a new course was returned, update the UI
    if (result != null) {
      setState(() {
        _currentCourse = result as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Details Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        'Student Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: const Text('Name', style: TextStyle(fontSize: 12)),
                        subtitle: Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Icon(Icons.badge, color: Colors.white),
                        ),
                        title: const Text('Roll No', style: TextStyle(fontSize: 12)),
                        subtitle: Text(widget.rollNumber, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.indigo,
                          child: Icon(Icons.school, color: Colors.white),
                        ),
                        title: const Text('Course', style: TextStyle(fontSize: 12)),
                        subtitle: Text(
                            _currentCourse,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green[700])
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Edit Course Button
              ElevatedButton.icon(
                onPressed: _editCourse,
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text('Edit Course', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Go Back Button
              OutlinedButton.icon(
                onPressed: () {
                  // Navigator.pop() - Return updated course to Home
                  Navigator.pop(context, _currentCourse);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================
// 3. EDIT COURSE SCREEN
// ==================================================
class EditCourseScreen extends StatefulWidget {
  const EditCourseScreen({Key? key}) : super(key: key);

  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  String? _selectedCourse;
  final List<String> _courses = ['Flutter', 'Java', 'Python', 'AI'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the passed argument (current course) on initialization
    if (_selectedCourse == null) {
      _selectedCourse = ModalRoute.of(context)!.settings.arguments as String?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Course', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select New Course',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
              ),
              const SizedBox(height: 20),

              // Generate Radio buttons for each course option
              Expanded(
                child: ListView(
                  children: _courses.map((String course) {
                    return RadioListTile<String>(
                      title: Text(course),
                      value: course,
                      groupValue: _selectedCourse,
                      activeColor: Colors.orange[800],
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCourse = value;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              // Save Changes Button
              ElevatedButton.icon(
                onPressed: () {
                  // Navigator.pop() - Return selected course
                  Navigator.pop(context, _selectedCourse);
                },
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text('Save Changes', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[800],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}