import 'package:allinone_inventory/screens/list_product.dart';
import 'package:flutter/material.dart';
import 'package:allinone_inventory/screens/menu.dart';
import 'package:allinone_inventory/screens/shoplist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // TODO: Bagian drawer header
            decoration: BoxDecoration(
                color: Colors.indigo,
            ),
            child: Column(
                children: [
                    Text(
                        'AllInOne Inventory',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                        ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                        "Catat seluruh barangmu di sini!",
                        // TODO: Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                        ),
                    ),
                ],
            ),
          ),
          // TODO: Bagian routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                    ));
                },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Tambah Item'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShopFormPage(),
                    ));
                },
          ),
          // Kode ListTile Menu
          ListTile(
              leading: const Icon(Icons.shopping_basket),
              title: const Text('Daftar Item'),
              onTap: () {
                  // Route menu ke halaman produk
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductPage()),
                  );
              },
          ),
        ],
      ),
    );
  }
}