import 'dart:collection';
import 'package:async/async.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:articles/src/hnbloc.dart';
import 'package:flutter/material.dart';
import 'package:articles/src/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
void main() {
  final hnbloc=new HackerNewsBloc();
  runApp(MyApp(bloc: hnbloc));
}

class MyApp extends StatelessWidget {
  final HackerNewsBloc bloc;
  MyApp({
    Key key, this.bloc}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hacker News App',bloc: bloc,),
      debugShowCheckedModeBanner: false,

    );
  }
}

class MyHomePage extends StatefulWidget {
  final HackerNewsBloc bloc;
  MyHomePage({Key key,
  this.bloc
  , this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: LoadingInfo(widget.bloc.isLoading),
        actions: [
          IconButton (
            icon: Icon(Icons.search),
            onPressed: () async{
            final Article result= await showSearch(
                context: context,
                  delegate: ArticleSearch(widget.bloc.articles)
              );
           /* if(result!=null && await canLaunch(result.url))
              {
                launch(result.url,forceWebView: true);
              }

            */
              if(result!=null)
                {
                  Navigator.push(context, MaterialPageRoute(
                   builder: (context)=>HackerNewsWebPage(result.url),
                  ));
                }
            },
          )
        ],
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
        stream: widget.bloc.articles,
        initialData: UnmodifiableListView<Article>([]),
        builder: (context,snapshot)=>ListView(
          children: snapshot.data.map(_buildItem).toList(),
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex, items: [
        BottomNavigationBarItem(
          title: Text("Top Stories"),
          icon: Icon(Icons.api_sharp)
        ),BottomNavigationBarItem(
            title: Text("New Stories"),
            icon: Icon(Icons.map)
        ),BottomNavigationBarItem(
            title: Text("Best Stories"),
            icon: Icon(Icons.stream)
        )
      ],
        onTap: (index){
        if(index==0) {
          widget.bloc.storiesTypes.add(StoriesType.topStories);
        }
       else if(index==1){
          widget.bloc.storiesTypes.add(StoriesType.newStories);
        }
          else{
          widget.bloc.storiesTypes.add(StoriesType.bestStories);
          }
       setState(() {
         _currentIndex=index;
       });

        },
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget _buildItem(Article e){
        return Padding(
          key:Key(e.title),
          padding: const EdgeInsets.all(16.0),


          child: new ExpansionTile(
            title: new Text(e.title ??'[null]', style: new TextStyle(fontSize: 24.0),),
            children :<Widget> [Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new Text("${e.descendants} Comments"),
                 new IconButton(onPressed:() async{

                     Navigator.push(context, MaterialPageRoute(
                       builder: (context)=>HackerNewsWebPage(e.url),
                     ));

                },icon: new Icon(Icons.launch),color: Colors.greenAccent ,)
              ],
            )],
    //       onTap: () async {
    //        if(await canLaunch("http://${e.domain}"))
    //          launch("http://${e.domain}");
     //       },
          ),
        );
  }
  
}
class LoadingInfo extends StatelessWidget {
  Stream<bool> isLoading;
  LoadingInfo(this.isLoading);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: isLoading,
        builder: (BuildContext context,AsyncSnapshot<bool> snapshot)
    {
       if(snapshot.hasData && snapshot.data) return CircularProgressIndicator(backgroundColor: Colors.amberAccent,);
      else
        return Container();

    });
  }
}
class ArticleSearch extends SearchDelegate<Article>{
  final Stream<UnmodifiableListView<Article>> articles;
  ArticleSearch(this.articles);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [ IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        query="";
      },
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return StreamBuilder<UnmodifiableListView<Article>>(
      stream: articles,
    builder: (context,snapshot)
    { if(!snapshot.hasData)
      return Text("No data");
    if(query.isEmpty)
      return ListView(

        children: snapshot.data.map<Widget>((a)=>ListTile(
          title: Text(a.title),
          leading: Icon(Icons.book),
        )).toList(),
      );
    final result=snapshot.data.where((element) => element.title.toLowerCase().contains(query));

    return ListView(

        children: result.map<Widget>((a)=>ListTile(
          title: Text(a.title),
          leading: Icon(Icons.book),
          onTap: () async{
            if(await canLaunch(a.url))
              launch(a.url,forceWebView: true);
            close(context,a);
          },
        )).toList(),
    );
      });



  }
  
}
class HackerNewsWebPage extends StatelessWidget {
  HackerNewsWebPage(this.url);
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Webpage"),
      ),
      body: WebView(
        initialUrl:url

      ),
    );
  }
}


