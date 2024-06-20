import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tract/components/my_button.dart';
import 'package:tract/models/area_food.dart';
import 'package:tract/models/hotel_restaurant.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  FoodPage({super.key, required this.food}) {
    // initialize selected addons = false
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  // method add to cart
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {

    // close current page
    Navigator.pop(context);

    // selected addon 
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true ) {
        currentlySelectedAddons.add(addon);
      }
    }

    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // scaffold ui
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // image
                Image.asset(widget.food.imagePath),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 24, // Adjusted font size
                        ),
                      ),

                      const SizedBox(height: 8),

                      // price
                      Text(
                        '\$' + widget.food.price.toString(),
                        style: TextStyle(
                          fontSize: 20, // Adjusted font size
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600, // Adjusted font weight
                        ),
                      ),

                      const SizedBox(height: 16),

                      // desc
                      Text(
                        widget.food.description,
                        style: const TextStyle(fontSize: 16), // Adjusted font size
                      ),

                      const SizedBox(height: 20),

                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 1, // Adjusted thickness
                      ),

                      const SizedBox(height: 20),

                      // addons
                      Text(
                        "Activity Recommendations",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 18, // Adjusted font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: widget.food.availableAddons.length,
                          itemBuilder: (context, index) {
                            // individual addons
                            Addon addon = widget.food.availableAddons[index];

                            // return checkbox
                            return CheckboxListTile(
                              title: Text(
                                addon.name,
                                style: const TextStyle(fontSize: 16), // Adjusted font size
                              ),
                              subtitle: Text(
                                '\$${addon.price}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14, // Adjusted font size
                                ),
                              ),
                              value: widget.selectedAddons[addon],
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.selectedAddons[addon] = value!;
                                });
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),

                // button cart
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: MyButton(
                    onTap: () => addToCart(widget.food, widget.selectedAddons),
                    text: "Reservation Now",
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),

        // back button
        SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 25, top: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: Colors.white, // Set icon color to white
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }
}
