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