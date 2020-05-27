import 'package:flutter/material.dart';
import 'package:news_immigration/models/News.dart';
import 'package:news_immigration/screens/HomePage.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  List<Article> articles;

  @override
  void initState() {
    super.initState();
    loadArticles();
  }

  loadArticles() async {
    var result = await News.fetchImmigrationNewsArticles();
    // This works for small apps with just one or two screens
    // On complex apps, this kind of navigation will result in
    // code duplication and be cumbersome
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          articles: result,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
