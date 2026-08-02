import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StudentRegistrationApp());
}

class StudentRegistrationApp extends StatelessWidget {
  const StudentRegistrationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Registration System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          centerTitle: false,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}

// ==================================================
// MODELS / student_model.dart
// ==================================================
class Student {
  int? id;
  String studentName;
  String rollNumber;
  String email;
  String mobile;
  String department;
  String semester;
  double cgpa;

  Student({
    this.id,
    required this.studentName,
    required this.rollNumber,
    required this.email,
    required this.mobile,
    required this.department,
    required this.semester,
    required this.cgpa,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentName': studentName,
      'rollNumber': rollNumber,
      'email': email,
      'mobile': mobile,
      'department': department,
      'semester': semester,
      'cgpa': cgpa,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      studentName: map['studentName'],
      rollNumber: map['rollNumber'],
      email: map['email'],
      mobile: map['mobile'],
      department: map['department'],
      semester: map['semester'],
      cgpa: map['cgpa'],
    );
  }
}

// ==================================================
// DATABASE / database_helper.dart
// ==================================================
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('students.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        studentName TEXT NOT NULL,
        rollNumber TEXT NOT NULL,
        email TEXT NOT NULL,
        mobile TEXT NOT NULL,
        department TEXT NOT NULL,
        semester TEXT NOT NULL,
        cgpa REAL NOT NULL
      )
    ''');
  }

  Future<int> insertStudent(Student student) async {
    final db = await instance.database;
    return await db.insert('students', student.toMap());
  }

  Future<List<Student>> getAllStudents() async {
    final db = await instance.database;
    final result = await db.query('students', orderBy: 'id DESC');
    return result.map((json) => Student.fromMap(json)).toList();
  }

  Future<int> updateStudent(Student student) async {
    final db = await instance.database;
    return db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await instance.database;
    return await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// ==================================================
// SCREENS / registration_screen.dart
// ==================================================
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cgpaController = TextEditingController();

  String? _selectedDepartment = 'Computer Science';
  String? _selectedSemester = 'Semester 6';

  final List<String> _departments = ['Computer Science', 'Information Technology', 'ECE', 'Mechanical', 'Civil'];
  final List<String> _semesters = ['Semester 1', 'Semester 2', 'Semester 3', 'Semester 4', 'Semester 5', 'Semester 6', 'Semester 7', 'Semester 8'];

  @override
  void dispose() {
    _nameController.dispose();
    _rollNoController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _cgpaController.dispose();
    super.dispose();
  }

  Future<void> _registerStudent() async {
    if (_formKey.currentState!.validate()) {
      final newStudent = Student(
        studentName: _nameController.text,
        rollNumber: _rollNoController.text,
        email: _emailController.text,
        mobile: _mobileController.text,
        department: _selectedDepartment!,
        semester: _selectedSemester!,
        cgpa: double.parse(_cgpaController.text),
      );

      await DatabaseHelper.instance.insertStudent(newStudent);

      if (!mounted) return;

      // Clear form
      _formKey.currentState!.reset();
      _nameController.clear();
      _rollNoController.clear();
      _emailController.clear();
      _mobileController.clear();
      _cgpaController.clear();
      setState(() {
        _selectedDepartment = 'Computer Science';
        _selectedSemester = 'Semester 6';
      });

      // Navigate to Success Screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentRegisteredScreen(student: newStudent),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(controller: _nameController, label: 'Student Name', icon: Icons.person, hint: 'e.g., Rachit Sharma'),
                const SizedBox(height: 15),
                _buildTextField(controller: _rollNoController, label: 'Roll Number', icon: Icons.badge),
                const SizedBox(height: 15),
                _buildTextField(controller: _emailController, label: 'Email Address', icon: Icons.email, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 15),
                _buildTextField(controller: _mobileController, label: 'Mobile Number', icon: Icons.phone, keyboardType: TextInputType.phone),
                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: _selectedDepartment,
                  decoration: _inputDecoration('Department', Icons.business),
                  items: _departments.map((dept) => DropdownMenuItem(value: dept, child: Text(dept))).toList(),
                  onChanged: (value) => setState(() => _selectedDepartment = value),
                ),
                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: _selectedSemester,
                  decoration: _inputDecoration('Semester', Icons.calendar_today),
                  items: _semesters.map((sem) => DropdownMenuItem(value: sem, child: Text(sem))).toList(),
                  onChanged: (value) => setState(() => _selectedSemester = value),
                ),
                const SizedBox(height: 15),

                _buildTextField(controller: _cgpaController, label: 'CGPA', icon: Icons.bar_chart, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        onPressed: _registerStudent,
                        icon: const Icon(Icons.person_add),
                        label: const Text('Register Student'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentListScreen()));
                        },
                        icon: const Icon(Icons.list),
                        label: const Text('View Students'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          side: const BorderSide(color: Colors.deepPurple),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon, String? hint, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(label, icon, hint: hint),
      validator: (value) => (value == null || value.isEmpty) ? 'Required field' : null,
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.black87),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
    );
  }
}

// ==================================================
// SCREENS / student_registered_screen.dart (Success Screen)
// ==================================================
class StudentRegisteredScreen extends StatelessWidget {
  final Student student;
  const StudentRegisteredScreen({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''), automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text('Student Registered\nSuccessfully!', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.shade200)),
              child: Column(
                children: [
                  _buildRow('Name', student.studentName),
                  _buildRow('Roll No', student.rollNumber),
                  _buildRow('Department', student.department),
                  _buildRow('Semester', student.semester),
                  _buildRow('CGPA', student.cgpa.toString()),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StudentListScreen()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('View All Students'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Add Another Student', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          const Text(' :  '),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }
}

// ==================================================
// SCREENS / student_list_screen.dart
// ==================================================
class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student> _students = [];
  List<Student> _filteredStudents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshStudents();
  }

  Future<void> _refreshStudents() async {
    final data = await DatabaseHelper.instance.getAllStudents();
    setState(() {
      _students = data;
      _filteredStudents = data;
      _isLoading = false;
    });
  }

  void _filterStudents(String query) {
    final filtered = _students.where((student) {
      final nameLower = student.studentName.toLowerCase();
      final rollLower = student.rollNumber.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower) || rollLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredStudents = filtered;
    });
  }

  Future<void> _deleteStudent(int id) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: const [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 10),
            Text('Delete Student'),
          ],
        ),
        content: const Text('Are you sure you want to delete this student record?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm) {
      await DatabaseHelper.instance.deleteStudent(id);
      _refreshStudents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registered Students')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterStudents,
              decoration: InputDecoration(
                hintText: 'Search by name or roll number...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Total Students: ${_filteredStudents.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.deepPurple),
                  headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Roll No')),
                    DataColumn(label: Text('Dept.')),
                    DataColumn(label: Text('Sem')),
                    DataColumn(label: Text('CGPA')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: _filteredStudents.map((student) {
                    return DataRow(
                      cells: [
                        DataCell(Text(student.studentName)),
                        DataCell(Text(student.rollNumber)),
                        DataCell(Text(student.department.split(' ').map((e) => e[0]).join())), // Abbreviate Dept
                        DataCell(Text(student.semester.replaceAll('Semester ', 'Sem '))),
                        DataCell(Text(student.cgpa.toString())),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                                onPressed: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => EditStudentScreen(student: student)));
                                  _refreshStudents();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                onPressed: () => _deleteStudent(student.id!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.swipe, color: Colors.grey[600], size: 16),
                const SizedBox(width: 8),
                Text('Swipe left or right to see more columns', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ==================================================
// SCREENS / edit_student_screen.dart
// ==================================================
class EditStudentScreen extends StatefulWidget {
  final Student student;
  const EditStudentScreen({Key? key, required this.student}) : super(key: key);

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _rollNoController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _cgpaController;

  late String _selectedDepartment;
  late String _selectedSemester;

  final List<String> _departments = ['Computer Science', 'Information Technology', 'ECE', 'Mechanical', 'Civil'];
  final List<String> _semesters = ['Semester 1', 'Semester 2', 'Semester 3', 'Semester 4', 'Semester 5', 'Semester 6', 'Semester 7', 'Semester 8'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student.studentName);
    _rollNoController = TextEditingController(text: widget.student.rollNumber);
    _emailController = TextEditingController(text: widget.student.email);
    _mobileController = TextEditingController(text: widget.student.mobile);
    _cgpaController = TextEditingController(text: widget.student.cgpa.toString());
    _selectedDepartment = widget.student.department;
    _selectedSemester = widget.student.semester;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollNoController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _cgpaController.dispose();
    super.dispose();
  }

  Future<void> _updateStudent() async {
    if (_formKey.currentState!.validate()) {
      final updatedStudent = Student(
        id: widget.student.id,
        studentName: _nameController.text,
        rollNumber: _rollNoController.text,
        email: _emailController.text,
        mobile: _mobileController.text,
        department: _selectedDepartment,
        semester: _selectedSemester,
        cgpa: double.parse(_cgpaController.text),
      );

      await DatabaseHelper.instance.updateStudent(updatedStudent);

      if (!mounted) return;
      Navigator.pop(context); // Go back to list screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Student')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(controller: _nameController, label: 'Student Name', icon: Icons.person),
                const SizedBox(height: 15),
                _buildTextField(controller: _rollNoController, label: 'Roll Number', icon: Icons.badge),
                const SizedBox(height: 15),
                _buildTextField(controller: _emailController, label: 'Email Address', icon: Icons.email, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 15),
                _buildTextField(controller: _mobileController, label: 'Mobile Number', icon: Icons.phone, keyboardType: TextInputType.phone),
                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: _selectedDepartment,
                  decoration: _inputDecoration('Department', Icons.business),
                  items: _departments.map((dept) => DropdownMenuItem(value: dept, child: Text(dept))).toList(),
                  onChanged: (value) => setState(() => _selectedDepartment = value!),
                ),
                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: _selectedSemester,
                  decoration: _inputDecoration('Semester', Icons.calendar_today),
                  items: _semesters.map((sem) => DropdownMenuItem(value: sem, child: Text(sem))).toList(),
                  onChanged: (value) => setState(() => _selectedSemester = value!),
                ),
                const SizedBox(height: 15),

                _buildTextField(controller: _cgpaController, label: 'CGPA', icon: Icons.bar_chart, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        onPressed: _updateStudent,
                        icon: const Icon(Icons.save),
                        label: const Text('Update Student'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        label: const Text('Cancel'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          side: const BorderSide(color: Colors.deepPurple),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(label, icon),
      validator: (value) => (value == null || value.isEmpty) ? 'Required field' : null,
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.black87),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
    );
  }
}