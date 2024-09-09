import 'package:expanse_tracker/modal/expense.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton(
      {super.key,
      required this.selectedCategory,
      required this.onChangedCategory
      });

  final Category selectedCategory;
  final void Function(Category category) onChangedCategory;

  @override
  Widget build(context) {
    return DropdownButton(
        value: selectedCategory,
        items: Category.values
            .map(
              (category) => DropdownMenuItem(
                value: category,
                child: Text(
                  category.name,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color),
                ),
              ),
            )
            .toList(),
           onChanged: (value) {
              if (value != null) {
                onChangedCategory(value);
              }
        });
  }
}
