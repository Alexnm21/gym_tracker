//Filtro para elegir entre todas las categorias, utilizado en listas.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/config/app_theme.dart';
import 'package:gym_tracker/domain/controllers/category_controller.dart';
import 'package:gym_tracker/domain/controllers/training_controller.dart';
import 'package:gym_tracker/domain/models/models.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {

    CategoryController categoryCtrl = Get.find();
    List<ExerciseCategory> categories = categoryCtrl.categories;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: ListView.builder(
        
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return _CategoryCard(category: categories[index]);
        },
      ),
    );
  }
}


class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final ExerciseCategory category;

  @override
  Widget build(BuildContext context) {

    TrainingController trainingCtrl = Get.find();
    CategoryController categoryCtrl = Get.find();

    return GestureDetector(
      onTap: (){
        if(trainingCtrl.selectedCategory.value == category){
          trainingCtrl.selectedCategory.value = null;
          trainingCtrl.exercises.value = categoryCtrl.getExercisesByCategory(null);

        }else {
          trainingCtrl.selectedCategory.value = category;
          trainingCtrl.exercises.value = categoryCtrl.getExercisesByCategory(category);
        }
      },
      child: Obx(
        (){
          bool isSelected = trainingCtrl.selectedCategory.value == category;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(5),
              margin:  const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Color(category.color)),
                borderRadius: BorderRadius.circular(50),
                color: isSelected ? Color(category.color) : Colors.white
              ),
              child: Center(child: Text(category.name, style: AppTheme.h4Medium.copyWith(color: isSelected ? Colors.white : Color(category.color)),),),
          );}
      ),
    );
  }
}