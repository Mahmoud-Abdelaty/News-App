// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:news/modules/search/search_screen.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class NewsAppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context,state) {

        NewsCubit cubit = BlocProvider.of(context);
        AppCubit cubit2 = AppCubit.get(context);

        return Scaffold(
        appBar: AppBar(
          actions:
          [
            IconButton(
                onPressed: ()
                {
                  navigateTo(context,SearchScreen());
                },
                icon: Icon(
                    Icons.search
                )),
            FlutterSwitch(
              width: 70.0,
              toggleColor: Colors.deepOrange,
              activeColor: Colors.white,
              activeIcon:  Icon(Icons.wb_sunny),
              activeText: 'Light',
              activeTextColor: Colors.black,
              activeToggleColor: Colors.orangeAccent,
              duration: Duration(milliseconds: 2),
              inactiveColor: Colors.black,
              inactiveIcon:  Icon(Icons.dark_mode_rounded),
              inactiveText: 'Dark',
              inactiveTextColor: Colors.white,
              inactiveToggleColor: Colors.orangeAccent,
              height: 35.0,
              valueFontSize: 14.0,
              toggleSize: 18.0,
              value: cubit2.isDark,
              borderRadius: 20.0,
              padding: 6,
              showOnOff: true,
              onToggle: (status)
              {
                cubit2.changeMode() ;
              }
            ),
            IconButton(
                onPressed: ()
                {
                  cubit2.changeMode();
                },
                icon: cubit2.isDark ? Icon(Icons.wb_sunny) : Icon(Icons.dark_mode_rounded)
            ),
          ],
          title: Text(
            'News App',
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: cubit.bottomItems,
          onTap: (index)
          {
            cubit.changeBottomNavBar(index);
          },
          currentIndex: cubit.currentIndex,
        ),
          body: cubit.screens[cubit.currentIndex],
      );
      },
    );
  }
}
