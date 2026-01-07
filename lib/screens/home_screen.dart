// لتخزين الصورة كـ Bytes
import 'package:event_manager/core/user_session.dart';
import 'package:event_manager/widgets/lib/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';
import 'create_event_screen.dart';
import 'events_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User currentUser;
  List<Map<String, dynamic>> events = [];

  final ImagePicker _picker = ImagePicker();
  double _sliderValue = 50; // قيمة Slider

  @override
  void initState() {
    super.initState();
    currentUser = UserSession.currentUser!;
  }

  // ===== Image Picker =====
  Future<void> _pickProfileImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes(); // قراءة الصورة كـ Bytes
      setState(() {
        UserSession.profileImageBytes = bytes;
      });
    }
  }

  // ===== Add Event =====
  void _addEvent(Map<String, dynamic> event) {
    setState(() {
      events.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), centerTitle: true),

      // ================= Drawer =================
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(currentUser.email),
              accountEmail: Text(currentUser.email),
              currentAccountPicture: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  // ===== صورة البروفايل أو أيقونة افتراضية =====
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: UserSession.profileImageBytes != null
                        ? MemoryImage(UserSession.profileImageBytes!)
                        : null,
                    child: UserSession.profileImageBytes == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),

                  // ===== زرار + =====
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _pickProfileImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            _drawerItem(
              icon: Icons.add,
              title: "Create Event",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateEventScreen(onAddEvent: _addEvent),
                  ),
                );
              },
            ),

            _drawerItem(
              icon: Icons.list,
              title: "Events List",
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EventsListScreen(events: events),
                  ),
                );
              },
            ),

            _drawerItem(
              icon: Icons.chat,
              title: "Chat",
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/chat');
              },
            ),

            const Divider(),

            _drawerItem(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {
                UserSession.logout();
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),

      // ================= Body =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 70),
            const SizedBox(height: 10),

            Text(
              "Welcome ${currentUser.email}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 10),
            Text("Events count: ${events.length}"),

            const SizedBox(height: 30),

            // ================= Slider =================
            Text(
              "Priority Level: ${_sliderValue.toInt()}",
              style: const TextStyle(fontSize: 18),
            ),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: _sliderValue.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(leading: Icon(icon), title: Text(title), onTap: onTap),
    );
  }
}
