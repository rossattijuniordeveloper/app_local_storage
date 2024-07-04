import 'package:app_local_storage/controllers/numbers_controller.dart';
import 'package:app_local_storage/controllers/numbers_storage_controller.dart';
import 'package:app_local_storage/models/number_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final numbersCtrl = NumbersController(NumbersStorageController());

  @override
  void initState() {
    numbersCtrl.loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder(
                valueListenable: numbersCtrl.numbers,
                builder: (_, List<NumberModel> numbersList, __) => Expanded(
                  child: numbersList.isEmpty
                      ? const Center(
                          child: Text(
                            'Comece Gerando um número!',
                            style: TextStyle(fontSize: 24),
                          ),
                        )
                      : ListView(
                          children: numbersList
                              .map(
                                (numberModel) => Text(
                                  numberModel.number.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                              .toList(),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: numbersCtrl.addRandomNumber,
                      child: const Text('Gerar Número!'),
                    ),
                    ElevatedButton(
                      onPressed: () => numbersCtrl.clearNumbersList(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[300],
                      ),
                      child: const Text('Limpar Lista!'),
                    ),
                    ElevatedButton(
                      onPressed: () => numbersCtrl.saveNumbersList(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                      ),
                      child: const Text(
                        'Salvar',
                      ),
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
