
import 'package:database_flutter/provider/note_provider.dart';
import 'package:database_flutter/data/local/DB_helper.dart';
import 'package:database_flutter/provider/theme_provider.dart';
import 'package:database_flutter/utils/app_theme.dart';
import 'package:database_flutter/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DbProvider(
            dbHelper: DbHelper.getInstance,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeProvider.themeMode,

        home: const HomeScreen(),
    );
  }
}



