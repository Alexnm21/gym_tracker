import 'package:flutter/material.dart';
import 'package:gym_tracker/config/app_theme.dart';

class DeleteDismissible extends StatelessWidget {
  const DeleteDismissible({super.key, required this.deleteConfimText, required this.child, required this.onConfirm});
  
  final String deleteConfimText;
  final Widget child;
  final Function onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.red,
        child: const Row(
          children: [
            Icon(Icons.delete_outlined, color: Colors.white,),
          ],
        )
      ),
      confirmDismiss: (direction) async {
        return await mostrarDialogoDeConfirmacion(context, deleteConfimText);
      },
      onDismissed: (direction) => onConfirm(),
      child: child
      );
  }
}

Future<bool?> mostrarDialogoDeConfirmacion(BuildContext context, String mensaje) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsPadding: const EdgeInsets.all(10),
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('Confirmación'),
        content: Text(mensaje),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.clear),
            label: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(false); // No confirma el dismiss
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Confirmar'),
            onPressed: () {
              Navigator.of(context).pop(true); // Confirma el dismiss
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
          ),
        ],
      );
    },
  );
}