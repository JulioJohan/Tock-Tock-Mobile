import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktok/config/theme/app_theme.dart';
import 'package:toktok/presentation/providers/discover_provider.dart';
import 'package:toktok/presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // .. Operador de casacada, cargara las videos cuando se llame esta clase        
        ChangeNotifierProvider(
          // Lazy es que se crea muy rapidamente
          lazy: false,
          create: (_) => DiscoverProvider()..loadNextPage())      
      ],
      child: MaterialApp(
          title: 'TokTok',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().getTheme(),
          home: const DiscoverScreen()),
    );
  }
}
