import 'package:flutter/material.dart';

void main() {
  runApp(const CollegePortalApp());
}

class CollegePortalApp extends StatelessWidget {
  const CollegePortalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Student Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// ==================================================
// MAIN SCREEN (BOTTOM NAVIGATION & DRAWER)
// ==================================================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // Views for the bottom navigation
  final List<Widget> _views = [
    const HomeDashboardView(),
    const AttendanceView(),
    const AssignmentsView(),
    const ProfileView(),
  ];

  // Dynamic AppBars depending on the selected bottom nav item
  PreferredSizeWidget? _buildAppBar() {
    switch (_selectedIndex) {
      case 0:
        return null; // Home view has a custom header instead
      case 1:
        return AppBar(
          title: const Text('My Attendance', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue[700],
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        );
      case 2:
        return AppBar(
          title: const Text('My Assignments', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        );
      case 3:
        return AppBar(
          title: const Text('My Profile', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green[600],
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const CustomDrawer(), // Matches Screen 1
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Assignments'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ==================================================
// SCREEN 1: DRAWER NAVIGATION
// ==================================================
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 20, left: 20),
            color: Colors.deepPurple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
                ),
                SizedBox(height: 15),
                Text('Pankaj Kapoor',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text('B.Tech CSE', style: TextStyle(color: Colors.white70)),
                Text('Roll No: 101', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.deepPurple),
            title: const Text('Dashboard', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
            tileColor: Colors.deepPurple.withOpacity(0.1),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () => Navigator.pop(context),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ==================================================
// SCREEN 4: BOTTOM NAV - HOME (DASHBOARD)
// ==================================================
class HomeDashboardView extends StatelessWidget {
  const HomeDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Teal Header
          Container(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
            decoration: BoxDecoration(
              color: Colors.teal[400],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Welcome Back 👋', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    SizedBox(height: 5),
                    Text('Pankaj Kapoor',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('B.Tech CSE | Roll No: 101', style: TextStyle(color: Colors.white)),
                  ],
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.teal),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Quick Links', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          // Grid of Quick Links
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 2.2,
              children: [
                _buildQuickLinkCard(
                    context,
                    'Courses',
                    Icons.menu_book,
                    Colors.orange[100]!,
                    Colors.orange[800]!,
                    0 // Tab index 0
                ),
                _buildQuickLinkCard(
                    context,
                    'Notices',
                    Icons.campaign,
                    Colors.purple[100]!,
                    Colors.purple[800]!,
                    1 // Tab index 1
                ),
                _buildQuickLinkCard(
                    context,
                    'Assignments',
                    Icons.assignment,
                    Colors.green[100]!,
                    Colors.green[800]!,
                    null // Optional: navigate to assignments tab directly if implemented
                ),
                _buildQuickLinkCard(
                    context,
                    'Results',
                    Icons.bar_chart,
                    Colors.red[100]!,
                    Colors.red[800]!,
                    2 // Tab index 2
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuickLinkCard(BuildContext context, String title, IconData icon, Color bgColor, Color iconColor, int? tabIndex) {
    return GestureDetector(
      onTap: () {
        if (tabIndex != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TabbedPortalScreen(initialIndex: tabIndex)),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// SCREEN 5: BOTTOM NAV - ATTENDANCE
// ==================================================
class AttendanceView extends StatelessWidget {
  const AttendanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Circular Progress Indicator
          SizedBox(
            height: 150,
            width: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey[200],
                  color: Colors.blue[700],
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('85%', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                      const Text('Present', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Stats List
          _buildAttendanceRow(Icons.menu_book, 'Total Classes', '120', Colors.blue),
          const Divider(),
          _buildAttendanceRow(Icons.check_circle, 'Classes Attended', '102', Colors.green),
          const Divider(),
          _buildAttendanceRow(Icons.event_busy, 'Classes Remaining', '18', Colors.red),
        ],
      ),
    );
  }

  Widget _buildAttendanceRow(IconData icon, String label, String value, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 15),
              Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ==================================================
// SCREEN 6: BOTTOM NAV - ASSIGNMENTS
// ==================================================
class AssignmentsView extends StatelessWidget {
  const AssignmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        _buildAssignmentCard('Flutter Assignment-13', 'Build Navigation UI', '22 May 2025', 'Due Tomorrow', Colors.blue, Colors.red),
        _buildAssignmentCard('Java Assignment-7', 'OOPs Concepts', '25 May 2025', '3 Days Left', Colors.green, Colors.orange),
        _buildAssignmentCard('Python Assignment-5', 'Functions & Modules', '28 May 2025', '6 Days Left', Colors.blue[800]!, Colors.green),
      ],
    );
  }

  Widget _buildAssignmentCard(String title, String subtitle, String date, String status, Color iconColor, Color statusColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.assignment, color: iconColor),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  const SizedBox(height: 10),
                  Text('Due: $date', style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: statusColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}

// ==================================================
// SCREEN 7: BOTTOM NAV - PROFILE
// ==================================================
class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'), // Placeholder for user image
          ),
          const SizedBox(height: 30),
          _buildProfileRow('Name', 'Pankaj Kapoor'),
          const Divider(),
          _buildProfileRow('Roll Number', '101'),
          const Divider(),
          _buildProfileRow('Branch', 'Computer Science'),
          const Divider(),
          _buildProfileRow('Year', '3rd Year'),
          const Divider(),
          _buildProfileRow('Email', 'pankaj@college.edu.in'),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ==================================================
// SCREEN 2 & 3: TABS (COURSES & NOTICES)
// ==================================================
class TabbedPortalScreen extends StatelessWidget {
  final int initialIndex;

  const TabbedPortalScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('College Student Portal', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(icon: const Icon(Icons.notifications), onPressed: () {})
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Courses'),
              Tab(text: 'Notices'),
              Tab(text: 'Results'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CoursesTabView(),
            NoticesTabView(),
            Center(child: Text('Results Coming Soon')), // Placeholder for Results tab
          ],
        ),
      ),
    );
  }
}

class CoursesTabView extends StatelessWidget {
  const CoursesTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        _buildCourseCard('Flutter Development', 'Learn Flutter from Basics', 'Instructor: Mr. Sharma', Icons.menu_book, Colors.blue),
        _buildCourseCard('Java Programming', 'Core Java and OOPs', 'Instructor: Ms. Joshi', Icons.local_cafe, Colors.green),
        _buildCourseCard('Python Programming', 'Python for Beginners', 'Instructor: Mr. Verma', Icons.code, Colors.amber),
      ],
    );
  }

  Widget _buildCourseCard(String title, String subtitle, String instructor, IconData icon, Color iconBg) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(subtitle),
            const SizedBox(height: 5),
            Text(instructor, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class NoticesTabView extends StatelessWidget {
  const NoticesTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        _buildNoticeCard('Holiday Tomorrow', '20 May 2025', 'College will remain closed tomorrow on account of Local Holiday.', Icons.campaign, Colors.deepPurple),
        _buildNoticeCard('Flutter Assignment Submission', '18 May 2025', 'Submit your Flutter Assignment-13 before 22 May 2025.', Icons.description, Colors.blue),
        _buildNoticeCard('Mid Semester Exam', '15 May 2025', 'Mid Semester Exams will start from 1st June 2025.', Icons.calendar_today, Colors.orange),
      ],
    );
  }

  Widget _buildNoticeCard(String title, String date, String description, IconData icon, Color iconColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 30),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 3),
                  Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(description, style: const TextStyle(fontSize: 13)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}