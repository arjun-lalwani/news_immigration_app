import 'package:flutter/material.dart';
import 'package:news_immigration/models/News.dart';

import '../constants.dart';

class NewsCardComponent extends StatelessWidget {
  NewsCardComponent({
    @required this.article,
    @required this.dateStr,
  });

  final Article article;
  final String dateStr;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 15, bottom: 10, left: 12, right: 12),
      decoration: kNewsCardStyle,
      child: Column(
        children: [
          Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: kNewsTitleStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            article.description,
            maxLines: 2,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _createSourceInfoDetails(article.source),
              _createSourceInfoDetails(dateStr),
            ],
          ),
        ],
      ),
    );
  }

  Text _createSourceInfoDetails(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
