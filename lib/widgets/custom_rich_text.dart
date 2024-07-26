import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.title,
    required this.content,
  });
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
          text: TextSpan(
              text: '$title: ',
              style: const TextStyle(color: Colors.grey),
              children: [
            TextSpan(text: content, style: const TextStyle(color: Colors.black))
          ])),
    );
  }
}
