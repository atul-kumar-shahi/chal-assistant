import 'package:flutter/material.dart';
import 'package:allen/pallet.dart';
import 'package:allen/chat_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Column(
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
                        image:
                            AssetImage('assets/images/virtualAssistant.png'))),
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
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Good Morning,what task can i do for you?',
                  style: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontSize: 20,
                      color: Pallete.mainFontColor)),
            ),
          ),
          Container(
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
          const Column(
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Pallete.firstSuggestionBoxColor,
        child: const Icon(Icons.mic),
      ),
    );
  }
}
