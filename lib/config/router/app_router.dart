import 'package:go_router/go_router.dart';
import 'package:toktok/presentation/screens/discover/discover_screen.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    
    GoRoute(
      path: '/',
      name: DiscoverScreen.name,
      builder: (context, state) => const DiscoverScreen(),
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



  ]
);