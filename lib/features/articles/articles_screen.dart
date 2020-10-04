import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:top_stories/components/title_widget.dart';
import 'package:top_stories/features/articles/article_card.dart';
import 'package:top_stories/components/custom_scaffold.dart';
import 'package:top_stories/core/core.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  ArticlesController _controller;
  DefaultCacheManager _cniManager;

  @override
  void initState() {
    super.initState();
    _cniManager = DefaultCacheManager();
    _controller = ArticlesController();
    _init();
  }

  ///Init function
  Future<void> _init({bool isRefresh = false}) {
    if (isRefresh) {
      CacheManager().invalidateCacheAndRestart();
      _cniManager.emptyCache();
    }
    return _controller.getArticles(isRefresh: isRefresh);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _controller.combinedStream,
        builder: (context, snapshot) {
          return CustomScaffold(
            onRetry: _init,
            pageState: _controller.pageState,
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () => _init(isRefresh: true),
                child: CustomScrollView(
                  slivers: [
                    _buildTitle(),
                    _buildArticlesList(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///Build the list of articles
  SliverList _buildArticlesList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) =>
            ArticleCard(_controller.articles?.results[index]),
        childCount: _controller.articles?.results?.length,
      ),
    );
  }

  ///Build the title at the top of the articles page
  SliverToBoxAdapter _buildTitle() {
    return SliverToBoxAdapter(
        child: TitleWidget(
      title: Strings.topArticles,
    ));
  }
}
