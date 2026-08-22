import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const AssignmentPortalApp());
}

class AssignmentPortalApp extends StatelessWidget {
  const AssignmentPortalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Assignment Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      home: const MainDashboard(),
    );
  }
}

// ==================================================
// MAIN DASHBOARD (BOTTOM NAVIGATION)
// ==================================================
class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),       // Screen 1
    const TooltipDemoScreen(),// Screen 10
    const RateExperienceScreen(), // Screen 7
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.touch_app), label: 'Tooltips'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Rate'),
        ],
      ),
    );
  }
}

// ==================================================
// SCREEN 1: ASSIGNMENT DETAILS (HOME)
// ==================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Student Assignment Portal'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Placeholder for the illustration
            Center(
              child: Container(
                height: 120,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.school, size: 80, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 20),

            // Assignment Details Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Assignment Details',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 30),
                    _buildDetailRow('Assignment', 'Flutter UI Widgets'),
                    _buildDetailRow('Subject', 'Mobile Application Dev.'),
                    _buildDetailRow('Faculty', 'Mr. Pankaj Kapoor'),
                    _buildDetailRow('Last Date', '30 July 2026'),
                    _buildDetailRow('Total Marks', '100'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SubmitAssignmentScreen()));
              },
              icon: const Icon(Icons.upload, color: Colors.white),
              label: const Text('Submit Assignment', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 15),

            // View Guidelines Button
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AssignmentGuidelinesScreen()));
              },
              icon: const Icon(Icons.description, color: Colors.deepPurple),
              label: const Text('View Assignment Guidelines', style: TextStyle(color: Colors.deepPurple)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                side: const BorderSide(color: Colors.deepPurple),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}

// ==================================================
// SCREENS 2, 3, & 4: SUBMISSION FORM & PICKERS
// ==================================================
class SubmitAssignmentScreen extends StatefulWidget {
  const SubmitAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<SubmitAssignmentScreen> createState() => _SubmitAssignmentScreenState();
}

