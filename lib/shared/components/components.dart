// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/sports/sports_screen.dart';
import 'package:news/modules/web_view/web_view_screen.dart';


Widget buildArticleItem(article, context) => InkWell(
  onTap: ()
  {
     // navigateTo(context, WebViewScreen(article['source']['name'],article['url']));
     Navigator.push(context, MaterialPageRoute(builder: (context) =>  WebViewScreen(article['source']['name'],article['url'])));
  },
  child: Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children:
  
      [
  
        Container(
  
          width: 120,
  
          height: 120,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(10),
  
            image: DecorationImage(
  
              image: NetworkImage('${article['urlToImage']}'),
  
              fit: BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120,
  
            child: Column(
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children:
  
              [
  
                Expanded(
  
                  child: Text(
  
                    '${article['title']}',
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                  ),
  
                ),
  
                Text(
  
                  '${article['publishedAt']}',
  
                  style: TextStyle(
  
                      color: Colors.grey
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

Widget articleBuilder(list, context,{isSearch = false}) => ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return buildArticleItem(list[index], context);
      },
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20
        ),
        child: Container(
          color: Colors.deepOrange,
          width: double.infinity,
          height: 1,
        ),
      ),
      itemCount: list.length,
    );
  },
  fallback: (context) => isSearch ? Container()  : Center(child: CircularProgressIndicator()),
);

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget,
    ),);

