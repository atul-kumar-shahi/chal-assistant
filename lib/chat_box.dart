import 'package:flutter/material.dart';
import 'package:allen/pallet.dart';
import 'package:speech_to_text/speech_to_text.dart';


class ChatBox extends StatelessWidget {
  const ChatBox({
    super.key,
    required this.color,
    required this.headerText, required this.bodyText,
  });

  final Color color;
  final String headerText;
  final String bodyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15).copyWith(
            left: 15
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cera Pro',
                  color: Pallete.blackColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(bodyText,style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.blackColor
              ),),
            )
          ],
        ),
      ),
    );
  }
}