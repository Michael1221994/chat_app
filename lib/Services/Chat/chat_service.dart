import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimal_chat_app/models/mesage.dart';

class ChatService{

  // get instances of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream(){
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        // go through each individual user
        final user =doc.data();

        return user;
      }).toList();
    } ,);
  }


  //send message
  Future<void> sendMessage( String receiverID, String message) async{
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();


    //create a new message
    Message newMessage = Message(
      senderID: currentUserID, 
      senderEmail: currentUserEmail, 
      receiverID: receiverID, 
      message: message, 
      timestamp: timestamp);


    //construct a chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort the IDs (this ensure the chat roomID is the same for any 2 people)
    String chatRoomID = ids.join('-');



    //add the new message to the database
    await _firestore
    .collection("chat_rooms")
    .doc(chatRoomID)
    .collection("messages")
    .add(newMessage.toMap());
  }


  //get messages

  Stream<QuerySnapshot> getMessages(String userID, otheruserID){
    //construct a chatroom ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [userID, otheruserID];
    ids.sort(); //sort the IDs (this ensure the chat roomID is the same for any 2 people)
    String chatRoomID = ids.join('-');

    return _firestore
    .collection("chat_rooms")
    .doc(chatRoomID)
    .collection("messages")
    .orderBy("timestamp", descending: false)
    .snapshots();
  }
}
