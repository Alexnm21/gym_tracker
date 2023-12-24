import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/config/app_theme.dart';
import 'package:gym_tracker/config/utils.dart';
import 'package:gym_tracker/controllers/training_controller.dart';
import 'package:gym_tracker/models/models.dart';
import 'package:gym_tracker/services/trainings_service.dart';
import 'package:gym_tracker/widgets/widgets.dart';

class TrainingDetailsScreen extends StatefulWidget {
  const TrainingDetailsScreen({super.key, required this.exercise, this.previousTraining});

  final Exercise exercise;
  final Training? previousTraining;

  @override
  State<TrainingDetailsScreen> createState() => _TrainingDetailsScreenState();
}

class _TrainingDetailsScreenState extends State<TrainingDetailsScreen> {

  late Training training;
  TrainingController trainingCtrl = Get.find();

  @override
  void initState() {
    if(widget.previousTraining != null){
      training = widget.previousTraining!;
    }else{
      training = Training(exercise: widget.exercise, series: [], date: trainingCtrl.selectedDay.value);
    }
    super.initState();
  }
  void showFlushbar(BuildContext context) {
    Flushbar(
      backgroundColor: AppTheme.addColor,
      borderRadius: BorderRadius.circular(20),
      title: "Entrenamiento guardado",
      message: "Este es un mensaje de alerta.",
      duration: const Duration(seconds: 2), // Puedes ajustar la duración según tus necesidades
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
        actions: [
          IconButton(onPressed: (){TrainingsService().addOrUpdateTraining(training); showFlushbar(context); }, icon: const Icon(Icons.save))
        ],
        bottom: const _TapBar(),
      ),
      
      
      body: PopScope(
        onPopInvoked: (didPop) {
          trainingCtrl.loadTrainings();
        },
        child: Obx(() {
          if(trainingCtrl.currentScreen.value == 0) return _trainingScreen();
          if(trainingCtrl.currentScreen.value == 1) return _historyScreen();
          return const SizedBox();
        },)
      )
    );
  }

  Column _trainingScreen() {
    return Column(
        children: [
        const _Weight(),
        const _Reps(),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ChronometerButton(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.addColor,
                  foregroundColor: Colors.white
              ),
              onPressed: (){
                double weight = trainingCtrl.weight.value;
                int reps = trainingCtrl.reps.value;
                  
                if(weight == 0.0 || reps == 0) return;
                setState(() {
                  training.series.add(Serie(reps: reps, weight: weight));
                });
              }, 
                child: const Text('Añadir serie')
              ),
              const SizedBox(width: 50,)
            ],
          ),
        ),
        Expanded(child: _SeriesList(training: training, update: (){setState(() {
          
        });}))
      ],);
  }

  FutureBuilder _historyScreen() {
    return FutureBuilder(
      future: TrainingsService().getTrainingsByExercise(widget.exercise), 
      builder:(context, snapshot) {
        if(!snapshot.hasData) return const CircularProgressIndicator();
        List<Training> trainingList = snapshot.data!;
        return ListView.builder(
          itemCount: trainingList.length,
          itemBuilder: (BuildContext context, int index) {
            return _TrainingContainer(trainingList[index]);
          },
        );
      },
      );
  }

}

class _TrainingContainer extends StatelessWidget {
  const _TrainingContainer(this.training);
  final Training training;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color:AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Text(dateString(training.date), style: AppTheme.h4Bold,),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          height: 2,
          width: 200,
          color: Colors.black,
        ),
        Column(
          children: training.series.map((e) => Text('${e.weight} kgs, ${e.reps} reps',  style: AppTheme.h6Medium)).toList()
          )
      ]),
    );
  }
}

class _TapBar extends StatelessWidget implements PreferredSizeWidget {
  const _TapBar();

