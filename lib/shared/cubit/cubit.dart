// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:news/modules/sports/sports_screen.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =
      [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
            ),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.sports_handball,
          ),
          label: 'Sports',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.science,
          ),
          label: 'Science',
        ),
      ];

  List<Widget> screens =
      [
        BusinessScreen(),
        SportsScreen(),
        ScienceScreen(),
      ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    if(index == 1) {
      getSports();
    }
    if(index == 2)
    {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    if(business.isEmpty)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category':'business',
            'apiKey':'500f21c485414a82a58ea786dd68d504'
          },).then((value)
        {
          //print(value.data['articles'][1]['title']);
          business = value.data['articles'];
          // print(business[1]['title']);
          emit(NewsGetBusinessSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetBusinessErrorState(error.toString()));
        });
      }else
        {
          emit(NewsGetBusinessLoadingState());
        }

  }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.isEmpty)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country': 'eg',
              'category':'sports',
              'apiKey':'500f21c485414a82a58ea786dd68d504'
            }).then((value)
        {
          sports = value.data['articles'];
          //print(sports[1]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }else
        {
          emit(NewsGetSportsLoadingState());
        }

  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.isEmpty)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'science',
              'apiKey':'500f21c485414a82a58ea786dd68d504',
            }).then((value){
          science = value.data['articles'];
          //   print(science[1]['title']);
          emit(NewsGetScienceSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        });
      }else
        {
          emit(NewsGetScienceLoadingState());
        }
  }

  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':'$value',
            'apiKey':'500f21c485414a82a58ea786dd68d504',
          }).then((value){
        search = value.data['articles'];
        //   print(science[1]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
  }


}

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

   bool isDark = true ;

  void changeMode({bool? fromShared})
  {
    if(fromShared != null)
      {
        isDark = fromShared;
        emit(NewsChangeModeState());
      }else
        {
          isDark= !isDark;
          CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
          {
            emit(NewsChangeModeState());
          });
        }
  }


}

//https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=500f21c485414a82a58ea786dd68d504
// https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=500f21c485414a82a58ea786dd68d504