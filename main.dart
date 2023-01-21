import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce website',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController pageController;
  final ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  onTap: () {},
                  selected: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  selectedTileColor: Colors.black54,
                  title: Text(
                    "Welcome To My Website",
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "Discount only 15%",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  trailing: PopUpMen(
                    menuList: const [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.person,
                          ),
                          title: Text("My Profile"),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.cart,
                          ),
                          title: Text("Add cart"),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: Text("Home"),
                      ),
                      PopupMenuItem(
                        child: Text("Shop"),
                      ),
                      PopupMenuItem(
                        child: Text("About us"),
                      ),
                      PopupMenuItem(
                        child: Text("Product",
                        ),

                      ),
                      PopupMenuItem(
                        child: Text("Single Product"),
                      ),
                      PopupMenuItem(
                        child: Text("Contact"),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                          ),
                          title: Text("LOG OUT"),
                        ),
                      ),
                    ],
                    icon: CircleAvatar(
                      backgroundImage: const NetworkImage(
                        'https://scontent.fpnh7-1.fna.fbcdn.net/v/t39.30808-1/324105695_1213846689211580_6456318034586193939_n.jpg?stp=dst-jpg_s480x480&_nc_cat=111&ccb=1-7&_nc_sid=f67be1&_nc_eui2=AeGjm5XPOuOnXOkzS25KGhyakoZ7a-JkwWaShntr4mTBZtgC7Az-xVtNz6uh9le83-2VGgHPrywIZAQus_PlDs2k&_nc_ohc=qdfvjU3r6h4AX9Qu95B&_nc_ht=scontent.fpnh7-1.fna&oh=00_AfDstuDUCfVfTqkF6g8bHir9XJ45NZDLbAp_21ni3Y2mcA&oe=63CFE29D',
                      ),
                      child: Container(

                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 260,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    pageNo = index;
                    setState(() {});
                  },
                  itemBuilder: (_, index) {
                    return AnimatedBuilder(
                      animation: pageController,
                      builder: (ctx, child) {
                        return child!;
                      },
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                              Text("Add to cart ${index + 1} "),
                            ),
                          );
                        },
                        onPanDown: (d) {
                          carasouelTmer?.cancel();
                          carasouelTmer = null;
                        },
                        onPanCancel: () {
                          carasouelTmer = getTimer();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 8, left: 8, top: 14.0, bottom: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius:BorderRadius.circular(24.0),
                                child: Image.network("https://i.pinimg.com/564x/cc/bb/a9/ccbba96efb2f18d251865b00e917e4b9.jpg",
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) => GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.circle,
                            size: 12.0,
                            color: pageNo == index
                                ? Colors.indigoAccent
                                : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 5.0,
                  ),

                ],
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: GridB(),
              ),

            ],
          ),
        ),
      ),
      floatingActionButtonLocation: showBtmAppBr
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(
          milliseconds: 800,
        ),
        curve: Curves.easeInOutSine,
        height: showBtmAppBr ? 70 : 0,
        child: BottomAppBar(
          notchMargin: 8.0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.home_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.cart,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.bell,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ScrollController>('_scrollController', _scrollController));
  }
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}

class FabExt extends StatelessWidget {
  const FabExt({
    Key? key,
    required this.showFabTitle,
  }) : super(key: key);

  final bool showFabTitle;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: AnimatedContainer(
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(CupertinoIcons.cart),
            SizedBox(width: showFabTitle ? 12.0 : 0),
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              child: showFabTitle ? const Text("Go to cart") : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

class GridB extends StatefulWidget {
  const GridB({Key? key}) : super(key: key);

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/736x/8e/b6/25/8eb6251259e8ab8593b681e5e92a13dc.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/736x/e8/c5/14/e8c5144dfd1fc9528095612677736db1.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/564x/2d/f9/2c/2df92c0293c050f448a03be3d09f90fa.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/564x/39/0a/fa/390afaded89b2390809afc2827e4bea3.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/564x/e3/75/b9/e375b995b7ef7a4cb810cec3afd34825.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/564x/60/5c/7d/605c7d0f89ae0406e401324efa6116a0.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/736x/26/79/62/267962158f450af6bb635a7a7d6f34ef.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/564x/8e/b6/25/8eb6251259e8ab8593b681e5e92a13dc.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/564x/04/b5/96/04b5965d9c843a70f9e553b26b9e1510.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/736x/ef/37/c2/ef37c2a7468537c3b2c289799c31c921.jpg",
    }
    ,
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/736x/45/55/c6/4555c6939fbc877a40dfc99e2b2d5c82.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/564x/70/56/a2/7056a2a97d6cf555f22fbd9f473ea660.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images":
      "https://i.pinimg.com/564x/75/ca/0c/75ca0c878b6e59ef82840c6d0ef74386.jpg",
    },
    {
      "title": "Smooth Cloth.",
      "price": "\$20",
      "images": "https://i.pinimg.com/564x/2e/dd/e9/2edde90596c4180a850eefd84b80d6f2.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 310,
      ),
      itemCount: gridMap.length,
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
            color: Colors.black12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Image.network(
                  "${gridMap.elementAt(index)['images']}",
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${gridMap.elementAt(index)['title']}",
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "${gridMap.elementAt(index)['price']}",
                      style: Theme.of(context).textTheme.subtitle2!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 19.0,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.heart,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.cart,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            CupertinoIcons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
