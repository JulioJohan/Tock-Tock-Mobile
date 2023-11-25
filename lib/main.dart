import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';
import 'package:toktok/config/router/app_router.dart';
import 'package:toktok/config/theme/app_theme.dart';
import 'package:toktok/presentation/screens/discover/discover_screen.dart';
import 'package:toktok/presentation/widgets/screens/login/login.dart';
import 'package:toktok/presentation/widgets/screens/registro/registro.dart';
// import 'package:toktok/infrastructure/datasources/post_datasource_imp.dart';
// import 'package:toktok/infrastructure/repositories/post_repository_imp.dart';
// import 'package:toktok/presentation/providers/posts/discover_provider.dart';
// import 'package:toktok/presentation/screens/discover/discover_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDTh6VngDRxis071fNhrXv9_uufeSmikf0",
        authDomain: "tock-tock-f41b9.firebaseapp.com",
        projectId: "tock-tock-f41b9",
        storageBucket: "tock-tock-f41b9.appspot.com",
        messagingSenderId: "882987567219",
        appId: "1:882987567219:web:b3ac20Pbfb0fbe996ce4206"),
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') {
      rethrow;
    }
  }

  runApp(const ProviderScope(child: MyApp()));
}


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
    //return MaterialApp.router(
    //  routerConfig: appRouter,
    //  title: 'TockTock',
    //  debugShowCheckedModeBanner: false,
    //  theme: AppTheme().getTheme(),
      // home: const DiscoverScreen()),
    //);

    return MaterialApp.router(      
      title: 'tock-tock',
      routerConfig:appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      // routes: {
      //   '/': (context) => LoginPage(),
      //   '/home': (context) =>  DiscoverScreen(),
      // },
    );
  
  }
}
