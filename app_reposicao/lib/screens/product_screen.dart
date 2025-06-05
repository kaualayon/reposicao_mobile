import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  List<Map<String, dynamic>> products = [];

  void loadProducts() async {
    final data = await ApiService.getProducts();
    setState(() => products = data);
  }

  void addProduct() async {
    final success = await ApiService.addProduct(
      nameController.text,
      descController.text,
    );
    if (success) {
      nameController.clear();
      descController.clear();
      loadProducts();
    }
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Produtos")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Nome")),
            TextField(controller: descController, decoration: InputDecoration(labelText: "Descrição")),
            ElevatedButton(onPressed: addProduct, child: Text("Adicionar Produto")),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (_, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product['name']),
                    subtitle: Text(product['description']),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
