import 'package:flutter/material.dart';

void main() {
  runApp(const StudentRegistrationApp());
}

class StudentRegistrationApp extends StatelessWidget {
  const StudentRegistrationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Registration',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
          ),
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String? _selectedCourse;

  // List of courses for the dropdown
  final List<String> _courses = [
    'B.Tech Computer Science',
    'B.Tech Information Technology',
    'B.Tech Electronics',
    'B.Tech Mechanical',
    'BCA',
    'MCA'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _rollNoController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _mobileController.clear();
    _rollNoController.clear();
    _cityController.clear();
    setState(() {
      _selectedCourse = null;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFFE8F5E9),
                  child: Icon(Icons.check, color: Colors.green, size: 40),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Student Registered\nSuccessfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                _buildDialogDetailRow(Icons.person, 'Name', _nameController.text),
                _buildDialogDetailRow(Icons.email, 'Email', _emailController.text),
                _buildDialogDetailRow(Icons.phone, 'Mobile', _mobileController.text),
                _buildDialogDetailRow(Icons.badge, 'Roll No', _rollNoController.text),
                _buildDialogDetailRow(Icons.menu_book, 'Course', _selectedCourse ?? ''),
                _buildDialogDetailRow(Icons.location_on, 'City', _cityController.text),
                const SizedBox(height: 24),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _resetForm(); // Optional: reset form after success
                    },
                    child: const Text('OK'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.indigo[900]),
          const SizedBox(width: 12),
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          const Text(' : ', style: TextStyle(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Icon
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.school, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Student Registration',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Please fill in the details to register',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 32),

                // Form Fields
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name *',
                  icon: Icons.person,
                  validatorMessage: 'Please enter your full name',
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  controller: _emailController,
                  label: 'Email Address *',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validatorMessage: 'Please enter your email address',
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  controller: _mobileController,
                  label: 'Mobile Number *',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validatorMessage: 'Please enter 10 digit mobile number',
                  isMobile: true,
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  controller: _rollNoController,
                  label: 'Roll Number *',
                  icon: Icons.badge,
                  keyboardType: TextInputType.number,
                  validatorMessage: 'Please enter your roll number',
                ),
                const SizedBox(height: 16),

                // Dropdown for Course
                DropdownButtonFormField<String>(
                  value: _selectedCourse,
                  decoration: InputDecoration(
                    labelText: 'Course *',
                    prefixIcon: Icon(Icons.menu_book, color: Colors.indigo[900]),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your course';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  controller: _cityController,
                  label: 'City *',
                  icon: Icons.location_on,
                  validatorMessage: 'Please enter your city',
                ),
                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _resetForm,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: BorderSide(color: Colors.grey.shade400),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: const Icon(Icons.send),
                        label: const Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
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

  // Helper widget for text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String validatorMessage,
    TextInputType keyboardType = TextInputType.text,
    bool isMobile = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.indigo[900]),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validatorMessage;
        }
        if (isMobile && value.length != 10) {
          return 'Please enter 10 digit mobile number';
        }
        return null;
      },
    );
  }
}