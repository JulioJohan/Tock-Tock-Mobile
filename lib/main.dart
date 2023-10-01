import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktok/config/router/app_router.dart';
import 'package:toktok/config/theme/app_theme.dart';
import 'package:toktok/infrastructure/datasources/post_datasource_imp.dart';
import 'package:toktok/infrastructure/repositories/post_repository_imp.dart';
import 'package:toktok/presentation/providers/posts/discover_provider.dart';
import 'package:toktok/presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // utilizando arquitectura limpia
    // final postDataSourceImpl =
    //     PostsRepositoryImpl(PostDataSourceImpl());

    // return MultiProvider(
      // providers: [
        // .. Operador de casacada, cargara las videos cuando se llame esta clase
        // ChangeNotifierProvider(
            // Lazy es que se crea muy rapidamente
            // lazy: false,
            // create: (_) => DiscoverProvider(postRepository: postDataSourceImpl)
              // ..loadNextPage()
          // )
      // ],
      return MaterialApp.router(
          routerConfig:appRouter ,
          title: 'TockTock',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().getTheme(),
          // home: const DiscoverScreen()),
    );
  }
}
