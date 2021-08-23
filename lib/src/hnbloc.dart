import 'dart:async';
import 'dart:collection';
import 'package:articles/src/article.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
enum StoriesType{
  topStories,
  newStories,
  bestStories
}
class HackerNewsBloc{
  Stream<bool> get isLoading=> _isLoadingSubject.stream;
  final _isLoadingSubject=BehaviorSubject<bool>();

  final _articlesSubject= BehaviorSubject<UnmodifiableListView<Article>>();
  var _articles=<Article>[];
  Sink<StoriesType> get storiesTypes=> _storiesTypeController.sink;
  final _storiesTypeController=StreamController<StoriesType>();
 HashMap<int,Article> _cachedArticle;

  HackerNewsBloc(){
    _cachedArticle=HashMap<int,Article>();
           _getArticleUpdate("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty");
    _storiesTypeController.stream.listen((event) {
      if(event==StoriesType.newStories)
        {
          _getArticleUpdate("https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty");
        }
      else if(event==StoriesType.topStories)
        _getArticleUpdate("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty");
      else
        _getArticleUpdate("https://hacker-news.firebaseio.com/v0/beststories.json?print=pretty");

    });

  }
  void _getArticleUpdate(String url) async
  {   _isLoadingSubject.add(true);
    List<int> id= <int>[];
  final resStory=await http.get(url);
  if(resStory.statusCode==200)
  {
    id = parseTopStories(resStory.body);
  }else {
    throw HackerNewApisError("Error occured while fetching Articles");
  }
   await  _updateArticles(id).then((_){
      _articlesSubject.add(UnmodifiableListView(_articles));
      _isLoadingSubject.add(false);
    });

  }

  Stream<UnmodifiableListView<Article>> get articles=> _articlesSubject.stream;
  Future<Null> _updateArticles(List<int> ids) async
  {
    final futureArticles=ids.map((e) => _getArticle(e));
    final articles=await Future.wait(futureArticles);
    _articles=articles;

  }




  Future<Article> _getArticle(int id) async
  {  if(!_cachedArticle.containsKey(id)) {
    final storyurl = "https://hacker-news.firebaseio.com/v0/item/${id}.json?print=pretty";
    final resStory = await http.get(storyurl);
    if (resStory.statusCode == 200) {
      _cachedArticle[id]= parsedArticle(resStory.body);
    }
    else {
      throw HackerNewApisError("Article ${id} not found");
    }
  }
  return _cachedArticle[id];
  }
}
class HackerNewApisError extends Error{
  final String message;
  HackerNewApisError(this.message);
}