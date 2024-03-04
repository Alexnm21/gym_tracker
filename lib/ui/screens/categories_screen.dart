import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:gym_tracker/domain/controllers/category_controller.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/data/repositories/categories_repository.dart';
import 'package:gym_tracker/ui/widgets/widgets.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  CategoryController categoryCtrl = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Lógica para mostrar el formulario o realizar acciones cuando se presiona el ícono
                _showFormDialog();
              },)
        ],
      ),
      body: categoryCtrl.categories.isEmpty 
        ? const Center(child: Text('Añade aquí tus categorías.'),) 
        : ListView.builder(
          itemCount: categoryCtrl.categories.length,
          itemBuilder: (BuildContext context, int index) {
            return DeleteDismissible(
              deleteConfimText: '¿Eliminar la categoría ${categoryCtrl.categories[index].name} de forma permanente? \n \nEsto borrará todos los ejercicios de esta categoría.',
              onConfirm: () {
                CategoriesRepository().deleteCategory(index);
                setState(() {
                  categoryCtrl.categories.removeAt(index);
                });
              },
              child: GestureDetector(
                onTap: () {
                  _showFormDialog(category: categoryCtrl.categories[index], index: index);
                },
                child: CategoryContainer(category: categoryCtrl.categories[index])
                )
              );
        },
      ),
    );
  }

   void _showFormDialog({ExerciseCategory? category, int index=0}) {
    Color selectedColor = category != null ? Color(category.color) : Colors.black;
    String name = category != null ? category.name : '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text( category == null ? 'Nueva Categoría' : category.name),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Aquí puedes agregar tus campos de formulario
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  onChanged:(value) {
                    name = value;
                  },
                ),
                ListTile(
                  title: const Text('Color'),
                  trailing: const Icon(Icons.color_lens),
                  onTap: () {
                    _showColorPicker(context, (Color color) {
                      selectedColor = color;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // ACTUALIZAR CATEGORÍA
                if(category!= null){
                  CategoriesRepository().updateExerciseCategory(index, name, selectedColor.value);
                  setState(() {
                    categoryCtrl.categories[index].name = name;
                    categoryCtrl.categories[index].color = selectedColor.value;
                  });
                }else{
                  ExerciseCategory newCategory = ExerciseCategory(name: name, color: selectedColor.value);
                  CategoriesRepository().addCategory(newCategory);
                  setState(() {
                    categoryCtrl.categories.add(newCategory);
                  });
                }
                
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showColorPicker(BuildContext context, ValueChanged<Color> onColorChanged) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Colors.blue,
              onColorChanged: onColorChanged,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}