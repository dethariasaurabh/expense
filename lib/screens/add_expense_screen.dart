import 'package:expense/services/speech_api.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final SpeechToText _speechToText = SpeechToText();
  String text = 'Press the button and start speaking';
  bool isListening = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  text,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: InkWell(
                  splashColor: null,
                  focusColor: null,
                  onTap: toggleRecording,
                  child: Container(
                    height: Dimens.height50,
                    width: Dimens.width50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.darkColor,
                    ),
                    child: Icon(
                      _speechToText.isNotListening
                          ? CupertinoIcons.mic_off
                          : CupertinoIcons.mic,
                      color: AppColors.whiteColor,
                      size: Dimens.icon24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
    onResult: (text) => setState(() => this.text = text),
    onListening: (isListening) {
      setState(() => this.isListening = isListening);

      if (!isListening) {
        Future.delayed(Duration(seconds: 1), () {
          // Utils.scanText(text);
        });
      }
    },
  );

}
