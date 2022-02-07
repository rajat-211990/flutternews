import 'dart:convert';

import 'package:flutternews/models/article_model.dart';
import 'package:http/http.dart' as http;
class News{

 List<ArticleModel> news = <ArticleModel>[];

  Future<void>getNews() async{

   String url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e49b6fa43a5a4344b37948f94afff19d ";
   var response = await http.get(Uri.parse(url));

   var jsonData = jsonDecode(response.body);
   print(jsonData);

   if(jsonData['status'] == "ok"){

     jsonData["articles"].forEach((element) {
       if(element["urlToImage"] != null && element["description"] !=null && element['title'] != null){

        ArticleModel articleModel = new ArticleModel();

              articleModel.title = element["title"];
              // articleModel.author = element["author"];
              articleModel.description = element["description"];
              // articleModel.url = element["url"];
              // articleModel.content = element["content"];
              articleModel.urlToImage = element["urlToImage"];
              articleModel.url = element["url"];
            // author: element['author'],
            // description: element['description'],
            // url: element['url'],
            // urlToImage: element['urlToImage'],
            // publishedAt: element['publishedAt'],
            // content: element['content'],
         

         news.add(articleModel);

       };



     });

   }
   

 }

}