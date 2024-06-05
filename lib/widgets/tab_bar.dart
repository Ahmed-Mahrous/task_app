import 'package:flutter/material.dart';
import 'package:task_app/themes/app_color.dart';
import 'package:task_app/views/screens/all_tasks_screen.dart';
import 'package:task_app/views/screens/done_screen.dart';
import 'package:task_app/views/screens/not_done_screen.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
              color: AppColors.secondary,
            ),
            child: TabBar(
              splashBorderRadius: BorderRadius.circular(25),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: AppColors.primary,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.primary,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    // color: AppColors.secondary,
                  ),
                  child: Tab(
                    text: 'All',
                  ),
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Not Done',
                ),
                Tab(
                  text: 'Done',
                ),
              ],
            ),
          ),
          // tab bar view here
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                Center(
                  child: AllTasksScreen(),
                ),

                // second tab bar view widget
                Center(
                  child: NotDoneScreen(),
                ),
                Center(
                  child: DoneScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
