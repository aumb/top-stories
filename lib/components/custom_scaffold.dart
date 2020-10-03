import 'package:flutter/material.dart';
import 'package:top_stories/core/core.dart';

class CustomScaffold extends StatelessWidget {
  final PageState pageState;
  final Widget body;
  final Function onRetry;

  const CustomScaffold({
    Key key,
    this.pageState,
    this.body,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyAccordingToState(context),
    );
  }

  ///Checks on the current state and builds the body based on the state.
  Widget _buildBodyAccordingToState(BuildContext context) {
    Widget pageBody = SizedBox.shrink();
    switch (pageState) {
      case PageState.loading:
        pageBody = _LoadingWidget();
        break;
      case PageState.loaded:
        pageBody = body;
        break;
      case PageState.error:
        pageBody = _ErrorWidget(
          onRetry: onRetry,
        );
        break;
      case PageState.noData:
        pageBody = _NoDataWidget(
          onRetry: onRetry,
        );
        break;
    }
    return pageBody;
  }
}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final Function onRetry;

  const _ErrorWidget({
    Key key,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Strings.genericError),
          SizedBox(height: 8),
          RaisedButton(
            child: Text(Strings.retry),
            onPressed: onRetry,
          )
        ],
      ),
    );
  }
}

class _NoDataWidget extends StatelessWidget {
  final Function onRetry;

  const _NoDataWidget({
    Key key,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Strings.noData),
          SizedBox(height: 8),
          RaisedButton(
            child: Text(Strings.retry),
            onPressed: onRetry,
          )
        ],
      ),
    );
  }
}
