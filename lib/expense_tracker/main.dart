import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomeScreen(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'IRANSans',
      ),
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت هزینه'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Header(),
              SizedBox(
                height: 8,
              ),
              _MainContent(),
              SizedBox(
                height: 8,
              ),
              _QuickInsights(),
              // ignore: require_trailing_commas
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNavigationBar(),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          label: 'خانه',
          icon: Icon(
            Icons.home_rounded,
            color: Colors.black,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Label',
          icon: Icon(
            Icons.report_rounded,
            color: Colors.black,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Label',
          icon: Icon(
            Icons.add_rounded,
            color: Colors.black,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Label',
          icon: Icon(
            Icons.settings_rounded,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _QuickInsights extends StatelessWidget {
  const _QuickInsights();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'گزارش ماهانه',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'کل هزینه‌ها: ۳۰۰,۰۰۰ تومان',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '(۱۰٪ کمتر از ماه قبل)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'مشاهده گزارش کامل',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickCategories extends StatelessWidget {
  const _QuickCategories();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'دسته‌های پرکاربرد',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.food_bank_rounded,
                  color: Colors.blueGrey,
                  size: 48,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_bag_rounded,
                  color: Colors.brown,
                  size: 48,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.transfer_within_a_station_outlined,
                  color: Colors.orange,
                  size: 48,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     TextButton(
        //       onPressed: () {},
        //       child: const Text(
        //         'مدیریت دسته‌ها',
        //         style: TextStyle(fontSize: 18),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _RecentExpenses(),
        SizedBox(
          height: 8,
        ),
        _QuickCategories(),
      ],
    );
  }
}

class _RecentExpenses extends StatelessWidget {
  const _RecentExpenses();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'آخرین هزینه‌ها',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'غذا: ۵۰,۰۰۰ تومان (امروز)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'حمل‌ونقل: ۲۰,۰۰۰ تومان (دیروز)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'حمل‌ونقل: ۲۰,۰۰۰ تومان (۲ روز پیش)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'مشاهده همه',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'موجودی فعلی: ۱,۲۰۰,۰۰۰ تومان',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
