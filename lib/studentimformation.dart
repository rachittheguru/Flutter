import 'package:flutter/material.dart';

void main() {
  runApp(const StudentPortalApp());
}

class StudentPortalApp extends StatelessWidget {
  const StudentPortalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Information Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const StudentPortalHome(),
    );
  }
}

class StudentPortalHome extends StatefulWidget {
  const StudentPortalHome({Key? key}) : super(key: key);

  @override
  State<StudentPortalHome> createState() => _StudentPortalHomeState();
}

class _StudentPortalHomeState extends State<StudentPortalHome> {
  int _currentIndex = 0;

  // Function to show the Bottom Sheet
  void _showStudentActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Student Actions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              // Action List
              _buildActionTile(Icons.email, 'Send Email', Colors.blue, context),
              _buildActionTile(Icons.phone, 'Call Student', Colors.green, context),
              _buildActionTile(Icons.location_on, 'View Address', Colors.orange, context),
              // Highlighting the Share Profile tile to match the image interaction
              Container(
                color: Colors.deepPurple.withOpacity(0.1),
                child: ListTile(
                  leading: const Icon(Icons.share, color: Colors.deepPurple),
                  title: const Text('Share Profile', style: TextStyle(color: Colors.deepPurple)),
                  onTap: () {
                    // Close the bottom sheet
                    Navigator.pop(context);
                    // Show SnackBar
                    _showSuccessSnackBar(context);
                  },
                ),
              ),
              _buildActionTile(Icons.download, 'Download Marksheet', Colors.blue, context),
              _buildActionTile(Icons.cancel, 'Close', Colors.red, context, isClose: true),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Helper for Bottom Sheet Tiles
  Widget _buildActionTile(IconData icon, String title, Color color, BuildContext context, {bool isClose = false}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: () {
        if (isClose) {
          Navigator.pop(context);
        }
      },
    );
  }

  // Function to show the SnackBar
  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Student Profile Shared Successfully!',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {
            // Undo action logic here
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Row(
          children: const [
            Icon(Icons.school, color: Colors.white),
            SizedBox(width: 10),
            Text('Student Information Portal', style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Student Details Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.account_circle, color: Colors.deepPurple, size: 28),
                        SizedBox(width: 10),
                        Text('Student Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                      ],
                    ),
                    const Divider(height: 30),
                    _buildDetailRow(Icons.person, 'Student Name', 'Rahul Sharma'),
                    _buildDetailRow(Icons.email, 'Email', 'rahul@gmail.com'),
                    _buildDetailRow(Icons.phone, 'Mobile', '+91 9876543210'),
                    _buildDetailRow(Icons.badge, 'Roll Number', 'CS202501'),
                    _buildDetailRow(Icons.language, 'College Website', 'www.fluttercollege.com'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Student Marksheet Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.table_view, color: Colors.deepPurple, size: 28),
                        SizedBox(width: 10),
                        Text('Student Marksheet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Marks Table
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.5),
                      },
                      children: [
                        _buildTableHeader(),
                        _buildTableRow('Mathematics', '100', '95', Colors.green),
                        _buildTableRow('Science', '100', '90', Colors.green),
                        _buildTableRow('English', '100', '88', Colors.green),
                        _buildTableRow('Computer', '100', '98', Colors.green),
                        _buildTableRow('Hindi', '100', '85', Colors.black87), // Not highlighted in green
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem(Icons.assignment, 'Total Marks', '456 / 500', Colors.deepPurple),
                        _buildStatItem(Icons.percent, 'Percentage', '91.2%', Colors.black87),
                        _buildStatItem(Icons.star, 'Grade', 'A+', Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showStudentActions(context),
                icon: const Icon(Icons.list, color: Colors.white),
                label: const Text('Show Student Actions', style: TextStyle(color: Colors.white, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  // Helper widget for Student Details rows
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.black87)),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: TextStyle(color: Colors.blue[700], fontSize: 13)),
          ),
        ],
      ),
    );
  }

  // Helper widget for Table Header
  TableRow _buildTableHeader() {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.deepPurple),
      children: [
        _buildTableCell('Subject', isHeader: true),
        _buildTableCell('Max Marks', isHeader: true),
        _buildTableCell('Obtained', isHeader: true),
      ],
    );
  }

  // Helper widget for Table Rows
  TableRow _buildTableRow(String subject, String maxMarks, String obtained, Color obtainedColor) {
    return TableRow(
      children: [
        _buildTableCell(subject),
        _buildTableCell(maxMarks),
        _buildTableCell(obtained, textColor: obtainedColor, isBold: true),
      ],
    );
  }

  // Helper widget for Table Cells
  Widget _buildTableCell(String text, {bool isHeader = false, Color? textColor, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isHeader ? Colors.white : (textColor ?? Colors.black87),
          fontWeight: isHeader || isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  // Helper widget for Bottom Stats in Marksheet
  Widget _buildStatItem(IconData icon, String label, String value, Color valueColor) {
    return Column(
      children: [
        Icon(icon, color: Colors.deepPurple, size: 28),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: valueColor)),
      ],
    );
  }
}