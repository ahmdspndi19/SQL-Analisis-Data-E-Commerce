# 🛍️ E-Commerce SQL Data Analysis

Proyek ini merupakan portofolio SQL yang mensimulasikan peran seorang **Data Analyst** dalam menganalisis data transaksi e-commerce menggunakan **MySQL**.

Analisis berfokus pada proses **data cleansing**, **exploratory data analysis (EDA)**, dan **business analytics** untuk menghasilkan *actionable insights* yang dapat mendukung pengambilan keputusan bisnis.

**Tech Stack:** MySQL • SQL • Data Cleansing • JOIN • Subquery • Aggregate Function • CASE WHEN

---

## 📊 Dataset

Dataset yang digunakan berasal dari **ngulik.data.com** dan terdiri dari lima tabel utama:

* **customers** — Informasi pelanggan
* **products** — Data produk
* **orders** — Informasi transaksi
* **order_items** — Detail item pada setiap transaksi
* **reviews** — Ulasan pelanggan

---

## 🎯 Business Objectives

Analisis dilakukan untuk menjawab beberapa pertanyaan bisnis berikut:

* Siapa pelanggan utama berdasarkan demografi?
* Produk apa yang memberikan pendapatan terbesar?
* Apakah terdapat permasalahan pada metode pembayaran?
* Kurir mana yang paling efisien dari sisi biaya pengiriman?
* Apakah terdapat masalah kualitas data yang memengaruhi hasil analisis?

---

# 💡 Business Insights

## 1️⃣ Product Category Data Quality

### Problem

Penulisan kategori produk tidak konsisten, misalnya:

* Jacket
* Jaket

Perbedaan tersebut menyebabkan kategori yang sama dihitung sebagai dua kategori berbeda sehingga menghasilkan laporan penjualan yang tidak akurat.

### Findings

* Sebelum dilakukan *data cleansing*, kategori **Dress** terlihat sebagai kategori dengan pendapatan tertinggi.
* Setelah standarisasi data, diketahui bahwa kategori **Jacket** merupakan penyumbang pendapatan terbesar dengan total sekitar **Rp156,4 juta**.

### Recommendation

Menerapkan **data validation** dan **standarisasi kategori produk** pada proses input agar kualitas data tetap konsisten.

---

## 2️⃣ Payment Method Analysis

### Findings

Metode pembayaran **OVO** memiliki tingkat pembatalan transaksi tertinggi, yaitu **13,10%**.

### Recommendation

Tim IT perlu melakukan investigasi terhadap proses pembayaran OVO, baik dari sisi integrasi API maupun pengalaman pengguna (UI/UX), untuk mengurangi potensi *checkout abandonment*.

---

## 3️⃣ Shipping Cost Analysis

### Findings

* **JNE** menangani jumlah pengiriman terbanyak.
* Namun, JNE juga memiliki rata-rata ongkos kirim tertinggi (**Rp24.763**).
* **SiCepat** dan **J&T** memiliki rata-rata ongkos kirim sekitar **Rp23.000**, sehingga lebih efisien.

### Recommendation

Mempertimbangkan **SiCepat** dan **J&T** sebagai mitra utama pada program **Gratis Ongkir** guna mengoptimalkan biaya logistik.

---

## 4️⃣ Customer Demographic Analysis

### Findings

Mayoritas pelanggan merupakan **perempuan berusia 25–34 tahun**.

Di sisi lain, tingginya penjualan kategori **Jacket** dan **Shirt** menunjukkan adanya peluang pasar yang besar pada segmen **pria usia produktif**.

### Recommendation

Mengembangkan strategi pemasaran yang lebih tersegmentasi untuk meningkatkan konversi pada kedua kelompok pelanggan tersebut.

---

# 📂 Repository Structure

```text
ecommerce-sql-data-analysis/
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
```

---

# 🚀 Getting Started

1. Clone repository ini.

2. Import file **database/ecommerce.sql** ke MySQL atau phpMyAdmin.

3. Jalankan query pada folder **queries/** secara berurutan:

```text
01_data_preparation_and_cleansing.sql
02_business_and_diagnostic_analytics.sql
```

4. Bandingkan hasil query dengan visualisasi pada folder **images/**.

---

# 🛠️ SQL Concepts Used

* Data Cleansing
* Data Validation
* INNER JOIN
* LEFT JOIN
* Subquery
* Common Table Expression (CTE)
* Aggregate Function
* GROUP BY & HAVING
* CASE WHEN
* Window Function (jika tersedia)
* Business Analytics

---

# 👨‍💻 Author

**Ahmad Supandi**

* GitHub: https://github.com/ahmdspndi19
* LinkedIn: https://www.linkedin.com/in/ahmadsupandi19/

---

⭐ Jika proyek ini bermanfaat, jangan lupa berikan **Star** pada repository ini.
