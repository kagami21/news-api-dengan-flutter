import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/common/style.dart';
import 'package:newsapp/data/api/api_service.dart';
import 'package:newsapp/data/model/article.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/ui/widget/card_article.dart';
import 'package:newsapp/ui/widget/platform_widget.dart';
import 'package:provider/provider.dart';

class ArticleListPage extends StatelessWidget {
  Widget _buildList() {
    return Consumer<NewsProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return Center(
          child: CircularProgressIndicator(
            color: secondaryColor,
          ),
        );
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
            itemCount: state.result.articles.length,
            itemBuilder: (context, index) {
              var article = state.result.articles[index];
              return CardArticles(
                article: article,
              );
            });
      } else if (state.state == ResultState.NoData) {
        return Center(
          child: Text(state.message),
        );
      } else if (state.state == ResultState.Error) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return Center(
          child: Text(''),
        );
      }
    });
  }

  // Widget _buildList(BuildContext context) {
  //   return FutureBuilder(
  //     future: _article,
  //     builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
  //       var state = snapshot.connectionState;
  //       if (state != ConnectionState.done) {
  //         return Center(child: CircularProgressIndicator());
  //       } else {
  //         if (snapshot.hasData) {
  //           return ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: snapshot.data?.articles.length,
  //             itemBuilder: (context, index) {
  //               var article = snapshot.data?.articles[index];
  //               return CardArticles(article: article!);
  //             },
  //           );
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text(snapshot.error.toString()));
  //         } else {
  //           return Text('');
  //         }
  //       }
  //     },
  //   );
  // }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
