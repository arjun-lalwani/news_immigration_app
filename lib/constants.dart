import 'package:flutter/material.dart';

const kNewsCardStyle = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Color(0xFFD6D6D6),
      spreadRadius: 1,
      blurRadius: 3,
      offset: Offset(0, 6),
    ),
  ],
);

const kNewsTitleStyle = TextStyle(
  fontSize: 18,
  letterSpacing: 0.6,
  fontWeight: FontWeight.w600,
);

const kNumberOfArticlesStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
);
