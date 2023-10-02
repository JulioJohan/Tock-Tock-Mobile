import 'package:go_router/go_router.dart';
import 'package:toktok/presentation/screens/discover/discover_screen.dart';
import 'package:toktok/presentation/widgets/login/login.dart';


final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    
    GoRoute(
      path: '/',
      name: LoginPage.name,
      builder: (context, state) => LoginPage(),
      routes: [
         GoRoute(
          path: '/home',
          name: DiscoverScreen.name,
          builder: (context, state) => const DiscoverScreen()          
        ),
      ]
    ),

// routes: {
      //   '/': (context) => LoginPage(),
      //   '/home': (context) =>  DiscoverScreen(),
      // },


  ]
);