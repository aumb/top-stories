import 'package:flutter/material.dart';
import 'package:top_stories/core/core.dart';

class SectionAndDateWidget extends StatelessWidget {
  final Article article;

  const SectionAndDateWidget({this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            article.section?.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Theme.of(context).accentColor),
          ),
          Text(
            getStrDate(article.publishedDate, pattern: 'MMMM yy hh:mm a'),
            style: TextStyle(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
