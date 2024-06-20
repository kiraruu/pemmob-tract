import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tract/components/my_button.dart';
import 'package:tract/components/my_cart_tile.dart';
import 'package:tract/models/hotel_restaurant.dart';
import 'package:tract/page/payment_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        // cart
        final userCart = restaurant.cart;

        // scaffold ui
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: Theme.of(context).colorScheme.primary, // Updated background color
            foregroundColor: Colors.white, // Updated foreground color
            actions: [
              // clear button
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Are you sure you want to clear the cart?"),
                      actions: [
                        // cancel
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        // yes
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: Column(
            children: [
              // list cart
              Expanded(
                child: userCart.isEmpty
                    ? const Center(
                        child: Text("Cart is Empty"),
                      )
                    : ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          // get individual item
                          final cartItem = userCart[index];

                          // return cart tile ui
                          return MyCartTile(cartItem: cartItem);
                        },
                      ),
              ),

              // pay button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentPage(),
                    ),
                  ),
                  text: "Go to Checkout",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
