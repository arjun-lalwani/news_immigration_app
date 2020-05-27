import 'package:http/http.dart' as http;
import 'dart:convert';

const API_KEY = 'apiKey=36aa39ad236740fbbdb4464c46502c4d';
const url =
    'http://newsapi.org/v2/everything?q=immigration+trump+(Optional+Practical+Training OR h1b)&sortBy=popularity';

class News {
  static String constructUrl() {
    DateTime toDate = DateTime.now();
    DateTime fromDate = toDate.subtract(Duration(days: 7));
    String fromDateRange =
        'from=${fromDate.year}-${fromDate.month}-${fromDate.day}';
    String toDateRange = '&to=${toDate.year}-${toDate.month}-${toDate.day}';
    String datesRange = '$fromDateRange$toDateRange';
    return '$url&$datesRange&$API_KEY';
  }

  static Future<List<Article>> fetchImmigrationNewsArticles() async {
    String finalUrl = constructUrl();
    final response = await http.get(finalUrl);

    if (response.statusCode == 200) {
      var resp = json.decode(response.body);
      var articles = resp['articles'];

      // cast MapIterableList<dyanmic, dynamic> into List<Article>
      return List<Article>.from(
        articles.map((article) {
          return Article.fromJson(article);
        }).toList(),
      );
    } else {
      throw Exception('failed to load data');
    }
  }
}

class Article {
  String source;
  String title;
  String description;
  String url;
  String publishedAt;

  Article({
    this.source,
    this.title,
    this.description,
    this.url,
    this.publishedAt,
  });

  /* Read more about using factory constructors here: https://stackoverflow.com/questions/52299304/dart-advantage-of-a-factory-constructor-identifier
  - Factory Constructor can return an instance of the current class or subclass;
  - Factory Constructor can return a cached instance instead of a new one
  - F.C: to prepare calculated values to forward them as parameters to a normal constructor so that final fields
    can be initialized with them. This can be especially useful for handling error cases in json input
  - F.C acts similarly to a static function
  - main point of factory constructor is to hide the fact that it's a static function as an implementation detail; to provide a consistent way of instantiating objects*/
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      description: json['description'],
      source: json['source']['name'],
      title: json['title'],
      url: json['url'],
      publishedAt: json['publishedAt'],
    );
  }

  int compareTo(Article other) {
    // returns -1 if this < other
    // returns 0 if this == other
    // returns 1 if this > other
    return this.publishedAt.compareTo(other.publishedAt);
  }
}
