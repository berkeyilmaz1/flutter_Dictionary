import 'package:dictionary_app/feature/home/viewmodel/home_view_model.dart';
import 'package:dictionary_app/product/utility/components/card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeviewModel {
  final String _appName = "D I C T I O N A R Y";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appName),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _textField(context, hintText),
                _searchButton(),
              ],
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _listViewbldr(),
            )
          ],
        ),
      ),
    );
  }

  ListView _listViewbldr() {
    return ListView.builder(
                    itemCount: items?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return MyCard(model: items![index]);
                    },
                  );
  }

  SizedBox _textField(BuildContext context, String hintText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  ElevatedButton _searchButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          word = controller?.text ?? "";
          fetchItems();
        });
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.blue),
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}
