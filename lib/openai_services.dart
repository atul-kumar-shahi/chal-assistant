import 'dart:convert';

import 'package:allen/secret.dart';
import 'package:http/http.dart' as http;

class OpenAIServices{
  Future<String> isArtPromptAPI(String prompt)async{
    try{
      final res= await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':'Bearer $openAIAPIKey'
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content": "Do you want to generate an AI picture,Image,Art or anything similar $prompt.give answer in yes or no only"
            },
          ]
        },)
      );
      print(res.body);
      if(res.statusCode==200){
        print('hurray');
      }
      return 'AI';
    }catch(e){
      return e.toString();
    }
  }
  Future<String> chatGPTAPI(String prompt)async{
    return 'ChatGPT';
  }
  Future<String> dallEApi(String prompt)async{
    return 'Dall-E';
  }
}