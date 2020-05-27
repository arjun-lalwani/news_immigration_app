import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_immigration/components/NewsCardComponent.dart';
import 'package:news_immigration/constants.dart';
import 'package:news_immigration/models/News.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final List<Article> articles;

  HomePage({this.articles});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showPopularArticles = true;
  List<Article> currArticles;

  void initState() {
    super.initState();
    currArticles = widget.articles;
  }

  _launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sortArticlesBy(bool popularityOption) {
    if (popularityOption) {
      // update state to show popular articles first
      setState(() {
        currArticles = widget.articles.toList(); // make a copy
        _showPopularArticles = true;
      });
    } else if (!popularityOption) {
      // sort by date
      currArticles = widget.articles.toList(); // make a copy
      currArticles.sort((a, b) {
        return a.compareTo(b);
      });

      // update state to show latest articles first (descending order)
      setState(() {
        currArticles = currArticles.reversed.toList();
        _showPopularArticles = false;
      });
    }
  }

  String _getDescriptionStr() {
    return (_showPopularArticles == true)
        ? "most popular articles\nfrom last week"
        : "articles sorted by date\nfrom last week";
  }

  String _getDateStr(int index) {
    Article article = currArticles[index];
    var dateTime = DateTime.parse(article.publishedAt);
    // Convert into "Day, Month, Date" format
    return DateFormat.MMMMEEEEd().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    var descriptionText = _getDescriptionStr();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Immigration News'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${currArticles.length} $descriptionText',
                    style: kNumberOfArticlesStyle,
                  ),
                  Switch(
                    onChanged: (value) => _sortArticlesBy(value),
                    value: _showPopularArticles,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currArticles.length,
                itemBuilder: (context, index) {
                  String dateStr = _getDateStr(index);
                  return GestureDetector(
                    onTap: () {
                      _launchUrl(currArticles[index].url);
                    },
                    child: NewsCardComponent(
                        article: currArticles[index], dateStr: dateStr),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
