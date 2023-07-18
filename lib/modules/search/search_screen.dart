// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, states){},
      builder: (context, states) {
        var listSearch = NewsCubit.get(context).search;
        AppCubit cubit2 = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(

          ),
        body: Column(
          children:
          [
            Container(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: searchController,
                    cursorColor: Colors.deepOrange,
                    onChanged: (value)
                    {
                      NewsCubit.get(context).getSearch(value);
                    },
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'Search mustn\'t be Empty';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: cubit2.isDark ? Colors.black : Colors.white,
                      fontSize: 17,
                    ),
                    decoration: InputDecoration(
                      fillColor: cubit2.isDark ? Colors.white : Colors.black,
                      filled: true,
                      hintText: 'Search',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      hintStyle: TextStyle(
                        color: cubit2.isDark ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(.0),
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(.0),
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        color: Colors.deepOrange,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: articleBuilder(listSearch, context,isSearch: true)),
          ],
        ),
      );
      },
    );
  }
}
