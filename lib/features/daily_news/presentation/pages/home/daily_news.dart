import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/widgets/article_tile.dart';

import '../../../domain/entities/article.dart';
import '../../bloc/article/remote/remote_article_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar(){
    return AppBar(
      leading: Builder(
          builder: (context) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () =>_onBookMarkButtonTapped(context),
            child: const Icon(Icons.bookmark, color: Colors.black,),
          )
      ),
      title: Text(
        'Daily News',
        style: TextStyle(
          color: Colors.black
        )
      ),
    );
  }

  _buildBody(){
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
        builder: (_, state){
          if(state is RemoteArticlesLoading){
            return const Center(child: CupertinoActivityIndicator(),);
          }
          if(state is RemoteArticlesError){
            return const Center(child: Icon(Icons.refresh),);
          }
          if(state is RemoteArticlesDone){
            return ListView.builder(
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: () => _onArticlePressed(context, state.articles![index]),
                    child: ArticleWidget(
                      article: state.articles![index],
                    ),
                  );
                },
              itemCount: state.articles!.length,
            );
          }
          return const SizedBox();
        }
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article){
    Navigator.pushNamed(context, '/ArticleDetails', arguments:article);
  }

  void _onBookMarkButtonTapped(BuildContext context){
    Navigator.pushNamed(context, '/SavedArticles');

  }
}
