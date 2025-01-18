import 'package:app_architecture_new/expense_tracker/domain/models/category/category.dart';
import 'package:flutter/material.dart';

import '../../core/themes/dimens.dart';
import '../view_models/category_viewmodel.dart';

const String bookingButtonKey = 'booking-button';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    required this.viewModel,
    super.key,
  });

  final CategoryViewModel viewModel;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CategoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListenableBuilder(
          listenable: widget.viewModel.load,
          builder: (context, child) {
            if (widget.viewModel.load.running) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (widget.viewModel.load.error) {
              return Center(
                child: Text(widget.viewModel.load.error.toString()),
              );
            }

            return child!;
          },
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimens.of(context).paddingScreenVertical,
                        horizontal: Dimens.of(context).paddingScreenHorizontal,
                      ),
                      child: const Text('Commented'),
                      // child: CategoryHeader(viewModel: widget.viewModel),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: widget.viewModel.categories.length,
                    itemBuilder: (_, index) => _Category(
                      key: ValueKey(widget.viewModel.categories[index].id),
                      category: widget.viewModel.categories[index],
                      // onTap: () => context.push(
                      //   Routes.bookingWithId(
                      //     widget.viewModel.categories[index].id,
                      //   ),
                      // ),
                      onTap: () {},
                      confirmDismiss: (_) async {
                        return null;

                        // // wait for command to complete
                        // await widget.viewModel.deleteBooking.execute(
                        //   widget.viewModel.categories[index].id,
                        // );
                        // // if command completed successfully, return true
                        // if (widget.viewModel.deleteBooking.completed) {
                        //   // removes the dismissable from the list
                        //   return true;
                        // } else {
                        //   // the dismissable stays in the list
                        //   return false;
                        // }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({
    required this.category,
    required this.onTap,
    required this.confirmDismiss,
    super.key,
  });

  final CategoryExp category;
  final GestureTapCallback onTap;
  final ConfirmDismissCallback confirmDismiss;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(category.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: confirmDismiss,
      background: Container(
        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: Dimens.paddingHorizontal),
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.of(context).paddingScreenHorizontal,
            vertical: Dimens.paddingVertical,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
