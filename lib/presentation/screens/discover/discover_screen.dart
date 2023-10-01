import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktok/presentation/providers/posts/discover_provider.dart';
import 'package:toktok/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});
  static const name = 'Inicio';

  @override
  Widget build(BuildContext context) {
    // Verificar si hay nuevo videos
    final discoverProvider = context.watch<DiscoverProvider>();

    return Scaffold(
        body: discoverProvider.initialLoading
            ? const Center(
                child: CircularProgressIndicator(
                strokeWidth: 2,
              ))
            : VideoScrollableView(videos: discoverProvider.videos));
  }
}
