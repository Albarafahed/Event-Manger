import 'package:event_manager/widgets/lib/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // ===== Dark Mode =====
            ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeController.themeMode,
              builder: (context, mode, _) {
                return SwitchListTile(
                  title: const Text("Dark Mode"),
                  value: mode == ThemeMode.dark,
                  onChanged: (value) {
                    ThemeController.themeMode.value = value
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  },
                );
              },
            ),
            const Divider(),

            // ===== Primary Color =====
            ListTile(
              title: const Text("Primary Color"),
              trailing: CircleAvatar(
                backgroundColor: ThemeController.primaryColor.value,
              ),
              onTap: () async {
                Color pickedColor = ThemeController.primaryColor.value;
                await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Pick Primary Color"),
                    content: BlockPicker(
                      pickerColor: pickedColor,
                      onColorChanged: (color) => pickedColor = color,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          ThemeController.primaryColor.value = pickedColor;
                          Navigator.pop(context);
                        },
                        child: const Text("Select"),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(),

            // ===== Font Size =====
            ValueListenableBuilder<double>(
              valueListenable: ThemeController.fontSize,
              builder: (context, size, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Font Size"),
                    Slider(
                      min: 12,
                      max: 30,
                      divisions: 9,
                      label: size.toInt().toString(),
                      value: size,
                      onChanged: (value) {
                        ThemeController.fontSize.value = value;
                      },
                    ),
                  ],
                );
              },
            ),
            const Divider(),

            // ===== Notifications =====
            ValueListenableBuilder<bool>(
              valueListenable: ThemeController.notificationsEnabled,
              builder: (context, enabled, _) {
                return SwitchListTile(
                  title: const Text("Enable Notifications"),
                  value: enabled,
                  onChanged: (value) {
                    ThemeController.notificationsEnabled.value = value;
                  },
                );
              },
            ),
          ],
        ),
      ),
       bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}
