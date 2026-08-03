# 🛍️ E-Commerce SQL Data Analysis

Proyek ini merupakan portofolio SQL yang mensimulasikan peran seorang **Data Analyst** dalam menganalisis database e-commerce. Fokus utama proyek ini adalah melakukan **data cleansing** dan menghasilkan **actionable insights** menggunakan fundamental SQL, seperti **Subquery**, **JOIN**, **Aggregate Function**, dan **CASE WHEN** pada **MySQL**.

---

## 📊 Sumber Data

Dataset yang digunakan dalam proyek ini bersumber dari **[ngulik.data.com/](https://ngulikdata.com/datasets/gayanara)**.

---

## 🎯 Tujuan Analisis

Menjawab pertanyaan bisnis utama terkait:

* Demografi pelanggan
* Performa produk yang sesungguhnya
* Kelancaran proses pembayaran
* Efisiensi biaya pengiriman

---

## 💡 Temuan Bisnis Kritis (Insights)

### 📌 1. Ilusi Kategori Produk (Data Quality)

**Permasalahan**

Input kategori produk tidak konsisten, misalnya **"Jaket"** dan **"Jacket"**, sehingga menghasilkan analisis yang menyesatkan.

**Temuan**

Sebelum dilakukan *data cleansing*, kategori **Dress** terlihat sebagai produk terlaris. Setelah data dibersihkan, diketahui bahwa **Jacket** merupakan kategori dengan pendapatan tertinggi sebesar **Rp156,4 juta**.

**Rekomendasi**

Menstandarkan penulisan kategori produk agar hasil analisis lebih akurat.

---

### 💳 2. Anomali Pembayaran

**Temuan**

Metode pembayaran **OVO** memiliki tingkat pembatalan transaksi tertinggi, yaitu **13,10%**.

**Rekomendasi**

Tim IT disarankan menginvestigasi alur API atau UI pada halaman checkout untuk mengurangi potensi *drop-off* pelanggan.

---

### 🚚 3. Efisiensi Logistik

**Temuan**

* **JNE** mendominasi jumlah pengiriman, namun memiliki rata-rata ongkos kirim tertinggi (**Rp24.763**).
* **SiCepat** dan **J&T** memiliki rata-rata ongkos kirim sekitar **Rp23.000**, sehingga lebih efisien.

**Rekomendasi**

Mempertimbangkan **SiCepat** dan **J&T** sebagai opsi utama dalam program **Gratis Ongkir**.

---

### 👥 4. Target Pasar

**Temuan**

Mayoritas pelanggan merupakan **perempuan berusia 25–34 tahun**. Namun, tingginya penjualan kategori **Jacket** dan **Shirt** menunjukkan adanya potensi pasar pria milenial dengan daya beli yang tinggi.

**Rekomendasi**

Mengembangkan strategi pemasaran yang lebih spesifik untuk menjangkau segmen pelanggan tersebut.

---

## 📂 Struktur Repository

```text
E-Commerce SQL-Data Analysis
/
│
├── README.md
│
├── dataset/
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   ├── order_items.csv
│   └── reviews.csv
│
├── database/
│   └── ecommerce.sql
│
├── queries/
│   ├── 01_data_preparation_and_cleansing.sql
│   └── 02_business_and_diagnostic_analytics.sql
│
└── images/
    ├── data_cleansing.png
    ├── product_analysis.png
    ├── payment_analysis.png
    ├── shipping_analysis.png
    └── customer_analysis.png