class _SubmitAssignmentScreenState extends State<SubmitAssignmentScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isFileUploaded = false;

  // Screen 3: Date Picker Dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.deepPurple),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Screen 4: Time Picker Dialog
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.deepPurple),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Assignment')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date Picker Field
            const Text('Select Submission Date', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate == null
                        ? '28 July 2026' // Default from image
                        : '${_selectedDate!.day} ${_selectedDate!.month} ${_selectedDate!.year}'),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Time Picker Field
            const Text('Select Submission Time', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _selectTime(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedTime == null
                        ? '03:30 PM' // Default from image
                        : _selectedTime!.format(context)),
                    const Icon(Icons.access_time, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // File Upload Section
            const Text('Upload Assignment File', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),

            if (!_isFileUploaded)
              OutlinedButton.icon(
                onPressed: () => setState(() => _isFileUploaded = true),
                icon: const Icon(Icons.upload_file),
                label: const Text('Tap to select file'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  side: BorderSide(color: Colors.grey.shade400, style: BorderStyle.solid),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('assignment_flutter.pdf', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('2.3 MB', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => setState(() => _isFileUploaded = false),
                    )
                  ],
                ),
              ),

            const SizedBox(height: 8),
            Text('(PDF, DOCX, ZIP files only)', style: TextStyle(color: Colors.grey[500], fontSize: 12)),

            const Spacer(),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const UploadingScreen())
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Submit Assignment', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// SCREEN 5: UPLOADING SCREEN
// ==================================================
class UploadingScreen extends StatefulWidget {
  const UploadingScreen({Key? key}) : super(key: key);

  @override
  State<UploadingScreen> createState() => _UploadingScreenState();
}

class _UploadingScreenState extends State<UploadingScreen> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _simulateUpload();
  }

  void _simulateUpload() {
    Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        _progress += 1;
      });
      if (_progress >= 100) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SubmissionSuccessfulScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Uploading Assignment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_upload, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text('Uploading Assignment...', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 40),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircularProgressIndicator(
                    value: _progress / 100,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[200],
                    color: Colors.deepPurple,
                  ),
                ),
                Text('${_progress.toInt()}%', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ==================================================
// SCREEN 6: SUBMISSION SUCCESSFUL
// ==================================================
class SubmissionSuccessfulScreen extends StatelessWidget {
  const SubmissionSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submission Successful'), automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Assignment Submitted\nSuccessfully!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _buildInfoRow('Student Name', 'Rahul Sharma'),
            _buildInfoRow('Assignment', 'Flutter UI Widgets'),
            _buildInfoRow('Submission Date', '28 July 2026'),
            _buildInfoRow('Submission Time', '03:30 PM'),
            const SizedBox(height: 20),
            const Text('Uploaded File', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.picture_as_pdf, color: Colors.red),
                SizedBox(width: 10),
                Text('assignment_flutter.pdf', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Back to Home', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ==================================================
// SCREEN 7: RATE EXPERIENCE
// ==================================================
class RateExperienceScreen extends StatefulWidget {
  const RateExperienceScreen({Key? key}) : super(key: key);

  @override
  State<RateExperienceScreen> createState() => _RateExperienceScreenState();
}

class _RateExperienceScreenState extends State<RateExperienceScreen> {
  int _rating = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Your Experience')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'How was your assignment\nsubmission experience?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () => setState(() => _rating = index + 1),
                );
              }),
            ),
            const SizedBox(height: 20),
            Text(
              '$_rating.0 / 5',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            const Text(
              'Thank you for your feedback!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rating Submitted!')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Submit Rating', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// SCREEN 8: ASSIGNMENT GUIDELINES
// ==================================================
class AssignmentGuidelinesScreen extends StatelessWidget {
  const AssignmentGuidelinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment Guidelines')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Assignment Guidelines',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            const Text('Objective', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 5),
            const Text('Build a Flutter application using the widgets learned in the class.'),
            const SizedBox(height: 20),
            const Text('Instructions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            _buildBulletPoint('Use proper UI design.'),
            _buildBulletPoint('Follow best coding practices.'),
            _buildBulletPoint('Submit before the last date.'),
            _buildBulletPoint('Upload in PDF or ZIP format.'),
            const Spacer(),

            // Link to Webview (Screen 9)
            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FlutterDocumentationMockScreen()));
                },
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Open Flutter Docs'),
              ),
            ),

            // Mock Browser Toolbar at bottom
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.arrow_back_ios, color: Colors.grey),
                Icon(Icons.arrow_forward_ios, color: Colors.grey),
                Icon(Icons.refresh, color: Colors.grey),
                Icon(Icons.ios_share, color: Colors.grey),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

// ==================================================
// SCREEN 9: FLUTTER DOCS (Mock WebView)
// ==================================================
class FlutterDocumentationMockScreen extends StatelessWidget {
  const FlutterDocumentationMockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulating a WebView with native widgets to avoid plugin dependencies
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Documentation')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fake Web Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  FlutterLogo(size: 30, style: FlutterLogoStyle.horizontal),
                  Icon(Icons.menu),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Build apps for\nany platform',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, height: 1.2),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Flutter is an open source UI software development kit created by Google.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[600]),
                    child: const Text('Get started', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 40),

                  // Mock device illustration
                  Center(
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Container(
                          width: 150, height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(height: 40, color: Colors.blue[100]),
                              const SizedBox(height: 10),
                              Container(height: 20, width: 100, color: Colors.blue[100]),
                            ],
                          ),
                        ),
                        Positioned(
                          right: -30,
                          child: Container(
                            width: 100, height: 150,
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ==================================================
// SCREEN 10: TOOLTIP DEMO
// ==================================================
class TooltipDemoScreen extends StatelessWidget {
  const TooltipDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tooltip Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                children: [
                  _buildTooltipItem('Select Date', Icons.calendar_month, Colors.deepPurple),
                  _buildTooltipItem('Select Time', Icons.access_time, Colors.deepPurple),
                  _buildTooltipItem('Upload File', Icons.folder, Colors.amber),
                  _buildTooltipItem('Rate Experience', Icons.star, Colors.amber),
                  _buildTooltipItem('Open Guidelines', Icons.description, Colors.deepPurple),
                  _buildTooltipItem('Open Docs', Icons.language, Colors.blue),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Long press on any icon\nto see tooltip',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTooltipItem(String message, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 10)),
        ),
        const SizedBox(height: 10),
        Tooltip(
          message: message,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, size: 30, color: color),
          ),
        ),
      ],
    );
  }
}