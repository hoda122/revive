import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revive/layout/cubit/cubit.dart';
import 'package:revive/layout/cubit/states.dart';
import 'package:revive/models/slider/listofslider.dart';
import 'package:revive/modules/search/search.dart';
import 'package:revive/shared/component/component.dart';
import 'package:revive/shared/network/end_point.dart';
import 'package:revive/shared/network/local/shared_pref.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  HomeLayout({super.key, required this.index});
  int index, count = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          if (index != 0 && count == 0) {
            cubit.currentIndex = index;
            count++;
          }
          return ConditionalBuilder(
            condition: true,
            builder: (context) => Scaffold(
              extendBody: true,
              backgroundColor: Colors.grey[100],
              appBar: AppBar(
                actions: [
                  // CircleAvatar(
                  //   radius: 23,
                  //   backgroundColor: Color.fromARGB(255, 68, 124, 70),
                  //   child: CircleAvatar(
                  //     radius: 21.3,
                  //     backgroundImage:NetworkImage(server+sharedPref.getData(key: "profilePic"),
                  //     ),
                  //   ),
                  // ),
                  IconButton(
                      onPressed: () {
                        navigate(context, Search());
                      },
                      icon: Icon(Icons.search)),
                  SizedBox(
                    width: 12,
                  ),
                ],
                title: TitletextWidget(
                  textName: cubit.title[cubit.currentIndex],
                ),
                centerTitle: true,
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: CurvedNavigationBar(
                color: Color.fromRGBO(106, 192, 66, 1),
                height: 50,
                animationCurve: Easing.linear,
                backgroundColor: Colors.transparent,
                animationDuration: Duration(milliseconds: 500),
                items: cubit.itemIcons,
                index: cubit.currentIndex,
                onTap: (value) {
                  cubit.changeNav(value);
                },
              ),
              drawer: Drawer(
                backgroundColor: Color.fromARGB(255, 228, 228, 228),
                child: headofslider(
                  userName: sharedPref.getData(key: "username"),
                  email: sharedPref.getData(key: "email"),
                  backgroundImage: "assets/images/soft.jpg",
                  imageOfprof: server + sharedPref.getData(key: "profilePic"),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

class TitletextWidget extends StatelessWidget {
  final String textName;

  const TitletextWidget({
    super.key,
    required this.textName,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 3),
      baseColor: Color.fromARGB(255, 68, 124, 70),
      highlightColor: Color.fromARGB(255, 169, 172, 20),
      child: Text(
        textName,
        style: TextStyle(
          fontSize: 30,
          fontFamily: "Title",
          color: Color.fromARGB(255, 68, 124, 70),
        ),
      ),
    );
  }
}
