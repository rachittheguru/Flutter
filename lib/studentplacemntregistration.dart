import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const PlacementApp());
}

class PlacementApp extends StatelessWidget {
  const PlacementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Placement Registration',
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
// SCREEN 1 & 3: REGISTRATION / EDIT FORM
// ==================================================
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cgpaController = TextEditingController();

  String? _selectedBranch = 'Computer Science';
  bool _isInterested = true;
  bool _showSuccessMessage = false;

  final List<String> _branches = [
    'Computer Science',
    'Information Technology',
    'Electronics',
    'Mechanical',
    'Civil'
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  // Load data from SharedPreferences to pre-fill the form (Edit Mode)
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('name')) {
      setState(() {
        _nameController.text = prefs.getString('name') ?? '';
        _rollNoController.text = prefs.getString('rollNo') ?? '';
        _emailController.text = prefs.getString('email') ?? '';
        _mobileController.text = prefs.getString('mobile') ?? '';
        _cgpaController.text = prefs.getString('cgpa') ?? '';
        _selectedBranch = prefs.getString('branch') ?? 'Computer Science';
        _isInterested = prefs.getBool('interested') ?? true;
      });
    }
  }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text);
      await prefs.setString('rollNo', _rollNoController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('mobile', _mobileController.text);
      await prefs.setString('cgpa', _cgpaController.text);
      await prefs.setString('branch', _selectedBranch!);
      await prefs.setBool('interested', _isInterested);

      setState(() {
        _showSuccessMessage = true;
      });

      // Hide success message after 2 seconds and navigate to Dashboard
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showSuccessMessage = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          ).then((_) => _loadSavedData()); // Reload data when returning from dashboard
        }
      });
    }
  }

  // Clear form and SharedPreferences
  Future<void> _clearForm() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      _nameController.clear();
      _rollNoController.clear();
      _emailController.clear();
      _mobileController.clear();
      _cgpaController.clear();
      _selectedBranch = 'Computer Science';
      _isInterested = true;
      _showSuccessMessage = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Placement Registration'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Illustration Placeholder
                Center(
                  child: Container(
                    height: 120,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.school, size: 80, color: Colors.deepPurple),
                  ),
                ),
                const SizedBox(height: 20),

                // Form Container
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Register Your Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                        controller: _nameController,
                        label: 'Student Name',
                        hint: 'e.g., Rachit Sharma',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 15),

                      _buildTextField(
                        controller: _rollNoController,
                        label: 'Roll Number',
                        icon: Icons.badge,
                      ),
                      const SizedBox(height: 15),

                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),

                      _buildTextField(
                        controller: _mobileController,
                        label: 'Mobile Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 15),

                      // Branch Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedBranch,
                        decoration: InputDecoration(
                          labelText: 'Branch',
                          prefixIcon: const Icon(Icons.business, color: Colors.black87),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        items: _branches.map((String branch) {
                          return DropdownMenuItem<String>(
                            value: branch,
                            child: Text(branch),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedBranch = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 15),

                      _buildTextField(
                        controller: _cgpaController,
                        label: 'CGPA',
                        icon: Icons.bar_chart,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                      const SizedBox(height: 15),

                      // Interested Switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.person_add, color: Colors.black87),
                              SizedBox(width: 10),
                              Text('Interested in Placement', style: TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Switch(
                            value: _isInterested,
                            activeColor: Colors.deepPurple,
                            onChanged: (bool value) {
                              setState(() {
                                _isInterested = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _saveData,
                              icon: const Icon(Icons.save, size: 18),
                              label: const Text('SAVE DETAILS'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _clearForm,
                              icon: const Icon(Icons.delete_outline, size: 18),
                              label: const Text('CLEAR FORM'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.deepPurple,
                                side: const BorderSide(color: Colors.deepPurple),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Success Message Banner
                if (_showSuccessMessage) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 10),
                        Text(
                          'Registration Saved Successfully!',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}

// ==================================================
// SCREEN 2: DASHBOARD
// ==================================================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic> studentData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
  }

  Future<void> _fetchSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      studentData = {
        'name': prefs.getString('name') ?? 'N/A',
        'rollNo': prefs.getString('rollNo') ?? 'N/A',
        'email': prefs.getString('email') ?? 'N/A',
        'mobile': prefs.getString('mobile') ?? 'N/A',
        'branch': prefs.getString('branch') ?? 'N/A',
        'cgpa': prefs.getString('cgpa') ?? 'N/A',
        'interested': prefs.getBool('interested') ?? false,
      };
      isLoading = false;
    });
  }

  Future<void> _deleteDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) {
      Navigator.pop(context); // Go back to registration screen
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Placement Dashboard'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Banner
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.person, color: Colors.white, size: 35),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${studentData['name']}!',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Your placement details are saved.',
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Details List
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _buildDetailRow(Icons.person, 'Student Name', studentData['name']),
                    _buildDetailRow(Icons.badge, 'Roll Number', studentData['rollNo']),
                    _buildDetailRow(Icons.email, 'Email', studentData['email']),
                    _buildDetailRow(Icons.phone, 'Mobile Number', studentData['mobile']),
                    _buildDetailRow(Icons.business, 'Branch', studentData['branch']),
                    _buildDetailRow(Icons.bar_chart, 'CGPA', studentData['cgpa']),

                    // Placement Status Row
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.workspace_premium, color: Colors.deepPurple, size: 20),
                          const SizedBox(width: 15),
                          const Expanded(child: Text('Placement Status', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500))),
                          Row(
                            children: [
                              Icon(
                                studentData['interested'] ? Icons.check_circle : Icons.cancel,
                                color: studentData['interested'] ? Colors.green : Colors.red,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                studentData['interested'] ? 'Interested' : 'Not Interested',
                                style: TextStyle(
                                  color: studentData['interested'] ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Action Buttons
              ElevatedButton.icon(
                onPressed: () {
                  // Popping returns to the RegistrationScreen, which will reload the saved data
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.edit),
                label: const Text('EDIT DETAILS'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _deleteDetails,
                icon: const Icon(Icons.delete),
                label: const Text('DELETE DETAILS'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}