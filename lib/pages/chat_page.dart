import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/Services/Auth/auth_service.dart';
import 'package:minimal_chat_app/Services/Chat/chat_service.dart';
import 'package:minimal_chat_app/components/chat_bubble.dart';
import 'package:minimal_chat_app/components/my_textfield.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  final String receiverID;
   ChatPage({
    super.key,
    required this.recieverEmail,
    required this.receiverID,
    });

    //text controller
    final TextEditingController _messageController = TextEditingController();

    // chat & auth services
    final AuthService _authService = AuthService();
    final ChatService _chatService = ChatService();

    void sendMessage() async{
      // if there is something inside the textfield
      if(_messageController.text.isNotEmpty){
        //send message
        await _chatService.sendMessage(receiverID, _messageController.text);

        //clear text controller
        _messageController.clear();
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(recieverEmail),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        ),

        body: Column(
          children: [
            //display all messages
            Expanded(
              child: _buildMessageList(),
              ),


            // user input
            _buildUserInput(),

          ],
        ),
    );
  }
   Widget _buildMessageList(){
    String senderID= _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID)
    , builder: (context, snapshot){
      //errors
      if(snapshot.hasError){
        return const Text("Error");
      }

      //loading
       if(snapshot.connectionState==ConnectionState.waiting){
        return const CircularProgressIndicator();
      }

      //return List view
      return ListView(
        children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
      );
    }
    );
   }

   Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;


    // align message to the right if sender is the current user otherwise left side
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        
        alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
          ],
        )),
    );
   }

   Widget _buildUserInput () {
    return Padding(
      padding:  const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
               //textfield should take up most of the space
        Expanded(
          child: MyTextfield(hintText: "Type a message", obscureText: false, controller: _messageController),
        ),
      
        //send button
        Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle
          ),
          margin: EdgeInsets.only(right: 20),
          child: IconButton(onPressed: sendMessage, icon: Icon(Icons.send, color: Colors.white,),),)
        ]
      ),
    );
   }
}