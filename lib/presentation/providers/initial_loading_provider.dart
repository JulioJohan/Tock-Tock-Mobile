import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toktok/presentation/providers/posts/post_provider.dart';


final initialLoadingProvider = Provider<bool>((ref) {

  final step1 = ref.watch( nowPlayingPostsProviderPage ).isEmpty;

  if( step1 ) return true;

  return false; // terminamos de cargar
});