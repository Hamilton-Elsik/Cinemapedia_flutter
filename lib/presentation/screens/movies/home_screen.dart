import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/presentation/views/views.dart';
import 'package:flutter_cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//*Este Mixin es necesario para mantener el estado en la PageView
class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.pageIndex);
  }

  final viewRoutes = const <Widget>[
    HomeView(),
    PopularView(), //<------- categorias de view
    FavoritesView(),
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
      );
    }

    return Scaffold(
      body: PageView(
        //* Esto evitarà que rebote
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        // index. pageIndex
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
