// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_blocs.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_states.dart';
import 'package:ulearning_app/pages/home/home_controller.dart';
import 'package:ulearning_app/pages/home/widgets/home_page_widgets.dart';
 
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
  late HomeController _homeController;

  @override
  void initState(){
    super.initState();
    _homeController = HomeController(context: context);
    _homeController.init();

    debugPrint('Hendie - _homeController.userProfile.avatar : ${_homeController.userProfile.avatar}');
    debugPrint('Hendie -  _homeController.userProfile.name : ${_homeController.userProfile.name}');
  }

  @override
  Widget build(BuildContext context) {
    
   return _homeController.userProfile != null
    ?
     SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(avatar: _homeController.userProfile.avatar.toString()),
        body: BlocBuilder<HomePageBlocs, HomePageStates>(
          builder: (context, state) {
            
            debugPrint('Hendie -');
            debugPrint('Hendie - Home_page');
            debugPrint("Hendie - ${state.courseItem[0].price }");
            debugPrint('Hendie -');

            return Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
                    child: CustomScrollView(    
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      slivers: [
             
                        SliverToBoxAdapter(
                          child: homePageText('Hello', top: 20, color: AppColors.primaryThirdElementText, bot: 0)
                        ),
                      
                        SliverToBoxAdapter(
                          child: homePageText(
                                  _homeController.userProfile.name ?? "name is empty",
                                  top: 0,
                                  bot: 20
                                )
                        ),

                        SliverToBoxAdapter(
                          child: searchView()
                        ),

                        SliverToBoxAdapter(
                          child: slidersView(context, state)
                        ),

                        SliverToBoxAdapter(
                          child: menuView()
                        ),

                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                                      vertical: 18.h,
                                      horizontal: 0.w
                                    ),
                          sliver: SliverGrid(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 15,
                                                    crossAxisSpacing: 15,
                                                    childAspectRatio: 1.6
                                                  ),
                                    delegate: SliverChildBuilderDelegate(
                                                  childCount: state.courseItem.length,
                                                  (BuildContext context, int index){
                                                      return GestureDetector(
                                                        onTap: (){
                                                          
                                                        }, 
                                                        child: courseGrid(state.courseItem[index]),
                                                      );
                                                  }
                                                ),
                                  ),
                        )
            
                      ],
                    ), 
                    
                  );
          }
        ),
      ),
    )
    :
      Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
  }
}