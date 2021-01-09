import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

final Firestore _firestore=Firestore.instance;
FirebaseUser loggedInUser;
class ChatScreen extends StatefulWidget {
  static const String id='/chat_screen';


  @override
  _ChatScreenState createState() => _ChatScreenState();
}
 
class _ChatScreenState extends State<ChatScreen> {
    final FirebaseAuth _auth=  FirebaseAuth.instance;
    final textController=TextEditingController();



    String message;
//Replaced by message stream deprecated
//    void getMessages()async{
//      var messages=await _firestore.collection("messages").getDocuments();
//      for(var message in messages.documents){
//        print(message.data);
//    }
//
//    }
//    void getMessagesStream() async {
//
//     await for(var snapshot in _firestore.collection("messages").snapshots()){
//       for(var message in snapshot.documents){
//         print(message.data);
//       }
//     }
//    }

    @override
  void initState() {
    
    super.initState();
    getCurrentUser();

  }
  void getCurrentUser() async{
      try{
     final user= await _auth.currentUser();
     if(user!=null){
       loggedInUser=user;
       print(loggedInUser.email);

     }}catch(e){print(e);}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);


              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),


            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                       message=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      textController.clear();
                     _firestore.collection("messages").add({
                       "sender":loggedInUser.email,
                           "text":message



                     });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text,this.sender,this.isMe});
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0),

      child: Column(
        crossAxisAlignment:isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children:<Widget>[
          Text("$sender",style: TextStyle(color: Colors.black54,fontSize: 12,
          ),
          ),

          Material(
          color:isMe?Colors.lightBlueAccent: Colors.deepPurple,
          elevation: 8.0,
          borderRadius:isMe? BorderRadius.only(topLeft:Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)): BorderRadius.only(topRight:Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
          child: Padding(
    padding:EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Container(
              child: Text("$text",style: TextStyle(color: Colors.white),),
            ),
          ),
        )],

      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("messages").snapshots(),
      builder:( (context,snapshot){
        if (!snapshot.hasData){
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.blueAccent,));
        }
        List<MessageBubble> messageBubbles=[];
        final messages= snapshot.data.documents.reversed;

        for(var message in messages){
          String text= message.data["text"];
          String sender=message.data["sender"];
          //var currentUser=loggedInUser.email
          final messageBubble=MessageBubble(text:text,sender:sender,isMe:loggedInUser.email==sender );
          messageBubbles.add(messageBubble);



        }
        return Expanded(
          child: ListView(
            reverse: true,
            children:messageBubbles ,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20)

          ),
        );


      }
      ),


    );
  }
}
