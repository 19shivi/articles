import 'dart:convert' as json;
import 'Serializer.dart';
import 'package:meta/meta.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  static Serializer<Article> get serializer => _$articleSerializer;
  @nullable
  int get id;
  @nullable
  bool get deleted;
  @nullable
  String get type;
  @nullable
  String get by;
  @nullable
  int get time;
  @nullable
  String  get text;
  @nullable
  bool get dead;
  @nullable
  int get parent;
  @nullable
  int get poll	;
  @nullable
  BuiltList<int> get kids;
  @nullable
  String get url	;
  @nullable
  int get score	;
  @nullable
  String get title;
  @nullable
  BuiltList<int>get parts;
  @nullable
  int get descendants	;

  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}

List<int> parseTopStories(String jsonString)
{
  final parsed=json.jsonDecode(jsonString);
  final listOfIds=List<int>.from(parsed);
  return listOfIds;
}
Article parsedArticle(String jsonString)
{
  final parsed=json.jsonDecode(jsonString);
  Article article=serializers.deserializeWith(Article.serializer, parsed);
  return article;
}


/*
// Example output made at 2019-09-21 09:39(UTC)
// You can use this if you don't have node.js :)

class Article {
  final String text;
  final String domain;
  final String by;
  final String age;
  final int score;
  final int commentsCount;

  const Article({
    this.text,
    this.domain,
    this.by,
    this.age,
    this.score,
    this.commentsCount
  });
}

final articles = [
  new Article(
    text: "Bioreactor Captures as Much Carbon as an Acre of Trees",
    domain: "futurism.com",
    by: "vinnyglennon",
    age: "22 minutes ago",
    score: 11,
    commentsCount: 4,
  ),
  new Article(
    text: "What ORMs have taught me: just learn SQL (2014)",
    domain: "wozniak.ca",
    by: "BerislavLopac",
    age: "13 hours ago",
    score: 609,
    commentsCount: 492,
  ),
  new Article(
    text: "Do It Yurtself",
    domain: "imgur.com",
    by: "NaOH",
    age: "9 hours ago",
    score: 343,
    commentsCount: 86,
  ),
  new Article(
    text: "The Essential Tool for Hong Kong Protesters? An Umbrella",
    domain: "www.bloomberg.com",
    by: "baylearn",
    age: "23 minutes ago",
    score: 4,
    commentsCount: 0,
  ),
  new Article(
    text: "Async.h – asynchronous, stackless subroutines in C",
    domain: "higherlogics.blogspot.com",
    by: "signa11",
    age: "5 hours ago",
    score: 50,
    commentsCount: 9,
  ),
  new Article(
    text: "Do Stocks Outperform Treasury Bills?",
    domain: "papers.ssrn.com",
    by: "ZeljkoS",
    age: "25 minutes ago",
    score: 3,
    commentsCount: 1,
  ),
  new Article(
    text: "Substantial Rise in Catalytic Converter Thefts",
    domain: "www.bbc.co.uk",
    by: "Kaibeezy",
    age: "an hour ago",
    score: 5,
    commentsCount: 4,
  ),
  new Article(
    text: "NSA Said to Have Used Heartbleed Bug for at Least Two Years (2014)",
    domain: "www.bloomberg.com",
    by: "ColanR",
    age: "15 hours ago",
    score: 235,
    commentsCount: 110,
  ),
  new Article(
    text: "An interactive cheatsheet tool for the command-line",
    domain: "github.com",
    by: "dnsfr",
    age: "11 hours ago",
    score: 181,
    commentsCount: 23,
  ),
  new Article(
    text: "The C4 model for visualising software architecture",
    domain: "c4model.com",
    by: "redact207",
    age: "9 hours ago",
    score: 89,
    commentsCount: 30,
  ),
  new Article(
    text: "A Taxonomy of Moats",
    domain: "reactionwheel.net",
    by: "pagade",
    age: "2 hours ago",
    score: 6,
    commentsCount: 0,
  ),
  new Article(
    text: "Books Won't Die",
    domain: "www.theparisreview.org",
    by: "animalcule",
    age: "12 hours ago",
    score: 56,
    commentsCount: 62,
  ),
  new Article(
    text: "Too Much Dark Money in Almonds",
    domain: "slatestarcodex.com",
    by: "gbear605",
    age: "2 days ago",
    score: 207,
    commentsCount: 127,
  ),
  new Article(
    text: "TSMC: 3nm EUV Development Progress Going Well",
    domain: "www.anandtech.com",
    by: "hourislate",
    age: "11 hours ago",
    score: 109,
    commentsCount: 33,
  ),
  new Article(
    text: "The longer it has taken, the longer it will take (2015)",
    domain: "www.johndcook.com",
    by: "haltingproblem",
    age: "13 hours ago",
    score: 131,
    commentsCount: 35,
  ),
  new Article(
    text: "Charter of the Forest",
    domain: "en.wikipedia.org",
    by: "benbreen",
    age: "3 hours ago",
    score: 14,
    commentsCount: 2,
  ),
  new Article(
    text: "ColorBox by Lyft Design",
    domain: "www.colorbox.io",
    by: "Brajeshwar",
    age: "17 hours ago",
    score: 784,
    commentsCount: 78,
  ),
  new Article(
    text: "Why Some People Become Lifelong Readers",
    domain: "www.theatlantic.com",
    by: "jseliger",
    age: "2 days ago",
    score: 83,
    commentsCount: 42,
  ),
  new Article(
    text: "Aerial Saw Is Boon to Line Trimming",
    domain: "www.tdworld.com",
    by: "akehrer",
    age: "a day ago",
    score: 17,
    commentsCount: 5,
  ),
  new Article(
    text: "Climate capitalists have serious money in climate-friendly investments",
    domain: "www.economist.com",
    by: "ryan_j_naughton",
    age: "10 hours ago",
    score: 60,
    commentsCount: 40,
  ),
  new Article(
    text: "A Simple Structure Unites All Human Languages",
    domain: "nautil.us",
    by: "dnetesn",
    age: "13 hours ago",
    score: 123,
    commentsCount: 32,
  ),
  new Article(
    text: "The brain may actively forget during REM sleep",
    domain: "www.nih.gov",
    by: "bookofjoe",
    age: "12 hours ago",
    score: 78,
    commentsCount: 25,
  ),
  new Article(
    text: "Wagner: totalizing master of endless melodies",
    domain: "www.the-tls.co.uk",
    by: "unquote",
    age: "12 hours ago",
    score: 18,
    commentsCount: 0,
  ),
  new Article(
    text: "Breaking Down the Chrome Web Store",
    domain: "extensionmonitor.com",
    by: "flysonic10",
    age: "16 hours ago",
    score: 149,
    commentsCount: 57,
  ),
  new Article(
    text: "Mysterious Magnetic Pulses Discovered on Mars by InSight",
    domain: "www.nationalgeographic.com",
    by: "adizzledog",
    age: "10 hours ago",
    score: 54,
    commentsCount: 10,
  ),
  new Article(
    text: "iPhone 11 has the fastest single-core performance of any Apple computer",
    domain: "twitter.com",
    by: "tambourine_man",
    age: "6 hours ago",
    score: 76,
    commentsCount: 52,
  ),
  new Article(
    text: "Georgia's entire voter file potentially compromised after voting machine theft",
    domain: "www.wsbtv.com",
    by: "anigbrowl",
    age: "7 hours ago",
    score: 86,
    commentsCount: 43,
  ),
  new Article(
    text: "Anthropologists and Novelists (2018)",
    domain: "www.publicbooks.org",
    by: "tintinnabula",
    age: "2 days ago",
    score: 5,
    commentsCount: 0,
  ),
  new Article(
    text: "Overrated: Ludwig Wittgenstein",
    domain: "standpointmag.co.uk",
    by: "ordiblah",
    age: "12 hours ago",
    score: 31,
    commentsCount: 34,
  ),
  new Article(
    text: "Angst and the Empty Set (2014)",
    domain: "nautil.us",
    by: "dnetesn",
    age: "a day ago",
    score: 3,
    commentsCount: 0,
  ),
];*/
