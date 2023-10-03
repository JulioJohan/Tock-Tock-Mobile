import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:toktok/presentation/providers/initial_loading_provider.dart';
import 'package:toktok/presentation/providers/posts/discover_provider.dart';
import 'package:toktok/presentation/providers/posts/post_provider.dart';
import 'package:toktok/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:toktok/presentation/widgets/shared/full_screen_loader.dart';
import 'package:toktok/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});
  static const name = 'home';

  @override
  Widget build(BuildContext context) {
    // Verificar si hay nuevo videos
    // final discoverProvider = context.watch<DiscoverProvider>();

    return const Scaffold(
      // body: discoverProvider.initialLoading
      //     ? const Center(
      //         child: CircularProgressIndicator(
      //         strokeWidth: 2,
      //       ))
      //     : VideoScrollableView(videos: discoverProvider.videos),
      body: _DiscoverScreen(),
      // bottomNavigationBar: CustomBottomNavigation(currentIndex: null,),
    );
  }
}

class _DiscoverScreen extends ConsumerStatefulWidget {
  const _DiscoverScreen();

  @override
  _DiscoverScreenViewState createState() => _DiscoverScreenViewState();
}

class _DiscoverScreenViewState extends ConsumerState<_DiscoverScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingPostsProviderPage.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    final postPage = ref.watch(nowPlayingPostsProviderPage);
    print(postPage);
    if (initialLoading) return const FullScreenLoader();

    return Scaffold(
        body: initialLoading
            ? const Center(
                child: CircularProgressIndicator(
                strokeWidth: 2,
                
              ))
            : VideoScrollableView(
              videos: postPage,
              loadNextPage: ()=> ref.read(nowPlayingPostsProviderPage.notifier).loadNextPage(),
              ));
  }
}
