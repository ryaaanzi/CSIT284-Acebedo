import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
const MealItem({
super.key,
required this.meal,
});

final Meal meal;

@override
Widget build(BuildContext context) {
return Card(
margin: const EdgeInsets.all(8),
clipBehavior: Clip.hardEdge,
child: Stack(
children: [
FadeInImage(
placeholder: MemoryImage(kTransparentImage),
image: NetworkImage(meal.imageUrl),
fit: BoxFit.cover,
height: 200,
width: double.infinity,
),
Positioned(
bottom: 0,
left: 0,
right: 0,
child: Container(
color: Colors.black54,
padding: const EdgeInsets.symmetric(
vertical: 6,
horizontal: 8,
),
child: Text(
meal.title,
style: const TextStyle(
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
),
textAlign: TextAlign.center,
),
),
),
],
),
);
}
}