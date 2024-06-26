import 'package:allen/openai_services.dart';
import 'package:flutter/material.dart';
import 'package:allen/pallet.dart';
import 'package:allen/chat_box.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';
  final OpenAIServices openAIServices = OpenAIServices();
  String? generatedContent;
  final flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content)async{
     await flutterTts.speak(content);
  }
  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Pallete.whiteColor,
        centerTitle: true,
        title: const Text(
          'Allen',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //virtual assistant picture
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/virtualAssistant.png'))),
                )
              ],
            ),

            //chat bubble
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Pallete.borderColor),
                  borderRadius:
                      BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                    generatedContent == null
                        ? 'Good Morning,what task can i do for you?'
                        : generatedContent.toString(),
                    style: TextStyle(
                        fontFamily: 'Cera Pro',
                        fontSize: 20,
                        color: Pallete.mainFontColor)),
              ),
            ),
            Visibility(
              visible: generatedContent == null,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 5, left: 22),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Here are a few commands',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cera Pro',
                    color: Pallete.mainFontColor,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: generatedContent == null,
              child: const Column(
                children: [
                  ChatBox(
                    color: Pallete.firstSuggestionBoxColor,
                    headerText: 'ChatGPT',
                    bodyText:
                        'A smarter way to stay organized and informed with ChatGPT',
                  ),
                  ChatBox(
                    color: Pallete.secondSuggestionBoxColor,
                    headerText: 'Dall-E',
                    bodyText:
                        'Get inspired and stay creative with your personal assistant powered by Dall-E',
                  ),
                  ChatBox(
                    color: Pallete.thirdSuggestionBoxColor,
                    headerText: 'Smart Voice Assistant',
                    bodyText:
                        'Get the best of both a voice assistant powered by Dall-E and ChatGPT',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            generatedContent = await openAIServices.isArtPromptAPI(lastWords);
            await systemSpeak(generatedContent.toString());
            setState(() {});
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        backgroundColor: Pallete.firstSuggestionBoxColor,
        child: const Icon(Icons.mic),
      ),
    );
  }
}
