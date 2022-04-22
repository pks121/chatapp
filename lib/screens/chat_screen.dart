import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final messageTextController = TextEditingController();
// FieldValue._(_factory.serverTimestamp());

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;
  late User loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    // FirebaseUser loggedUser;
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    String messages = "";
    String? mail = "";
    bool isMe = false;
    return Scaffold(
      // backgroundColor: Colors.pink,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Chat UI"),
        actions: [
          IconButton(
            onPressed: () async {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream:
                store.collection('messages').orderBy('time_field').snapshots(),
            builder: (context, snapshots) {
              if (!snapshots.hasData) {
                return const Center(
                  child: Text(
                    'Data not available',
                  ),
                );
              }
              final messages = snapshots.data?.docs;
              List<MessageBubble> textWidgets = [];

              messages?.forEach((element) {
                final messageText = element['text'];
                final messageSender = element['sender'];
                final loggedUser = loggedInUser.email;

                final textWidget = MessageBubble(
                    messageSender: messageSender,
                    isMe: messageSender == loggedUser,
                    messageText: messageText);
                textWidgets.add(textWidget);
              });
              return Expanded(
                child: Container(
                  color: const Color(0xff719b10),
                  child: ListView(
                    children: textWidgets,
                  ),
                ),
              );
            },
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: TextField(
                    controller: messageTextController,
                    decoration:
                        const InputDecoration(hintText: 'Enter message here'),
                    onChanged: (value) {
                      messages = value;
                    }),
              ),
              MaterialButton(
                  // shape: CircleBorder(side: BorderSide.none),
                  child: const Text('Send'),
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      store.collection('messages').add({
                        'sender': loggedInUser.email,
                        'text': messages,
                        'time_field': FieldValue.serverTimestamp()
                      });
                      messageTextController.clear();
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.messageSender,
    required this.isMe,
    required this.messageText,
  });

  final messageSender;
  final isMe;
  final messageText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Material(
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18))
              : const BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18)),
          color: isMe ? const Color(0xff06534f) : const Color(0xff293229),
          elevation: 8,
          child: Container(
            // padding: EdgeInsets.all(2),
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$messageSender',
                  style: const TextStyle(
                    letterSpacing: 1,
                    decoration: TextDecoration.underline,
                    color: Color(0xffffffff),
                    fontSize: 6,
                  ),
                ),
                Text(
                  '$messageText',
                  style:
                      const TextStyle(fontSize: 22, color: Color(0xbe03fc3f)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
