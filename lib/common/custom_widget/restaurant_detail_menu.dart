import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class RestaurantDetailMenu extends StatelessWidget {
  final Menus menus;

  const RestaurantDetailMenu({
    Key? key,
    required this.menus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFoodSection(
            context, "Makanan", menus, "assets/picture/foodThumbnail.jpg"),
        _buildDrinkSection(
            context, "Minuman", menus, "assets/picture/drinkThumbnail.jpg"),
      ],
    );
  }

  Widget _buildFoodSection(BuildContext context, String title, Menus menus,
      String thumbnailImagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 15),
        Text(
          "$title (${menus.foods.length})",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.5,
          ),
          itemCount: menus.foods.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildMenuItem(
                context, menus.foods[index].name, thumbnailImagePath);
          },
        ),
      ],
    );
  }

  Widget _buildDrinkSection(BuildContext context, String title, Menus menus,
      String thumbnailImagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 25),
        Text(
          "$title (${menus.drinks.length})",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.5,
          ),
          itemCount: menus.drinks.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildMenuItem(
                context, menus.drinks[index].name, thumbnailImagePath);
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String name, String thumbnailImagePath) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.35,
            child: Image.asset(
              thumbnailImagePath,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
