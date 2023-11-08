# Tugas 7
## Perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter
Stateless widget adalah widget yang tidak memiliki perubahan internal atau mutable state. Stateless widget bersifat statis dan tidak dapat mengubah tampilan atau data mereka sendiri setelah dibangun. Stateless widget ideal untuk bagian tampilan yang tidak bergantung pada perubahan data selama masa hidup widget.

Stateful widget adalah widget yang memiliki perubahan internal atau mutable state. Stateful widget dapat mengubah tampilan atau data mereka sendiri setelah dibangun. Stateful widget berguna ketika programmer perlu merender widget yang bergantung pada data yang berubah seiring waktu. Misalnya, daftar item yang dapat digulir atau formulir yang harus mengelola input pengguna.

## Widget yang digunakan untuk menyelesaikan tugas ini dan fungsinya masing-masing
- MaterialApp berfungsi sebagai akar dari aplikasi Flutter yang dirancang menggunakan desain Material Design dari Google. MaterialApp menyediakan berbagai pengaturan dan konfigurasi untuk aplikasi, seperti tema, rute, dan banyak lagi

- Material berfungsi untuk memberi warna pada latar belakang kartu

- MyHomePage berfungsi widget halaman utama aplikasi

- Text berfungsi untuk menampilkan teks

- Column berfungsi untuk mengatur widget dalam kolom vertikal

- AppBar berfungsi untuk menampilkan bilah atas di aplikasi

- Scaffold berfungsi untuk membuat tata letak dasar aplikasi

- GridView untuk menampilkan elemen dalam tata letak grid

- GridView.count untuk membuat grid layout dengan jumlah kolom yang didefinikan.

- Padding untuk menambah jarak di sekitar widget anaknya

- SnackBar untuk menampilkan pesan sementara ketika kartu diklik

- Container untuk mengatur tata letak dan dekorasi widget anak di dalamnya. Programmer dapat mengatur properti-properti seperti warna latar 
belakang, padding, margin, dan sebagainya menggunakan widget Container

- InkWell untuk memberi efek respons ketika kartu diklik. Biasanya digunakan di sekitar widget lain, seperti Text, Image, atau Container

- Center adalah widget yang digunakan untuk mengatur widget anaknya agar berada di tengah dari tata letak (layout) orang tua, baik secara horizontal maupun vertikal

- Icon untuk menampilkan simbol dalam antarmuka pengguna

- ItemCard untuk menampilkan setiap elemen dalam grid sebagai kartu

- SingleChildScrollView untuk membuat area scrollable vertikal yang hanya memiliki satu widget anak
## Implementasi Checklist

1. Generate proyek Flutter baru dengan nama allinone_inventory.
```
flutter create allinone_inventory
```

2. Buka direktori allinone_inventory/lib, tambahkan file menu.dart dan isi dengan kode berikut.
```
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);
      final List<ShopItem> items = [
      ShopItem("Lihat Item", Colors.grey.shade800, Icons.checklist),
      ShopItem("Tambah Item", Colors.grey.shade600, Icons.add_shopping_cart),
      ShopItem("Logout", Colors.grey.shade400, Icons.logout),
    ];

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AllInOne Inventory',
        ),
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'All-In-One Inventory', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  // Iterasi untuk setiap item
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
    }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
}

class ShopItem {
  final String name;
  final Color color;
  final IconData icon;

  ShopItem(this.name, this.color, this.icon);
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

3. By default seharusnya juga ada file bernama main.dart di allinone_inventory/lib. Isi dengan kode berikut.
```
import 'package:flutter/material.dart';
import 'package:allinone_inventory/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ), // ThemeData
      home: MyHomePage(),
    ); // MaterialApp
  }
}
```

4. Tambahkan atribut color di ShopItem agar tiap button dapat memiliki warna berbeda.
```
class ShopItem {
  final String name;
  final Color color;
  final IconData icon;

  ShopItem(this.name, this.color, this.icon);
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      ...
```

```
class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);
      final List<ShopItem> items = [
      ShopItem("Lihat Item", Colors.grey.shade800, Icons.checklist),
      ShopItem("Tambah Item", Colors.grey.shade600, Icons.add_shopping_cart),
      ShopItem("Logout", Colors.grey.shade400, Icons.logout),
    ];
    ...
```