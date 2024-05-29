import 'package:logger/logger.dart';

class Logs {
  Logs._internal();//constructor privado

final Logger _logger = Logger();

  static Logs _instance = Logs._internal();
  static Logger get p => _instance._logger;
}

//Un singlenton para imprimir los logs