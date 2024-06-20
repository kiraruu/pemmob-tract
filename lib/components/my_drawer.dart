import 'package:flutter/material.dart';
import 'package:tract/components/my_drawer_tile.dart';
import 'package:tract/services/auth/auth_services.dart';

import '../page/settings_page.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;

  const MyDrawer({super.key, required this.onProfileTap});

  void logout(BuildContext context) {
    final authService = AuthServices();
    authService.signOut();

    // Navigate to the login page or perform other logout actions if needed
    // Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // logo
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Icon(
              Icons.home_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // home list
          MyDrawerTile(
            text: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),

          MyDrawerTile(
              text: "S E T T I N G S",
              icon: Icons.settings,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              }),

          MyDrawerTile(
            text: "P R O F I L E",
            icon: Icons.person_2_outlined,
            onTap: onProfileTap,
          ),

          const Spacer(),

          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              Navigator.pop(context); // Close the drawer
              logout(context); // Perform logout
            },
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
