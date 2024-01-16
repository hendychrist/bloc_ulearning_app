// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_state.dart';
import 'package:ulearning_app/pages/profile/settings/widgets/settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarSettings(),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBlocs, SettingsState>(
          builder: (context, state){

            return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    GestureDetector(
                      onTap: (){
                        
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Confirm logout"),
                              content: Text("Confirm Logout"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                     child: Text("Cancel")
                                    ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Confirm")
                                )
                              ],
                            );
                          }
                        );  

                      },
                      child: Container(
                        height: 100.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                              "assets/icons/Logout.png"
                            )
                          )
                        ),
                      ),
                    )

                  ],
                ),
            );

          },
        ),
      ),
    );
  }
}