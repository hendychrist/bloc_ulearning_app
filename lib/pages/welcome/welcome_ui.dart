// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_events.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_states.dart';

class WelcomeUI extends StatefulWidget {
  const WelcomeUI({super.key});

  @override
  State<WelcomeUI> createState() => _WelcomeUIState();
}

class _WelcomeUIState extends State<WelcomeUI> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold( 
        body: BlocBuilder<WelcomeBlocs, WelcomeState>(
          builder: (context, state) {
            return SizedBox(
              width: 375.w, 
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
            
                  PageView(
                    controller: pageController,
                    onPageChanged: (index){
                                      BlocProvider.of<WelcomeBlocs>(context).add(WelcomeEvents());
                                      state.page = index;
                                      
                                      // print('Hendie - hasil index : $index');
                                    },
                    children: [
                      _page(
                        index: 1,
                        context: context,
                        buttonName: "Next",
                        title: 'First See Learning',
                        subTitle: 'Forget about a for paper all knowledge in one learning', 
                        imagePath: 'assets/images/reading.png'
                      ),
            
                       _page( 
                        index: 2,
                        context: context,
                        buttonName: "Next",
                        title: 'Connect With Everyone',
                        subTitle: 'Always keep in touch with your tutor & friend. Let\'s get connected',
                        imagePath: 'assets/images/man.png'
                      ),
            
                       _page(
                        index: 3,
                        context: context,
                        buttonName: "Get Started",
                        title: 'Always Facinated Learning',
                        subTitle: 'Anywhere, anytime. The time is at our discrtion so study whenever you want', 
                        imagePath: 'assets/images/boy.png'
                      ),
            
            
                    ],
                  ),
            
                  Positioned(
                    bottom: 100.h,
                    child: DotsIndicator(
                              position: state.page.toInt(),
                              dotsCount: 3,
                              mainAxisAlignment: MainAxisAlignment.center,
                              decorator: DotsDecorator(
                                            color: AppColors.primaryThirdElementText,
                                            activeColor: AppColors.primaryElement,
                                            size: Size.square(8.0),
                                            activeSize: const Size(18.0, 8.0),
                                            activeShape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0 )
                                            )
            
            
                                          ),
                            )
                  )
            
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _page({required int index, required BuildContext context, required String buttonName, required String title, required  String subTitle, required String imagePath}){
    return  Column(
              children: [

                Container(
                  color: Colors.transparent,
                  width: 345.w,
                  height: 345.h,
                  alignment: Alignment.center,
                  child: Image.asset(
                          imagePath,
                          fit: BoxFit.fill,
                  ),
                      // Text(
                      //     imagePath, style: TextStyle(color: AppColors.primaryText, fontSize: 30),
                      //   ),
                ),

                Container(
                  child: Text(
                          title,
                          style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.normal
                                ),

                          ),
                ),

                Container(
                  width: 375.w,
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Center(
                    child: Text(
                            subTitle,
                            style: TextStyle(
                                    color: AppColors.primarySecondaryElementText,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal
                                  ),
                    
                            ),
                  ),
                ),

                GestureDetector( // disini
                  onTap: (){

                    if(index < 3){

                      pageController.animateToPage( 
                        index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.decelerate
                      );

                    }else{
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));

                      Global.storageService.setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
                      print('The value is : ${Global.storageService.getDeviceFirstOpen()}');

                      Navigator.of(context).pushNamedAndRemoveUntil("/sign_in", (route) => false,);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
                    width: 325.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                                  color: AppColors.primaryElement,
                                  borderRadius: BorderRadius.all(Radius.circular(15.w)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(0, 1)
                                    )
                                  ]
                                ),
                  
                                child: Center(
                                  child: Text(
                                            buttonName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                ),
                  
                  ),
                )


              ],
            );

  }

}