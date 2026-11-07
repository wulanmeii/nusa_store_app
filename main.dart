import 'package:flutter/material.dart';

void main() {
  runApp(const NusaStoreApp());
}

class NusaStoreApp extends StatelessWidget {
  const NusaStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 2 - Wulandari Meilani Putri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPM Sesi 2 - Wulandari Meilani Putri (TI24C)'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Kartu Profil Mahasiswa (StatelessWidget)
            const StudentProfileCard(
              nama: 'Wulandari Meilani Putri',
              nim: '20240040016',
              prodi: 'Teknik Informatika (TI24C) - Universitas Nusa Putra',
            ),
            const SizedBox(height: 20),

            // 2. Banner Promo Sederhana (Stack & Positioned)
            const PromoBanner(),
            const SizedBox(height: 20),

            // 3. Kartu Produk Interaktif (StatefulWidget)
            const InteractiveProductCard(
              namaProduk: 'Modul Praktikum Mobile Programming M3',
              kategori: 'E-Learning & Buku',
              hargaSatuan: 150000,
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 1. KARTU PROFIL MAHASISWA (STATELESS WIDGET)
// ==========================================
class StudentProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodi;

  const StudentProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodi,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, size: 36, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text('NIM: $nim', style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 2),
                  Text(
                    prodi,
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                  const SizedBox(height: 8),
                  // 5 Ikon Bintang (Rating)
                  const Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      SizedBox(width: 4),
                      Text('5.0 (Active Student)', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. BANNER PROMO (STACK & POSITIONED)
// ==========================================
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 90,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.teal, Colors.tealAccent],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: const Row(
            children: [
              Icon(Icons.local_offer, color: Colors.white, size: 36),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Diskon Spesial Semester Ganjil!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Gunakan widget Flutter material 3 dengan optimal.',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -8,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'HOT PROMO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 3. KARTU PRODUK INTERAKTIF (STATEFUL WIDGET)
// ==========================================
class InteractiveProductCard extends StatefulWidget {
  final String namaProduk;
  final String kategori;
  final int hargaSatuan;

  const InteractiveProductCard({
    super.key,
    required this.namaProduk,
    required this.kategori,
    required this.hargaSatuan,
  });

  @override
  State<InteractiveProductCard> createState() => _InteractiveProductCardState();
}

class _InteractiveProductCardState extends State<InteractiveProductCard> {
  bool _isFavorite = false;
  int _likeCount = 24;
  int _quantity = 1;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      _likeCount += _isFavorite ? 1 : -1;
    });
  }

  void _updateQuantity(int delta) {
    setState(() {
      if (_quantity + delta >= 1) {
        _quantity += delta;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalHarga = _quantity * widget.hargaSatuan;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder Gambar Produk
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 64, color: Colors.teal),
              ),
            ),
            const SizedBox(height: 12),

            // Baris Kategori & Tombol Like (Favorite)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.kategori,
                    style: TextStyle(
                      color: Colors.teal.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      color: _isFavorite ? Colors.red : Colors.grey,
                      onPressed: _toggleFavorite,
                    ),
                    Text(
                      '$_likeCount',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Nama Produk & Harga
            Text(
              widget.namaProduk,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Harga Satuan: Rp ${widget.hargaSatuan}',
              style: const TextStyle(color: Colors.black54),
            ),
            const Divider(height: 24),

            // Pengatur Jumlah (Quantity Selector - dan +)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jumlah Beli:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    IconButton.filledTonal(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: () => _updateQuantity(-1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton.filledTonal(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: () => _updateQuantity(1),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Total Pembayaran & Tombol Tambah ke Keranjang (SnackBar)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                    Text(
                      'Rp $totalHarga',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Berhasil menambahkan $_quantity item ke keranjang!',
                        ),
                        backgroundColor: Colors.teal,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Beli'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}