import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/config/app_theme.dart';
import 'package:gym_tracker/config/utils.dart';
import 'package:gym_tracker/domain/controllers/training_controller.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {

    TrainingController trainingCtrl = Get.find();

    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.backgroundColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){trainingCtrl.previousDay();},
          ),
          InkWell(
            onTap: () async {
              DateTime? newDate = await showDatePicker(context: context, firstDate: DateTime(2022), lastDate: DateTime(2025),  );
              if(newDate!= null) trainingCtrl.selectedDay.value = newDate;
            },
            child: Obx(
              ()=> Text(
                '${getWeekDay(trainingCtrl.selectedDay.value)}  ${trainingCtrl.selectedDay.value.day}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: (){trainingCtrl.nextDay();},
          ),
        ],
      ),
    );
  }
}