import 'package:go_router/go_router.dart';
import 'package:toktok/presentation/widgets/screens/home/home_screen.dart';
import 'package:toktok/presentation/widgets/screens/login/login.dart';
import 'package:toktok/presentation/widgets/screens/registro/registro.dart';
import 'package:toktok/presentation/widgets/screens/resetPassword/resetPassword.dart';


final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse( state.params['page'] ?? '0' );

        return HomeScreen( pageIndex: pageIndex );
      },
      // routes: [
      //    GoRoute(
      //     path: 'movie/:id',
      //     name: MovieScreen.name,
      //     builder: (context, state) {
      //       final movieId = state.params['id'] ?? 'no-id';

      //       return MovieScreen( movieId: movieId );
      //     },
      //   ),
      // ]
    ),
    GoRoute(path: '/login',
    name: LoginPage.name,
    builder: (context, state) => LoginPage(),
    
    ),

     GoRoute(path: '/registro',
    name: RegistroPage.name,
    builder: (context, state) => RegistroPage(),
    
    ),

     GoRoute(path: '/resetPassword',
    name: ResetPasswordPage.name,
    builder: (context, state) => ResetPasswordPage(),
    
    ),

    GoRoute(
      path: '/',
      redirect: ( _ , __ ) => '/home/0',
    ),

  ]
);