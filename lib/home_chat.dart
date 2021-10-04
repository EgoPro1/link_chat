/*import 'package:acceso_camara/patients_chat.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomeChat extends StatefulWidget {
  HomeChat({Key? key}) : super(key: key);

  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  final _usernameController = TextEditingController();
  late String _usernameError = '';
  bool _loading = false;
  Future<void> _onGoPressed() async {
    final username = _usernameController.text;
    if (username.isNotEmpty) {
      final client = StreamChat.of(context).client;
      setState(() {
        _loading = true;
      });
      await client.connectUser(
          User(
              id: username,
              extraData: {'image': AssetImage('assets/avatar_azul')}),
          username);
      setState(() {
        _loading = false;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => PatiensChat()));
    } else {
      setState(() {
        _usernameError = 'Username is not valid';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Stream Chat')),
        body: Center(
          child: _loading
              ? CircularProgressIndicator()
              : Card(
                  elevation: 11,
                  margin: const EdgeInsets.all(15.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Welcome'),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                              hintText: 'Username', errorText: _usernameError),
                        ),
                        ElevatedButton(
                            onPressed: _onGoPressed, child: Text('Go'))
                      ],
                    ),
                  ),
                ),
        ));
  }
}*/
