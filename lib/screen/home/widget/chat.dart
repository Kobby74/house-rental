import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  final String chatId;
  const ChatScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic> messages = [];
  TextEditingController _messageController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    var url = Uri.parse('https://rentapp-api.drevap.com/api/chats/${widget.chatId}');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ',
    });

    if (response.statusCode == 200) {
      setState(() {
        messages = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load messages'),
      ));
    }
  }

  Future<void> sendMessage(String message) async {
    var url = Uri.parse('https://rentapp-api.drevap.com/api/chats/${widget.chatId}/send');
    var body = jsonEncode({'message': message});

    var response = await http.post(url, headers: {
      'Authorization': 'Bearer token',
      'Content-Type': 'application/json',
    }, body: body);

    if (response.statusCode == 200) {
      setState(() {
        messages.add(jsonDecode(response.body));
      });
      _messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to send message'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ListTile(
                        title: Align(
                          alignment: message['isOwner']
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: message['isOwner']
                                  ? Colors.blueAccent
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              message['content'],
                              style: TextStyle(
                                  color: message['isOwner']
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        subtitle: Align(
                          alignment: message['isOwner']
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            message['timestamp'],
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      sendMessage(_messageController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
