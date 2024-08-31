import 'package:expanse_tracker/modal/expense.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  MyDropdownButton({super.key, required this.selectedCategory});

  Category selectedCategory;

  @override
  State<MyDropdownButton> createState() {
    return _MyDropdownButtonState();
  }
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  @override
  Widget build(context) {
    return DropdownButton(
        value: widget.selectedCategory,
        items: Category.values
            .map(
              (category) => DropdownMenuItem(
                value: category,
                child: Text(
                  category.name,
                style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value == null) {
              return;
            }
            widget.selectedCategory = value;
          });
        });
  }
}
