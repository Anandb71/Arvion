import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set minimum window size for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // We'll use window_manager for this, but for now set via native
    // The app shell will enforce minimum constraints
  }

  runApp(const ProviderScope(child: ArvionApp()));
}
