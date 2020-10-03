import 'package:top_stories/core/core.dart';

class ArticleImageSize extends Enum {
  static const extraLarge = ArticleImageSize._internal("superJumbo");
  static const small = ArticleImageSize._internal("standardThumbnail");
  static const large = ArticleImageSize._internal("thumbLarge");
  static const medium = ArticleImageSize._internal("mediumThreeByTwo210");
  static const normal = ArticleImageSize._internal("Normal");

  static const List<ArticleImageSize> values = [
    extraLarge,
    large,
    medium,
    normal,
    small,
  ];

  ///Pass value to be retrieved to constructor
  const ArticleImageSize._internal(String value) : super.internal(value);

  ///Use to get the value accordin to the key passed
  factory ArticleImageSize(String raw) => values.firstWhere(
        (val) => val.value == raw,
        orElse: () => null,
      );
}
