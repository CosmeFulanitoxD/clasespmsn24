import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fluttersample1/provider/test_provider.dart';
import 'package:fluttersample1/screens/coffee_screen.dart';
import 'package:fluttersample1/screens/profile_screen.dart';
import 'package:fluttersample1/settings/colors_settings.dart';
import 'package:fluttersample1/settings/global_values.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    TestProvider testProvider = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.navColor,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          GestureDetector(
              onTap: () {},
              child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.asset('assets/camaras.png')))
        ],
      ),
      body: Builder(builder: (context) {
        switch (index) {
          case 1:
            return ProfileScreen();

            break;

          default:
            return CoffeeScreen();
        }
      }),
      //endDrawer: Drawer(),
      drawer: myDrawer(testProvider),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: 'home'),
          TabItem(icon: Icons.person, title: 'user'),
          TabItem(icon: Icons.exit_to_app, title: 'exit'),
        ],
        onTap: (int i) => setState(() {
          index = i;
        }),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        children: [
          FloatingActionButton.small(
              heroTag: "btn1",
              onPressed: () {
                GlobalValues.banthemeDark.value = false;
              },
              child: const Icon(Icons.light_mode)),
          FloatingActionButton.small(
            heroTag: "btn2",
            onPressed: () {
              GlobalValues.banthemeDark.value = true;
            },
            child: const Icon(Icons.dark_mode),
          ),
        ],
      ),
    );
  }

  Widget myDrawer(TestProvider testProvider) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
              accountName: Text(testProvider.name),
              accountEmail: const Text('max.a.palma.mtz@gmail.com')),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/db'),
            title: Text('Movies List'),
            subtitle: Text('Database of movies'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/apiscreen'),
            title: Text('Api screen'),
            subtitle: Text('Screen of APIS'),
            leading: Icon(Icons.star),
            trailing: Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}
