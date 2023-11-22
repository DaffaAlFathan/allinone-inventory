# Tugas 9
## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
Kita bisa melakukan pengambilan data JSON tanpa membuat model terlebih dahulu. Approach ini disebut sebagai "parsing" JSON. Jika data yang diambil cukup sederhana dan tidak memerlukan manipulasi yang rumit, maka tidak perlu membuat model. Tetapi ketika struktur data menjadi kompleks, membuat model dapat membantu dalam memahami dan memanipulasi data dengan lebih baik. Model dapat menyederhanakan proses pembacaan dan penggunaan data.

## Fungsi dari CookieRequest dan alasan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter
CookieRequest adalah kelas yang dapat digunakan dalam Flutter untuk mengelola permintaan HTTP dengan manipulasi cookie. Instance CookieRequest perlu dibagikan ke semua komponen dalam aplikasi Flutter karena cookies sering kali dibutuhkan untuk menjaga keadaan login, sesi, atau informasi pengguna lainnya di aplikasi web. Pengelolaan cookie memerlukan instance CookieRequest yang sama di seluruh aplikasi untuk memastikan konsistensi dan akses yang benar terhadap informasi yang disimpan.

## Mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter
Pertama, data JSON diambil melalui API atau dari penyimpanan lokal. Kemudian, Flutter menggunakan package seperti http untuk mengirim HTTP request dan mendapatkan JSON response dari server. Data JSON kemudian di-decode menggunakan library seperti dart:convert untuk mengubahnya menjadi objek Dart. Setelah data di-decode, nilai-nilai tersebut dapat digunakan dalam Flutter untuk mengisi widget, atau untuk meng-update state dan menampilkan informasi pada interface pengguna menggunakan widget.

## Mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter
1. Buat instance CookieRequest menggunakan pbp_django_auth di Flutter dan simpan dalam variabel request
```
final request = context.watch<CookieRequest>();
```

2. Pada halaman login.dart saat pengguna mengirimkan form, gunakan instance request untuk melakukan permintaan login ke server Django
```
final response = await request.login(
  "http://127.0.0.1:8000/auth/login/",
  {
    'username': username,
    'password': password
  }
);
```

3. Di server Django, proses permintaan login dalam views
```
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login as auth_login

@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Status login sukses.
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login sukses!"
                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali email atau kata sandi."
        }, status=401)
```

## Seluruh widget yang dipakai pada tugas ini dan fungsinya masing-masing
- TextField. Widget ini digunakan untuk menerima input teks dari pengguna, lebih tepatnya untuk menerima username dan password saat proses login dan registrasi.

- SizedBox. Widget ini digunakan untuk memberikan ruang tertentu atau pemisah antara elemen-elemen dalam antarmuka pengguna, lebih tepatnya untuk memberikan jarak atau ruang antara widget TextField username dan password.

- ElevatedButton. Widget ini menciptakan tombol dengan efek elevasi yang terjadi saat tombol ditekan, lebih tepatnya sebagai tombol submit pada proses login dan registrasi, memicu aksi yang sesuai ketika ditekan.

- TextButton. Widget ini menciptakan tombol berupa teks tanpa latar belakang, lebih tepatnya sebagai tombol registrasi, memberikan opsi alternatif selain login.

- ListView.builder. Widget ini digunakan untuk membuat daftar item yang dapat discroll, lebih tepatnya untuk menampilkan daftar item yang ada, seperti daftar hasil pencarian atau item dalam kategori tertentu.

- Text Widget. ini digunakan untuk menampilkan teks di antarmuka pengguna, lebih tepatnya untuk menampilkan teks detail saat item pada daftar item ditekan, memberikan informasi lebih lanjut tentang item tersebut.

## Implementasi
### Bagian Django
- Buat django-app bernama 'authentication'.

- Tambahkan 'authentication' ke INSTALLED_APPS.

- Install django-cors-headers.

- Tambahkan 'corsheaders' ke INSTALLED_APPS.

- Tambahkan middleware CorsMiddleware.

- Tambahkan variabel berikut.
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'

- Buat metode view untuk login pada authentication/views.py.

- Buat file urls.py di folder authentication untuk routing login.

- Tambahkan path('auth/', include('authentication.urls')) di main project urls.py.

- Buat metode view untuk logout pada authentication/views.py.

- Tambahkan path('logout/', logout, name='logout') di authentication/urls.py.

### Bagian Flutter
- Install package provider dan pbp_django_auth.

- Modifikasi root widget di main.dart menggunakan Provider.

- Buat file login.dart di lib\screens untuk halaman login.

- Integrasi dengan Django pada main.dart.

- Gunakan Quicktype untuk membuat model Dart dari JSON Django.

- Tambahkan package http untuk melakukan HTTP request.

- Fetch data dari Django untuk ditampilkan di aplikasi Flutter.

- Hubungkan halaman shoplist_form.dart dengan CookieRequest.

- Perbarui tombol tambah untuk mengirim data ke Django.

- Tambahkan fungsi logout di proyek Django dan implementasikan di aplikasi Flutter.

- Hubungkan fungsi logout dengan widget Inkwell di shop_card.dart.

# Tugas 8
## Perbedaan antara Navigator.push() dan Navigator.pushReplacement(), serta contoh mengenai penggunaan kedua metode tersebut yang tepat
Perbedaan kedua method tersebut terletak pada apa yang dilakukan kepada route yang berada pada atas stack. push() akan menambahkan route baru diatas route yang sudah ada pada atas stack sehingga user dapat kembali ke halaman sebelumnya, sedangkan pushReplacement() menggantikan route yang sudah ada pada atas stack dengan route baru tersebut sehingga user tidak dapat kembali ke halaman sebelumnya.
Penggunaan push():
```
Navigator.push(context, MaterialPageRoute(builder: (context) => PageName()))
```
Penggunaan pushReplacement():
```
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PageName()))
```

