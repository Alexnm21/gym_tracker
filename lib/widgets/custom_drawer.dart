import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/config/app_theme.dart';
import 'package:gym_tracker/screens/categories_screen.dart';
import 'package:gym_tracker/screens/screens.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  final double iconHeight = 35;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'GymTracker',
              style: AppTheme.h3Bold.copyWith(color: Colors.white)
            ),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/gym-dumble.svg',height: iconHeight, color: Colors.white,),
            title: Text('Ejercicios', style: AppTheme.h3Normal.copyWith(color: Colors.white),),
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
              Get.to(const ExercisesScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/categories.svg',height: iconHeight, color: Colors.white,),
            title: Text('Categorías', style: AppTheme.h3Normal.copyWith(color: Colors.white),),

            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
              Get.to(const CategoriesScreen());
            },
          ),
        ],
      ),
    );
  }
}