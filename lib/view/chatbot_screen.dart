// This code represents a chatbot screen that allows users to interact with a chatbot powered by Dialogflow.

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/marriage_procedure_menu.dart';
import 'package:wedding_planner/widgets/chat_bubble.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

   
  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {

  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  late final SpeechToText speechToText;
  late StreamSubscription _recorderStatus;
  late StreamSubscription<List<int>> _audioStreamSubscription;
  late DialogflowGrpcV2Beta1 dialogflow;

  @override
  void initState() {
    super.initState();
    initPlugin();
  }

  // This method initializes the speech recognition and sets up Dialogflow using a service account JSON file. 
  Future<void> initPlugin() async {

    speechToText = SpeechToText();

    final serviceAccount = ServiceAccount.fromString(
      await rootBundle.loadString(
        'assets/wedding-planner-5522c-f494d680f764.json',
      ),
    );

    dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);
    setState(() {});

    await speechToText.initialize(
      options: [SpeechToText.androidIntentLookup],
    );
  }

  void stopStream() async {
    await _audioStreamSubscription.cancel();
  }

  // This method is responsible for handling user messages and sending them to the chatbot.
  void handleSubmitted(text) async {
    _textController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      name: "You",
      type: true,
    );

    setState(() {
      _messages.insert(0, message);
    });

    DetectIntentResponse data = await dialogflow.detectIntent(text, 'en-US');

    String fulfillmentText = data.queryResult.fulfillmentText;
    if (fulfillmentText.isNotEmpty) {
      ChatMessage botMessage = ChatMessage(
        text: fulfillmentText,
        name: "Bot",
        type: false,
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    }
  }

  // This method is called when the speech recognition plugin detects speech and provides the recognition result.
  void _onSpeechResult(SpeechRecognitionResult result) async {
    String lastWords = result.recognizedWords;

    _textController.text = lastWords;
    _textController.selection = TextSelection.collapsed(
      offset: _textController.text.length,
    );

    setState(() {
    });
    await Future.delayed(const Duration(seconds: 5));
    _stopListening();
  }

  // This method is called when the user activates the speech recognition
  void handleStream() async {
    setState(() {
    });
    await speechToText.listen(
      onResult: _onSpeechResult,
    );
  }

  // This method stops the speech recognition.
  void _stopListening() async {
    await speechToText.stop();
  }

  // This method is overridden to clean up resources when the widget is disposed of.
  @override
  void dispose() {
    _recorderStatus.cancel();
    _audioStreamSubscription.cancel();
    speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
        "myWedding Bot",
        style: TextStyle(
          color: Colors.black,
          fontSize: 17
        ),
        ),
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 218, 218, 218),
            width: 1
          )
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const MarriageProcedureMenu()
            ));
          }
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (ctx, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: HexColor("#91777C")),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: handleSubmitted,
                    decoration: const InputDecoration.collapsed(
                        hintText: "Send a message"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: Icon(Icons.send, color: HexColor("#C0ABAF")),
                    onPressed: () => handleSubmitted(_textController.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}