## Penjelasan masing-masing layout widget pada Flutter dan konteks penggunaannya
1. Container digunakan untuk mengelompokkan dan mengatur widget lainnya. Ini sering digunakan sebagai wadah untuk widget lain dan dapat dikonfigurasi dengan berbagai properti seperti padding, margin, dan decoration.

2. Row dan Column digunakan untuk mengatur widget secara horizontal (Row) atau vertikal (Column). Mereka cocok untuk menyusun widget secara berurutan atau sejajar.

3. ListView digunakan untuk menampilkan daftar widget secara berurutan, baik secara horizontal maupun vertikal. Cocok untuk daftar panjang atau dinamis.

4. GridView digunakan untuk menampilkan data dalam bentuk grid. Cocok untuk menampilkan koleksi item dalam baris dan kolom.

5. Stack memungkinkan penumpukan widget di atas satu sama lain. Berguna ketika programmer ingin menumpuk widget, seperti menempatkan gambar di atas teks.

6. Expanded digunakan untuk memberikan fleksibilitas dalam mendistribusikan ruang yang tersedia dalam sebuah layout. Ini digunakan di dalam widget.

7. SizedBox digunakan untuk menentukan ukuran widget dengan tepat. Ini dapat digunakan untuk memberikan batasan ukuran pada widget tertentu.

8. Card digunakan untuk membuat kartu material yang umumnya digunakan untuk menampilkan informasi terkait dalam kotak yang elegan.

9. Wrap digunakan ketika programmer ingin meletakkan widget secara horizontal atau vertikal, tetapi jika tidak cukup ruang, widget tersebut akan berpindah ke baris atau kolom berikutnya.

10. Align digunakan untuk mengatur posisi anak widget relatif terhadap widget induk. Ini berguna untuk mengatur posisi widget di dalam layout.

11. Flexible digunakan untuk memberikan widget proporsi fleksibel dari ruang yang tersedia. Ini sering digunakan bersama dengan `Row`, `Column`, atau `Flex`.

12. AspectRatio digunakan untuk memastikan bahwa widget memiliki rasio aspek tertentu (tinggi:lebar). Ini berguna untuk mempertahankan proporsi widget.

## Elemen input pada form yang dipakai pada tugas kali ini dan penjelasan
TextFormField digunakan untuk menerima input nama item, harga, dan deskripsi pada form untuk tambah item. Di dalamnya, ada validator untuk memastikan bahwa input tidak kosong dan sesuai dengan yang diminta, yaitu input harga harus berupa angka.

## Penerapan clean architecture pada aplikasi Flutter
Clean Architecture adalah pendekatan untuk mengorganisir dan merancang kode dalam aplikasi sehingga menghasilkan struktur yang bersih, terpisah, dan mudah diuji. Dalam konteks Flutter, penerapan Clean Architecture melibatkan pembagian kode ke dalam beberapa lapisan utama.

Penerapan clean architecture pada aplikasi Flutter merupakan prinsip seperti Separation of Concern pada MVP, MVT, atau MVCC.
Pembagiannya sebagai berikut:

Domain: Entities, Usecases, Repositories
App: View, Controller, Presenter, Extra
Data: Repositories, Models, Mappers, Extra
Device: Devices, Extra

## Implementasi
1. Tambahkan endDrawer pada Scaffold di dalam file menu.dart untuk membuat drawer pada aplikasi sehingga dapat mengakses berbagai macam halaman dengan mudah
```
return Scaffold(
  appBar: ...
  endDrawer: const LeftDrawer(),
  body: ...
```

2. Buat file baru dengan nama left_drawer.dart yang berisi kode dibawah ini
```
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
        ],
      ),
    );
  }
}
```

3. Buat halaman form untuk menambah item pada file shoplist_form.dart dengan StatefulWidget InventoryFormPage seperti kode dibawah ini
```
import 'package:flutter/material.dart';
// TODO: Impor drawer yang sudah dibuat sebelumnya
import 'package:allinone_inventory/widgets/left_drawer.dart';

class ShopFormPage extends StatefulWidget {
    const ShopFormPage({super.key});

    @override
    State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _price = 0;
    String _description = "";
    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Form Tambah Item',
              ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          // TODO: Tambahkan drawer yang sudah dibuat di sini
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Nama Item",
                            labelText: "Nama Item",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                                _name = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Nama tidak boleh kosong!";
                            }
                            return null;
                            },
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Harga",
                            labelText: "Harga",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                                _price = int.parse(value!);
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Harga tidak boleh kosong!";
                            }
                            if (int.tryParse(value) == null) {
                                return "Harga harus berupa angka!";
                            }
                            return null;
                            },
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Deskripsi",
                            labelText: "Deskripsi",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                                _description = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Deskripsi tidak boleh kosong!";
                            }
                            return null;
                            },
                          ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.indigo),
                            ),
                            onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Item berhasil tersimpan'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                            Text('Nama: $_name'),
                                            // TODO: Munculkan value-value lainnya
                                            Text('Harga: $_price'),
                                            Text('Deskripsi: $_description'),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                _formKey.currentState!.reset();
                            },
                            child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]
                )
            ),
          ),
        );
    }
}
```

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