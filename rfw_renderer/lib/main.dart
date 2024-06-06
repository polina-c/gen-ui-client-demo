import 'package:flutter/material.dart';

import 'rfw.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GenUI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        print('route: ${settings.name}');
        final frameId = settings.name?.split('=').last ?? null;
        print('frameId: $frameId');
        return MaterialPageRoute(builder: (context) => GenUI(frameId: frameId));
      },
    );
  }
}

class GenUI extends StatelessWidget {
  const GenUI({super.key, required this.frameId});

  final String? frameId;

  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: RfwContent(
          frameId: frameId,
        ),
      ),
    );
  }
}
