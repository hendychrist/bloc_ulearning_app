// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/profile/bloc/profile_bloc.dart';
import 'package:ulearning_app/pages/profile/widgets/profile_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void didChangeDependencies() { 
    super.didChangeDependencies();
    var userProfile = Global.storageService.getUserProfile(); // Instance of 'UserItem'

    context.read<ProfileBlocs>().add(TriggerProfileName(userProfile));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBlocs, ProfileStates>(
              builder: (blocCtx, state) {

                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: buildAppbar(),
                  body: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                            profileIconAndEditButton(), // for showing profile image.

                            SizedBox(height: 15.h),

                            buildProfileName(state), // for showing profile name
                      
                            SizedBox(height: 30.h),

                            Padding( // Build Row Buttons
                              padding: EdgeInsets.only(left: 5.w, bottom: 20.h),
                              child: buildRowView(context),
                            ),
                     

                            Padding(
                              padding: EdgeInsets.only(left: 25.w),
                              child: buildListView(context)
                            ),
                
                        ],
                      ),
                    ),
                  ),
                );
        
            }
    );
  }
}