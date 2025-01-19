import 'package:app_architecture_new/expense_tracker/domain/models/category/category.dart';
import 'package:flutter/material.dart';

import '../view_models/add_category_viewmodel.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({
    required this.viewModel,
    super.key,
  });

  final AddCategoryViewModel viewModel;

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  late TextEditingController _titleController;
  Color _selectedColor = Colors.black; // Default color

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();

    widget.viewModel.addCategory.addListener(
      () {
        if (widget.viewModel.addCategory.completed) {
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveCategory() {
    if (_titleController.text.isNotEmpty) {
      widget.viewModel.addCategory.execute(
        CategoryExp(
          id: 0,
          title: _titleController.text,
          color: _selectedColor.value,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
    }
  }

  Future<void> _pickColor() async {
    Color? pickedColor = await showDialog(
      context: context,
      builder: (context) => ColorPickerDialog(initialColor: _selectedColor),
    );

    if (pickedColor != null) {
      setState(() {
        _selectedColor = pickedColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
        actions: [
          TextButton(
            onPressed: _saveCategory,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text Input for Title
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Category Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Color Picker Section
              Row(
                children: [
                  const Text(
                    'Selected Color:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _pickColor,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Status or Loading/Error UI
              Expanded(
                child: ListenableBuilder(
                  listenable: widget.viewModel.addCategory,
                  builder: (context, child) {
                    if (widget.viewModel.addCategory.running) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (widget.viewModel.addCategory.error) {
                      return Center(
                        child:
                            Text(widget.viewModel.addCategory.error.toString()),
                      );
                    }

                    return child!;
                  },
                  child: ListenableBuilder(
                    listenable: widget.viewModel,
                    builder: (context, _) {
                      return const Text('Ready to add a category');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Color Picker Dialog Widget
class ColorPickerDialog extends StatelessWidget {
  const ColorPickerDialog({required this.initialColor, super.key});

  final Color initialColor;

  final List<Color> _colors = const [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.brown,
    Colors.cyan,
    Colors.pink,
    Colors.teal,
    Colors.grey,
    Colors.indigo,
    Colors.lime,
    Colors.amber,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a Color'),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Number of colors per row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          shrinkWrap: true,
          itemCount: _colors.length,
          itemBuilder: (context, index) {
            final color = _colors[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop(color);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: initialColor == color
                        ? Colors.black
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
