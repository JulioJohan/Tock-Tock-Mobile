// Este repositorio es inmutable
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toktok/infrastructure/datasources/post_datasource_imp.dart';
import 'package:toktok/infrastructure/repositories/post_repository_imp.dart';

final postRepositoryProvider = Provider((ref) {
  return PostsRepositoryImpl(PostDataSourceImpl());
});
