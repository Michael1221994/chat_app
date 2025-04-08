import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/Services/Auth/auth_service.dart';
import 'package:minimal_chat_app/Services/Auth/login_or_register.dart';
import 'package:minimal_chat_app/Services/Chat/chat_service.dart';
import 'package:minimal_chat_app/components/my_drawer.dart';
import 'package:minimal_chat_app/components/user_tile.dart';
import 'package:minimal_chat_app/pages/chat_page.dart';


class HomePage extends StatelessWidget {
   HomePage({super.key});

final ChatService chatService = ChatService();
final AuthService authService = AuthService();  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Padding(
          padding:  EdgeInsets.only(left: 100.0),
          child:  Text("Home"),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,

      ),
      drawer: const MyDrawer(),
      body: builduserList(),
    );
  }

//build a list of users except for the current logged in user
  Widget builduserList() {
    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (context, snapshot) {

          //check for errors
          if(snapshot.hasError){
            return Text("Error !" + snapshot.error.toString());
          }

          //loading..
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
            }


          //return list view

          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context) ).toList(),
          );
        }
  
    );
  }


//build Individual list tile for user

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if(userData["email"] != authService.getCurrentUser()!.email){
      return UserTile(
      text: userData["email"],
      onTap: (){
        //tapped on a user -> go to chat page
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(recieverEmail: userData["email"], receiverID: userData["uid"],),));
      },
    );

    }
    else{
      return Container();
    }

  }
}