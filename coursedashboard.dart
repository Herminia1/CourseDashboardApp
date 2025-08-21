import 'package:flutter/material.dart';

void main() {
  runApp(const CourseDashboardApp());
}

class CourseDashboardApp extends StatelessWidget {
  const CourseDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Dashboard',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Dropdown
  String? _selectedCategory;

  // Courses
  final List<Map<String, String>> _courses = [
    {"name": "Programming Fundamentals", "instructor": "Dr. Asare"},
    {"name": "Database Systems", "instructor": "Prof. Mensah"},
    {"name": "Web Development", "instructor": "Dr. Owusu"},
    {"name": "Networking", "instructor": "Mr. Adjei"},
    {"name": "Cyber Security", "instructor": "Dr. Boateng"},
  ];

  // Pages
  List<Widget> get _pages => [
        _homePage(),
        _coursesPage(),
        _profilePage(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ✅ Home Page
  Widget _homePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome to Course Dashboard",
              style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 20),

          // Animated Button
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 400),
            tween: Tween<double>(begin: 1, end: 1.1),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Enroll in a Course"),
                ),
              );
            },
          ),

          const SizedBox(height: 40),

          // Dropdown
          DropdownButton<String>(
            hint: const Text("Select Course Category"),
            value: _selectedCategory,
            items: ["Science", "Arts", "Technology"]
                .map((category) =>
                    DropdownMenuItem(value: category, child: Text(category)))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          ),

          if (_selectedCategory != null) ...[
            const SizedBox(height: 20),
            Text("Selected Category: $_selectedCategory",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ]
        ],
      ),
    );
  }

  // ✅ Courses Page
  Widget _coursesPage() {
    return ListView.builder(
      itemCount: _courses.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.book, color: Colors.teal),
          title: Text(_courses[index]["name"]!),
          subtitle: Text("Instructor: ${_courses[index]["instructor"]!}"),
        );
      },
    );
  }

  // ✅ Profile Page
  Widget _profilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile image (make sure to add your image in assets/images/)
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage("assets/images/passport.jpg"),
          ),
          const SizedBox(height: 20),
          const Text("Herminia Eshun",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text("BSc Information Technology"),
          const Text("University of Energy and Natural Resources"),
          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              _showExitDialog();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }

  // ✅ Exit Dialog
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Exit Confirmation"),
        content: const Text("Are you sure you want to exit the app?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("No")),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).maybePop();
              },
              child: const Text("Yes")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(["Home", "Courses", "Profile"][_selectedIndex])),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}