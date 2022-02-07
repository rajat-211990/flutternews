import 'package:flutter/material.dart';
import 'package:flutternews/helper/data.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/models/category_model.dart';
import 'package:flutternews/views/article_view.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   bool _loading = true;
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];

 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews()async{
    var newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState((){
      _loading = false;
    });




  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row( mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("flutter"),
              Text("News", style:TextStyle(
                color:Colors.white)
                )
            ],
          ),
       elevation: 2.0,
      ),
      body: _loading ?  Center(
        child: Container(
           child : CircularProgressIndicator(),
        ),
      ):
         SingleChildScrollView(
           child: Container(
                 child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 45),
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap:true,
                  scrollDirection : Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                )
              ),
              Container(
                 padding: EdgeInsets.only(top:16),
                 child: ListView.builder(
                   itemCount: articles.length,
                   shrinkWrap:true,
                   physics:ClampingScrollPhysics(),
                   itemBuilder: (context, index) {
                     return BlogTile(
                       imageUrl: articles[index].urlToImage,
                       title: articles[index].title,
                       desc: articles[index].description,
                       url:articles[index].url,
                     );
                   }
         
                 )
              )
            ]
                 ),
                 ),
         ),
      
    );
  }
}

class CategoryTile extends StatelessWidget {
  
  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
    

  @override
  Widget build(BuildContext context) {
    return Container(
      margin : EdgeInsets.only(right: 16),
      child: Stack(
        children: <Widget>[
          
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(imageUrl, width: 120, height : 60)),
            Container(
              alignment: Alignment.center,
              width: 120, height : 60,
              color: Colors.black26,
              child: Text(categoryName, style: TextStyle(
                color: Colors.white
              ),),
            )
        ],
      )
      
    );
  }
}



class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
   BlogTile({required this.imageUrl, required this.title,required this.desc,required this.url});


   // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(
              blogUrl : url,
        )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom:16),
        child: Column(
          children: <Widget>[
            Image.network(imageUrl),
            Text(title, style:TextStyle(
              fontSize:24,
            )),
            Text(desc),
          ]
        )
        
      ),
    );
  }
}