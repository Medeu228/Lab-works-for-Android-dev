import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/vault_screen.dart';
import 'services/storage_service.dart';

Future<void> main() async {
  // 1. The Flutter engine must be ready BEFORE we touch any plugin:
  //    SharedPreferences talks to native Android/iOS code through a
  //    platform channel, and channels need the binding.
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Read the disk BEFORE the first frame is drawn.
  final prefs = await SharedPreferences.getInstance();
  final storage = StorageService(prefs);

  // 3. The very first frame already knows the saved theme,
  //    so a dark-mode user never sees a white flash.
  runApp(VaultApp(storage: storage, initialDarkMode: storage.loadDarkMode()));
}

class VaultApp extends StatefulWidget {
  const VaultApp({
    super.key,
    required this.storage,
    required this.initialDarkMode,
  });

  final StorageService storage;
  final bool initialDarkMode;

  @override
  State<VaultApp> createState() => _VaultAppState();
}

class _VaultAppState extends State<VaultApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.initialDarkMode; // pre-loaded in main()
  }

  /// Called by the Dark Mode switch: update the UI, then save to disk.
  Future<void> _setDarkMode(bool value) async {
    setState(() => _isDarkMode = value);
    await widget.storage.saveDarkMode(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.dark,
      ),
      // MaterialApp animates between theme and darkTheme -> smooth switch
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: VaultScreen(
        storage: widget.storage,
        isDarkMode: _isDarkMode,
        onDarkModeChanged: _setDarkMode,
      ),
    );
  }
}
