-- =====================================================
-- Project     : Portofolio SQL E-Commerce
-- File        : 01_data_preparation.sql
-- Author      : Ahmad Supandi
-- Description :
-- Eksplorasi dan validasi data awal sebelum analisis.
-- File ini memeriksa kualitas data tanpa memodifikasi database.
-- =====================================================

USE ecommerce;

-- =====================================================
-- 1. Total Data di Setiap Tabel
 
-- Berapa banyak data (records) yang ada di setiap tabel?
-- =====================================================

SELECT 'customers' AS table_name, COUNT(*) AS total_rows
FROM customers

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM order_items

UNION ALL

SELECT 'reviews', COUNT(*)
FROM reviews;

-- =====================================================
-- 2. Distribusi Status Pesanan
 
-- Bagaimana distribusi pesanan berdasarkan statusnya?
-- =====================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- =====================================================
-- 3. Distribusi Metode Pembayaran
 
-- Metode pembayaran apa yang paling sering digunakan?
-- =====================================================

SELECT
    payment_method,
    COUNT(*) AS total_transactions
FROM orders
GROUP BY payment_method
ORDER BY total_transactions DESC;

-- =====================================================
-- 4. Email Pelanggan Ganda (Duplikat)
 
-- Apakah ada email pelanggan yang ganda (duplikat)?
-- =====================================================

SELECT
    email,
    COUNT(*) AS total_duplicate
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

-- =====================================================
-- 5. Nilai yang Hilang (Missing Values)
 
-- Apakah ada nilai NULL pada kolom-kolom penting pelanggan?
-- =====================================================

SELECT
    SUM(email IS NULL) AS null_email,
    SUM(phone IS NULL) AS null_phone,
    SUM(city IS NULL) AS null_city,
    SUM(province IS NULL) AS null_province
FROM customers;

-- =====================================================
-- 6. Ulasan Produk Kosong
 
-- Apakah ada ulasan tanpa teks?
-- =====================================================

SELECT
    review_id,
    customer_id,
    product_id,
    rating
FROM reviews
WHERE review_text IS NULL
   OR TRIM(review_text) = '';

-- =====================================================
-- Akhir dari File
-- =====================================================