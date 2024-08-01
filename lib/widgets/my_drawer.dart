import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Center(
          child: CupertinoSwitch(
            value: Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (value) =>
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
          ),
        ),
      );
  }
}