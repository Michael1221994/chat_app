import 'package:flutter/material.dart';
import 'package:minimal_chat_app/pages/settings_page.dart';
import 'package:minimal_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import '../Services/Auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout () async{
    AuthService authService= AuthService();
    try{
      authService.signout();
    }catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;
    final colorScheme = Theme.of(context).colorScheme;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [

              //logo
          DrawerHeader
            (child: Center(child: 
              Icon(Icons.message, 
              color: isDarkMode ? Colors.white : Colors.black,
              size: 40,
              ),
            ),
          ),

          // home list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("H O M E", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
              leading: Icon(Icons.home,
              color: isDarkMode ? Colors.white : Colors.black,),
              onTap: () => Navigator.pop(context),
            ),
          ),

          //settings list tile
           Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("S E T T I N G S",style: TextStyle(color:isDarkMode ? Colors.white : Colors.black)),
              leading: Icon(Icons.settings,
              color: isDarkMode ? Colors.white : Colors.black,),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage(),)),
            ),
          ),

            ],
          ),
          //logout list tile

           Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: Text("L O G O U T", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
              leading: Icon(Icons.logout,
              color: isDarkMode ? Colors.white : Colors.black,),
              onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}