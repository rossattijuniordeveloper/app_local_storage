import 'dart:math';

import 'package:app_local_storage/controllers/numbers_storage_controller.dart';
import 'package:app_local_storage/models/number_model.dart';
import 'package:flutter/material.dart';

class NumbersController {
  final NumbersStorageController _storageController;

  NumbersController(this._storageController);
  final ValueNotifier<List<NumberModel>> numbers = ValueNotifier([]);

  void addRandomNumber() {
    numbers.value = [
      ...numbers.value,
      NumberModel(Random().nextInt(100)),
    ];
  }

  Future<void> saveNumbersList(BuildContext context) async {
    await _storageController.saveNumberList(numbers.value);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Números Aleatórios Salvos com Sucesso!',
          ),
        ),
      );
    }
  }

  Future<void> loadList() async {
    numbers.value = await _storageController.loadNumbersList();
  }

  Future<void> clearNumbersList(BuildContext context) async {
    await _storageController.clearNumberList();
    numbers.value = [];
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Numeros Aleatórios Limpos com SUCESSO !'),
        ),
      );
    }
  }
}
