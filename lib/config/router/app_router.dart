import 'package:go_router/go_router.dart';
import 'package:toktok/presentation/screens/discover/discover_screen.dart';
import 'package:toktok/presentation/widgets/screens/login/login.dart';
import 'package:toktok/presentation/widgets/screens/registro/registro.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    
    GoRoute(
      path: '/',
      name: LoginPage.name,
      builder: (context, state) => LoginPage(),
      routes: [
         GoRoute(
          path: '/home/:page',
          name: DiscoverScreen.name,
          builder: (context, state) => const DiscoverScreen()          
        ),
         GoRoute(
          path: 'registro',
          name: RegistroPage.name,
          builder: (context, state) =>  RegistroPage()          
        ),
      ]
    ),

// routes: {
      //   '/': (context) => LoginPage(),
      //   '/home': (context) =>  DiscoverScreen(),
      // },


  ]
);