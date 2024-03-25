import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIServices{
  final  List<Map<String,String>>contents=[];
  Future<String> isArtPromptAPI(String prompt)async{
    contents.add({
      "parts": prompt,
    });
    try{
      final res= await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyB3Ler_o8yvWi4VEp2HPJ0zDSDHX8BfP_E'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [{"text":prompt}],
              // "content": "Do you want to generate an AI picture,Image,Art or anything similar $prompt.give answer in yes or no only"
            },
          ]
        },)
      );
      print(res.body);
      if(res.statusCode==200){
        var result=jsonDecode(res.body)['candidates'][0]['content']['parts'][0]['text'];
        return result;
      }
      return 'Internal error occurred';
    }catch(e){
      return e.toString();
    }
  }
}