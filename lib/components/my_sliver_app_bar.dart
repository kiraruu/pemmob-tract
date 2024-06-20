import 'package:flutter/material.dart';
import 'package:tract/page/cart_page.dart';
import 'package:tract/models/activity.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  final Function() onPressedGetActivity;
  final Future<Activity> futureActivity;

  const MySliverAppBar({
    Key? key,
    required this.child,
    required this.title,
    required this.onPressedGetActivity,
    required this.futureActivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: title,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onPressedGetActivity,
                child: const Text("Get activities"),
              ),
              const SizedBox(height: 20),
              FutureBuilder<Activity>(
                future: futureActivity,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Text(
                      'Activity: ${snapshot.data!.aktivitas}',
                      style: TextStyle(fontSize: 18),
                    );
                  } else {
                    return const Text('Theres no data');
                  }
                },
              ),
            ],
          ),
        ),
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        expandedTitleScale: 1,
      ),
    );
  }
}
