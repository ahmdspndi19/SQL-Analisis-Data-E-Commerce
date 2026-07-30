-- =====================================================
-- Project     : Portofolio SQL E-Commerce
-- File        : 01_data_preparation_and_cleansing.sql
-- Author      : Ahmad Supandi
-- Description : Eksplorasi, identifikasi masalah, dan pembersihan data awal.
-- =====================================================

USE ecommerce;

-- 1. Identifikasi Redundansi Akun (Duplikat Email)
-- Mencari pelanggan yang mendaftar lebih dari satu kali dengan email yang sama.
SELECT 
    email,
    MIN(customer_id) AS main_customer_id,
    MIN(registration_date) AS first_joined_date,
    COUNT(customer_id) AS total_duplicate_accounts
FROM customers
GROUP BY email
HAVING COUNT(customer_id) > 1;

-- OUTPUT:
+----------------------------+------------------+-------------------+--------------------------+
| email                      | main_customer_id | first_joined_date | total_duplicate_accounts |
+----------------------------+------------------+-------------------+--------------------------+
| baguspermata248@gmail.com  | CUST0045         | 2022-04-26        |                        2 |
| rinalestari281@outlook.com | CUST0700         | 2023-03-31        |                        2 |
| wulansuryadi729@yahoo.com  | CUST0188         | 2021-06-04        |                        2 |
+----------------------------+------------------+-------------------+--------------------------+
3 rows in set (0.006 sec)

-- 2. Preview Standarisasi Kategori Produk 
-- Memperbaiki inkonsistensi input dari admin tanpa mengubah tabel asli.
SELECT 
    product_id,
    name,
    category AS original_category,
    CASE 
        WHEN LOWER(TRIM(category)) IN ('t-shirt', 'kaos') THEN 'T-Shirt'
        WHEN LOWER(TRIM(category)) IN ('shirt', 'kemeja') THEN 'Shirt'
        WHEN LOWER(TRIM(category)) IN ('pants', 'celana') THEN 'Pants'
        WHEN LOWER(TRIM(category)) IN ('jacket', 'jaket') THEN 'Jacket'
        WHEN LOWER(TRIM(category)) IN ('accessories', 'aksesoris') THEN 'Accessories'
        WHEN LOWER(TRIM(category)) = 'dress' THEN 'Dress'
        ELSE 'Others' 
    END AS cleaned_category
FROM products
LIMIT 10;

-- OUTPUT:
+------------+--------------------------------+-------------------+------------------+
| product_id | name                           | original_category | cleaned_category |
+------------+--------------------------------+-------------------+------------------+
| PRD001     | Dress Bodycon Pesona Indo      | dress             | Dress            |
| PRD002     | Kaos Oversize BajuKita         | T-Shirt           | T-Shirt          |
| PRD003     | Dress Maxi Polos Senja Wear    | dress             | Dress            |
| PRD004     | Ikat Pinggang Kulit Cendana Co | Accessories       | Accessories      |
| PRD005     | Dress Bodycon Senja Wear       | dress             | Dress            |
| PRD006     | Celana Kulot Tropika Style     | Pants             | Pants            |
| PRD007     | T-Shirt Graphic Cendana Co     | Kaos              | T-Shirt          |
| PRD008     | Jaket Bomber Senja Wear        | Jaket             | Jacket           |
| PRD009     | Kaos Striped Riang Apparel     | T-Shirt           | T-Shirt          |
| PRD010     | Kaos Raglan BajuKita           | kaos              | T-Shirt          |
+------------+--------------------------------+-------------------+------------------+
10 rows in set (0.001 sec)

-- 3. Memfilter Ulasan Tidak Valid
-- Memisahkan ulasan yang kosong agar tabel ulasan siap dianalisis sentimennya.
SELECT 
    review_id,
    product_id,
    rating,
    review_text
FROM reviews
WHERE review_text IS NOT NULL 
  AND TRIM(review_text) != '';

-- OUTPUT:
+-----------+------------+--------+------------------------------------------------+
| review_id | product_id | rating | review_text                                    |
+-----------+------------+--------+------------------------------------------------+
| REV00001  | PRD269     |      3 | Bahan premium, jahitan kuat.                   |
| REV00002  | PRD105     |      2 | Bagus banget, packaging juga aman.             |
| REV00003  | PRD053     |      5 | Modelnya keren, fit di badan.                  |
| REV00004  | PRD265     |      4 | Kualitas oke untuk harga segini.               |
| REV00005  | PRD252     |      3 | Produk sampai dengan cepat, sesuai ekspektasi. |
| REV00006  | PRD028     |      5 | Mantap, langganan terus dari sini.             |
| REV00007  | PRD096     |      5 | Sesuai deskripsi, akan beli lagi.              |
| REV00008  | PRD023     |      5 | Wah ini sih murah meriah tapi berkualitas.     |
| REV00009  | PRD181     |      3 | Produknya bagus tapi pengiriman lama.          |
| REV00010  | PRD072     |      3 | Modelnya keren, fit di badan.                  |
+-----------+------------+--------+------------------------------------------------+
10 rows in set (0.000 sec)
