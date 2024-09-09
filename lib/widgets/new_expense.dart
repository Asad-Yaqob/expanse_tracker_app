import 'package:expanse_tracker/widgets/datepicker.dart';
import 'package:expanse_tracker/widgets/dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:expanse_tracker/modal/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onPressedAdd});

  final void Function(Expense expense) onPressedAdd;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDialog() {
    // if (Platform.isWindows) {
    //   showCupertinoDialog(
    //     context: context,
    //     builder: (ctx) => CupertinoAlertDialog(
    //       title: const Text('Invalid Input!'),
    //       content: const Text(
    //           'Please make sure a valid title, amount, date and category was entered.'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(ctx);
    //           },
    //           child: const Text('Okay'),
    //         )
    //       ],
    //     ),
    //   );
    // } else {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input!'),
        content: const Text(
            'Please make sure a valid title, amount, date and category was entered.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Okay'),
          )
        ],
      ),
    );
  }
  // }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
        _amountController.text); //converting to int from string.
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onPressedAdd(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          category: _selectedCategory,
          date: _selectedDate!),
    );
    Navigator.pop(context);
  }

  void updateSelectedCategory(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('Title'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                )
              else
                TextFormField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
              if (width >= 600)
                Row(
                  children: [
                    MyDropdownButton(
                      selectedCategory: _selectedCategory,
                      onChangedCategory: updateSelectedCategory,
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: MyDatePicker(
                          selectedDate: _selectedDate,
                          datePicker: _presentDatePicker),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: MyDatePicker(
                          selectedDate: _selectedDate,
                          datePicker: _presentDatePicker),
                    ),
                  ],
                ),
              const SizedBox(
                height: 26,
              ),
              if (width >= 600)
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save Expense'),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    MyDropdownButton(
                      selectedCategory: _selectedCategory,
                      onChangedCategory: updateSelectedCategory,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save Expense'),
                    ),
                  ],
                )
            ]),
          ),
        ),
      );
    });
  }
}
