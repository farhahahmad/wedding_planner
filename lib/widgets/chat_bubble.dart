import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    this.text,
    this.name,
    this.type,
  });

  final String? text;
  final String? name;
  final bool? type;

  List<Widget> otherMessage(context, w) {
    return <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(
              20,
            ),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(0),
          ),
          color:HexColor("#F0F0F0")),
        constraints: BoxConstraints(maxWidth: w * 2 / 3),
        child:
          Text(text ?? ""))
    ];
  }

  List<Widget> myMessage(context, w) {
    return <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(
                20,
              ),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(20),
            ),
            color:HexColor("#F3E7E7")),
        constraints: BoxConstraints(maxWidth: w * 2 / 3),
        child:
            Text(text ?? ""))
    ];
  }

  @override
  Widget build(BuildContext context) {

    var w = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: type ?? false ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: type ?? false ? myMessage(context, w) : otherMessage(context, w),
      ),
    );
  }
}