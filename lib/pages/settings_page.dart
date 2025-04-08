import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Padding(
        padding:  EdgeInsets.only(left: 90.0),
        child: Text("Settings"),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.grey,
      elevation: 0,
      ),

      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16)
        ),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
          children: [
            //dark mode
            const Text("Dark Mode"),
        
        
            //switch toggle
            /*Switch(
                value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                activeColor: Theme.of(context).colorScheme.primary,  // Custom colors
                activeTrackColor: Colors.grey[300],
              ),*/

            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, 
              onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(), 
                
              )
          ],
          ),
      ),
    );
  }
}