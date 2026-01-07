// import 'package:flutter/material.dart';
// import '../models/user.dart';

// class AppDrawers extends StatelessWidget {
//   User currentUser;
//   AppDrawers(this.currentUser);
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           // DrawerHeader(
//           //   decoration: BoxDecoration(color: Colors.blue),
//           //   child: Text(
//           //     'Event Manager',
//           //     style: TextStyle(color: Colors.white, fontSize: 24),
//           //   ),
//           // ),
//           UserAccountsDrawerHeader(
//             accountName: Text(currentUser.email),
//             accountEmail: Text(currentUser.email),
//             currentAccountPicture: const CircleAvatar(
//               child: Icon(Icons.person),
//             ),
//           ),
//          // _drawerItem(context, Icons.home, 'Home', '/home'),
//           _drawerItem(context, Icons.event, 'Create Event', '/create-event'),
//           _drawerItem(context, Icons.list, 'Events List', '/events-list'),
//           _drawerItem(context, Icons.chat, 'Chat', '/chat'),
//           _drawerItem(context, Icons.settings, 'Settings', '/settings'),
//         ],
//       ),
//     );
//   }

//   Widget _drawerItem(
//     BuildContext context,
//     IconData icon,
//     String title,
//     String route,
//   ) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       onTap: () {
//         Navigator.pop(context); // close drawer
//         Navigator.pushReplacementNamed(context, route); // navigate to page
//       },
//     );
//   }
// }
