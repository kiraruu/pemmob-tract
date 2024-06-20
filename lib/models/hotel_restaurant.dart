import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'area_food.dart';
import 'cart_item.dart';

class Restaurant extends ChangeNotifier {
  // list
  final List<Food> _menu = [
    // HISTORICAL
    Food(
        name: "The Phoenix Hotel Yogyakarta",
        description:
            "Historic hotel combining colonial charm and modern comfort in central Yogyakarta.",
        imagePath: "assets/historical/yogyakarta.jpg",
        price: 79,
        category: hotelCategory.historical,
        availableAddons: [
          Addon(name: "Guided city tours", price: 12),
          Addon(name: "Cultural performances", price: 20),
          Addon(name: "Bicycle rentals", price: 6),
        ]),

    Food(
        name: "Hotel Tugu Malang",
        description:
            "Boutique hotel blending Javanese art and colonial architecture.",
        imagePath: "assets/historical/malang.jpg",
        price: 85,
        category: hotelCategory.historical,
        availableAddons: [
          Addon(name: "Cultural tours", price: 15),
          Addon(name: "Traditional Javanese massage", price: 20),
          Addon(name: "Art workshops", price: 12),
        ]),

    Food(
        name: "Shangri-La Hotel Surabaya",
        description:
            "Five-star hotel in the business district with spacious rooms and fine dining.",
        imagePath: "assets/historical/surabaya.jpg",
        price: 94,
        category: hotelCategory.historical,
        availableAddons: [
          Addon(name: "Personal butler service", price: 35),
          Addon(name: "Spa treatments", price: 47),
          Addon(name: "Private dining experiences", price: 56),
        ]),

    // BEACH
    Food(
        name: "Ayana Resort and Spa Bali",
        description:
            "Luxurious cliffside resort with stunning ocean views in Jimbaran Bay.",
        imagePath: "assets/beach/bali.jpg",
        price: 97,
        category: hotelCategory.beach,
        availableAddons: [
          Addon(name: "Romantic sunset dinners", price: 32),
          Addon(name: "Spa packages", price: 20),
          Addon(name: "Water sports activities", price: 67),
        ]),

    Food(
        name: "The Rinra Makassar",
        description: "Modern hotel with sea views and direct mall access.",
        imagePath: "assets/beach/makassar.jpg",
        price: 85,
        category: hotelCategory.beach,
        availableAddons: [
          Addon(name: "Private dining", price: 45),
          Addon(name: "Guided city tours", price: 30),
          Addon(name: "Spa treatments", price: 52),
        ]),

    Food(
        name: "Misool Eco Resort Raja Ampat",
        description:
            "Exclusive eco-resort on a private island with unparalleled diving.",
        imagePath: "assets/beach/rajaampat.jpg",
        price: 200,
        category: hotelCategory.beach,
        availableAddons: [
          Addon(name: "Diving packages", price: 35),
          Addon(name: "Guided snorkeling tours", price: 47),
          Addon(name: "Private beach dinners", price: 56),
        ]),

    // NATURE
    Food(
        name: "Padma Hotel Bandung",
        description:
            "Hillside resort with panoramic valley views and tranquil atmosphere.",
        imagePath: "assets/nature/bandung.jpg",
        price: 97,
        category: hotelCategory.nature,
        availableAddons: [
          Addon(name: "Guided hiking tours", price: 32),
          Addon(name: "Hot air balloon rides", price: 20),
          Addon(name: "Kids' club activities", price: 67),
        ]),

    Food(
        name: "Novotel Manado Golf Resort & Convention Center Manado",
        description:
            "Contemporary resort with a golf course and lush surroundings.",
        imagePath: "assets/nature/manado.jpg",
        price: 85,
        category: hotelCategory.nature,
        availableAddons: [
          Addon(name: "Golf packages", price: 45),
          Addon(name: "Spa treatments", price: 30),
          Addon(name: "Dining experiences", price: 52),
        ]),

    // RESORT
    Food(
        name: "Qunci Villas Lombok",
        description:
            "Elegant beachfront retreat in Senggigi with beautiful gardens.",
        imagePath: "assets/resort/lombok.jpg",
        price: 97,
        category: hotelCategory.resort,
        availableAddons: [
          Addon(name: "Snorkeling trips", price: 32),
          Addon(name: "Private beachfront dinners", price: 20),
          Addon(name: "Yoga classes", price: 67),
        ]),

    Food(
        name: "Ayana Komodo Resort Labuan Bajo",
        description:
            "Luxury resort on Waecicu Beach with breathtaking Flores Sea views.",
        imagePath: "assets/resort/labuanbajo.jpg",
        price: 85,
        category: hotelCategory.resort,
        availableAddons: [
          Addon(name: "Island-hopping tours", price: 45),
          Addon(name: "Private boat charters", price: 30),
          Addon(name: "Diving packages", price: 52),
        ]),

    // MODERN
    Food(
        name: "Hotel Indonesia Kempinski Jakarta",
        description:
            "Iconic luxury hotel in central Jakarta near shopping and business districts.",
        imagePath: "assets/modern/jakarta.jpg",
        price: 97,
        category: hotelCategory.modern,
        availableAddons: [
          Addon(name: "Personal shopping assistant", price: 32),
          Addon(name: "Private city tours", price: 20),
          Addon(name: "Spa treatments", price: 67),
        ]),

    Food(
        name: "JW Marriott Hotel Medan",
        description:
            "Luxurious downtown hotel with a rooftop pool and exceptional dining.",
        imagePath: "assets/modern/medan.jpg",
        price: 85,
        category: hotelCategory.modern,
        availableAddons: [
          Addon(name: "Executive lounge access", price: 45),
          Addon(name: "Spa packages", price: 30),
          Addon(name: "Guided city tours", price: 52),
        ]),
  ];

  // GETTERS
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

  // OPERATIONS

  // user cart
  final List<CartItem> _cart = [];

  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // check cart
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if hotel are same
      bool isSameHotel = item.food == food;

      // check list addons are same
      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameHotel && isSameAddons;
    });

    // increase quantity if item already exist
    if (cartItem != null) {
      cartItem.quantity++;
    }

    // add new cart item to cart

    else {
      _cart.add(
        CartItem(
          food: food,
          selectedAddons: selectedAddons,
        ),
      );
    }

    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // total price
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  // total number
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // HELPERS

  // generate receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt..");
    receipt.writeln();

    // format date
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

        receipt.writeln(formattedDate);
        receipt.writeln();
        receipt.writeln("--------------");

        for (final cartItem in _cart) {
          receipt.writeln("${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
          if (cartItem.selectedAddons.isNotEmpty) {
            receipt.writeln("     Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
          }
          receipt.writeln();
        }

        receipt.writeln("------------");
        receipt.writeln();
        receipt.writeln("Total Add: ${getTotalItemCount()}");
        receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

        return receipt.toString();
  }

  // format double value
  String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

  // format list addons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}
