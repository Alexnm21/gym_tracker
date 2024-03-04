import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/config/app_theme.dart';
import 'package:gym_tracker/config/utils.dart';
import 'package:gym_tracker/domain/models/models.dart';

class TrainingContainer extends StatelessWidget {
  const TrainingContainer({super.key, required this.training});

  final Training training;

  @override
  Widget build(BuildContext context) {
  
    return Container(
      
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: createGradientFromColor(Color(training.exercise.category.color)),
        borderRadius: BorderRadius.circular(20),
        boxShadow:[boxShadow()]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(training.exercise.name, style: AppTheme.h4Medium.copyWith(color: Colors.white, shadows: textShadow()),),
          Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 10),
            child: Container(width: Get.width, height: 2, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),),
          ),
          Column(children: training.series.map((serie) => _SerieWidget(serie: serie)).toList(),)
      ],),
    );
  }
}

class _SerieWidget extends StatelessWidget {
  const _SerieWidget({required this.serie});
  final Serie serie;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${serie.weight} kgs', style: AppTheme.h6Medium.copyWith(color: Colors.white, shadows: textShadow()),),
        Text('${serie.reps} reps', style: AppTheme.h6Medium.copyWith(color: Colors.white, shadows: textShadow()),),
      ]
    );
  }
}