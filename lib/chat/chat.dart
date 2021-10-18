import 'dart:io';

import 'package:acceso_camara/models/history_item_response.dart';
import 'package:acceso_camara/models/message.dart';
import 'package:acceso_camara/models/message_recieved.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/services/message_service.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  // final User user;
  final bool premium;
  DiagnosisData diagnosisInfo;
  String expertName;
  String resultid;
  ChatScreen({
    required this.diagnosisInfo,
    required this.premium,
    required this.resultid,
    required this.expertName,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState(
      diagnosisInfo: diagnosisInfo,
      premium: premium,
      resultid: resultid,
      expertName: expertName);
}

class _ChatScreenState extends State<ChatScreen> {
  final bool premium;
  String resultid;
  String expertName;
  DiagnosisData diagnosisInfo;
  _ChatScreenState(
      {required this.diagnosisInfo,
      required this.premium,
      required this.resultid,
      required this.expertName});
  final myController = TextEditingController();
  MessageService msgService = new MessageService();
  final _prefs = new PreferenciasUsuario();
  var messages = <MessageR>[];
  String? contenido;
  _chatBubble(MessageR message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _prefs.getrol == 'patient'
                    ? Theme.of(context).primaryColor
                    : Color(0xFF13AB46),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: _prefs.getrol == 'patient'
                        ? Theme.of(context).primaryColor
                        : Color(0xFF13AB46),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message.message.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    /*Text(
                message.time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),*/
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      /*child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(message.sender.imageUrl),
                ),*/
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message.message.toString(),
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      /* child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(message.sender.imageUrl),
                ),*/
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    /*Text(
                message.time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),*/
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: myController,
              onChanged: (value) => setState(() => contenido = value),
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              await msgService.createMessage(
                  myController.text, diagnosisInfo, resultid);
              sleep(Duration(milliseconds: 10));
            },
          ),
        ],
      ),
    );
  }

  @override
  initState() {
    Future.delayed(Duration.zero, () async {
      //here is the async code, you can execute any async code here
      var res = await msgService.getMessagesList(diagnosisInfo, resultid);
      messages = res.data!;
    });

    myController.addListener(_printLatestValue);
    /*for(int i=0;i<messages.length;++i){
      messages[i].message=res.data![i].message;
      messages[i].idSender=res.data![i].idSender;
      messages[i].rol=res.data![i].rol;
    }*/
    super.initState();
    //messages = getMessages();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  void Actualizar() async {
    var res = await msgService.getMessagesList(diagnosisInfo, resultid);
    messages = res.data!;
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String? prevUserId = '';
    Actualizar();
    final _prefs = new PreferenciasUsuario();
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor:
            _prefs.getrol == 'expert' ? Color(0xFF1E4DE8) : Color(0xFF13AB46),
        brightness: Brightness.dark,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: expertName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  )),
              /*TextSpan(text: '\n'),
              true ?
              TextSpan(
                text: 'Online',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )
                  :
              TextSpan(
                text: 'Offline',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )*/
            ],
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final MessageR message = messages[index];
                if (message != null && message.idSender != null) {
                  var aux = message.idSender.toString();
                  var auxmessage = message;
                  final bool isMe = message.rol == _prefs.getrol ? true : false;
                  final bool isSameUser = prevUserId == aux;
                  prevUserId = aux;
                  return _chatBubble(auxmessage, isMe, isSameUser);
                } else
                  return _chatBubble(message, true, true);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
