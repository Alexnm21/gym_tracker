import 'package:flutter/material.dart';

bool isSameDay(DateTime date1, DateTime date2){
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
}

String getWeekDay(DateTime date) {
  switch (date.weekday) {
    case 1:
      return "Lunes";
    case 2:
      return "Martes";
    case 3:
      return "Miércoles";
    case 4:
      return "Jueves";
    case 5:
      return "Viernes";
    case 6:
      return "Sábado";
    case 7:
      return "Domingo";
    default:
      return "";
  }
}

String getMonth(DateTime date) {
  switch (date.month) {
    case 1:
      return "Enero";
    case 2:
      return "Febrero";
    case 3:
      return "Marzo";
    case 4:
      return "Abril";
    case 5:
      return "Mayo";
    case 6:
      return "Junio";
    case 7:
      return "Julio";
    case 8:
      return "Agosto";
    case 9:
      return "Septiembre";
    case 10:
      return "Octubre";
    case 11:
      return "Noviembre";
    case 12:
      return "Diciembre";
    default:
      return "";
  }
}


String dateString(DateTime date){
  return '${date.day} de ${getMonth(date)} del ${date.year}';
}

Color darken(Color color, [double amount = 0.07]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .07]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

LinearGradient createGradientFromColor(Color color) {
  return LinearGradient(
    colors: [
      darken(color),
      lighten(color),

    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}


List<Shadow> textShadow(){
  return [const Shadow(color: Colors.grey, offset: Offset(0.0, 0.0), blurRadius: 3.0)];
}

BoxShadow boxShadow(){
  return BoxShadow(
    color: Colors.black.withOpacity(0.2), // Color de la sombra con opacidad
    spreadRadius: 5.0, // Extensión de la sombra
    blurRadius: 10.0, // Radio de desenfoque de la sombra
    offset: const Offset(0, 2), // Desplazamiento de la sombra (x, y)
  );
}
