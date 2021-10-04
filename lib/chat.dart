/*import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'home_chat.dart';

class ChatAppStream extends StatefulWidget {
  ChatAppStream({Key? key}) : super(key: key);

  @override
  _ChatAppStreamState createState() => _ChatAppStreamState();
}

class _ChatAppStreamState extends State<ChatAppStream> {
  late final StreamChatClient _client;

  @override
  void initState() {
    _client = StreamChatClient('3f7xufq65a5y', logLevel: Level.INFO);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      builder: (context, child) => StreamChat(child: child, client: _client),
      home: HomeChat(),
    );
  }
}*/