  @override
  Widget build(BuildContext context) {
    TrainingController trainingCtrl = Get.find();
    return Obx(
      ()=> DefaultTabController(
        initialIndex: trainingCtrl.currentScreen.value,
        length: 2,
        child: TabBar(
          onTap:(value) {
            trainingCtrl.currentScreen.value = value;
          },
          labelStyle: AppTheme.h4Bold.copyWith(color: Colors.white),
              tabs: const [
                Tab(text: 'Entrenamiento',),
                Tab(text: 'Historial'),
              ],
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


class _Weight extends StatelessWidget {
  const _Weight();

  @override
  Widget build(BuildContext context) {
    TrainingController trainingCtrl = Get.find();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //TITULO
          Text('PESO (kg)', style: AppTheme.h4Bold,),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            height: 2,
            width: Get.width,  
            color: AppTheme.primary,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _OperationButton(
                simbol: '-',
                function: (){
                  double newValue = trainingCtrl.weight.value - 5.0;
                  if(newValue < 0 ){
                    newValue = 0;
                  }
                  trainingCtrl.weight.value = newValue;
                },
              ),

              Obx(()=> Container(
                  margin: const EdgeInsets.all(10),
                  width: 100,
                  child: TextField(
                    controller: TextEditingController(text: '${trainingCtrl.weight.value}'),
                    onChanged: (value) {
                      double newValue = double.tryParse(value) ?? 0.0;
                      if(newValue > 0){
                        trainingCtrl.weight.value = newValue;
                      }else{
                        trainingCtrl.weight.value = 0.0;
                      }
                    },
                    keyboardType: const TextInputType.numberWithOptions(decimal: true), // Acepta números con decimales
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')), // Permite hasta dos decimales
                    ],
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.primary)
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.primary)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.primary, width: 2)
                      ),
                    ),
                  ),
                ),
              ),

              _OperationButton(simbol: '+', function: (){trainingCtrl.weight.value = trainingCtrl.weight.value + 5.0;}),
            ],
          )
      ]),
    );
  }
}

class _Reps extends StatelessWidget {
  const _Reps();

  @override
  Widget build(BuildContext context) {
    TrainingController trainingCtrl = Get.find();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //TITULO
          Text('REPETICIONES', style: AppTheme.h4Bold,),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            height: 2,
            width: Get.width,  
            color: AppTheme.primary,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _OperationButton(
                simbol: '-',
                function: (){
                  int newValue = trainingCtrl.reps.value - 1;
                  if(newValue < 0 ){
                    newValue = 0;
                  }
                  trainingCtrl.reps.value = newValue;
                },
              ),

              Obx(()=> Container(
                  margin: const EdgeInsets.all(10),
                  width: 100,
                  child: TextField(
                    controller: TextEditingController(text: '${trainingCtrl.reps.value}'),
                    onChanged: (value) {
                      int newValue = int.tryParse(value) ?? 0;
                      if(newValue > 0){
                        trainingCtrl.reps.value = newValue;
                      }else{
                        trainingCtrl.reps.value = 0;
                      }
                    },
                    keyboardType: const TextInputType.numberWithOptions(decimal: true), // Acepta números con decimales
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')), // Permite hasta dos decimales
                    ],
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.primary)
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.primary)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.primary, width: 2)
                      ),
                    ),
                  ),
                ),
              ),

              _OperationButton(simbol: '+', function: (){trainingCtrl.reps.value = trainingCtrl.reps.value + 1;}),
            ],
          )
      ]),
    );
  }
}

class _OperationButton extends StatelessWidget {
  const _OperationButton({
    required this.function, required this.simbol,
  });

  final Function() function;
  final String simbol;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.primary
        ),
      onPressed: function,
      child: Text(simbol, style: AppTheme.h3Bold,)
      );
  }
}

class _SeriesList extends StatelessWidget {
  const _SeriesList({required this.training, required this.update});

  final Training training;
  final Function() update;

  @override
  Widget build(BuildContext context) {
    List<Serie> series = training.series;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: series.length,
      itemBuilder: (BuildContext context, int index) {

        Serie serie = series[index];

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: (){training.series.removeAt(index); update();}, 
                icon: const Icon(Icons.delete, color: Colors.white),
                style: IconButton.styleFrom(backgroundColor: Colors.red),
                ),
              Text('${index + 1}'),
              Text('${serie.weight} kgs'),
              Text('${serie.reps} reps'),
          ]),
        );
      },
    );
  }
}

