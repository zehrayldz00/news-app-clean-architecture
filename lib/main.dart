import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/pages/saved_articles/saved_articles.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

import 'config/theme/app_themes.dart';
import 'features/daily_news/domain/entities/article.dart';
import 'features/daily_news/presentation/pages/article_detail/article_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) =>
          sl()..add(const GetArticles()),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const DailyNews(),
          '/ArticleDetails': (context) {
            final article = ModalRoute.of(context)!.settings.arguments as ArticleEntity;
            return ArticleDetailsView(article: article);
          },
          '/SavedArticles': (context) {
            //final article = ModalRoute.of(context)!.settings.arguments as ArticleEntity;
            return SavedArticles();
          },
        },
        debugShowCheckedModeBanner: false,
        theme: theme(),
      ),
    );
  }
}
