import 'package:flutter/material.dart';
import 'package:toktok/presentation/screens/discover/discover_screen.dart';
import 'package:toktok/presentation/widgets/screens/video/editar_publicacion.dart';
import 'package:toktok/presentation/widgets/screens/video/save_video_screen.dart';
import 'package:toktok/presentation/widgets/shared/custom_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {

  static const name = 'home-screen';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin  {

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewRoutes =  const <Widget>[
    DiscoverScreen(),
    SaveVideo(),
    EditPublicacion()
  ];

  @override
  Widget build(BuildContext context) {
   super.build(context);

    if ( pageController.hasClients ) {
      pageController.animateToPage(
        widget.pageIndex, 
        curve: Curves.easeInOut, 
        duration: const Duration( milliseconds: 250),
      );
    }

    return Scaffold(
      body: PageView(
        //* Esto evitará que rebote 
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        // index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation( 
        currentIndex: widget.pageIndex,
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}