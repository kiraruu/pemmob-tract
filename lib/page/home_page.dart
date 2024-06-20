import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tract/components/my_current_loc.dart';
import 'package:tract/components/my_drawer.dart';
import 'package:tract/components/my_food_tile.dart';
import 'package:tract/components/my_sliver_app_bar.dart';
import 'package:tract/components/my_tab_bar.dart';
import 'package:tract/models/area_food.dart';
import 'package:tract/models/hotel_restaurant.dart';
import 'package:tract/page/food_page.dart';
import 'package:tract/models/activity.dart';

import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<Activity> futureActivity;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: hotelCategory.values.length, vsync: this);
    futureActivity = fetchRandomActivity();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Activity> fetchRandomActivity() async {
    final response =
        await http.get(Uri.parse('https://bored-api.appbrewery.com/random'));
    if (response.statusCode == 200) {
      return Activity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load random activity');
    }
  }

  void getActivity() {
    setState(() {
      futureActivity = fetchRandomActivity();
    });
  }

  List<Food> _filterMenuByCategory(
      hotelCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  List<Widget> getHotelInThisCategory(List<Food> fullMenu) {
    return hotelCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return FoodTile(
              food: food,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodPage(food: food),
                  )));
        },
      );
    }).toList();
  }

  // navigate profile
  void goToProfilePage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController),
            onPressedGetActivity: getActivity,
            futureActivity: futureActivity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const MyCurrentLocation(),
              ],
            ),
          ),
        ],
        body: Consumer<Restaurant>(
          builder: (context, restaurant, child) => TabBarView(
            controller: _tabController,
            children: getHotelInThisCategory(restaurant.menu),
          ),
        ),
      ),
    );
  }
}
