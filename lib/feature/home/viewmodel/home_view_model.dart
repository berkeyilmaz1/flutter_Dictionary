import 'package:dictionary_app/feature/home/view/home_view.dart';
import 'package:dictionary_app/product/model/model.dart';
import 'package:dictionary_app/product/service/dictionary_service.dart';
import 'package:flutter/material.dart';

abstract class HomeviewModel extends State<HomeView> {
  List<DictionaryModel>? items;
  bool isLoading = false;
  late DictionaryService _dictionaryService;

  TextEditingController? controller;
  final String hintText = "Kelime giriniz...";
  String word = "hello";
  
  @override
  void initState() {
    super.initState();
    _dictionaryService = DictionaryService(word);
    fetchItems();
    controller = TextEditingController();
  }

  Future<void> fetchItems() async {
    changeLoading();
    _dictionaryService = DictionaryService(word);
    items = await _dictionaryService.fetchItems();
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
