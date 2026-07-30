-- =====================================================
-- Tahap 2: Pembersihan Data (Data Cleansing)
-- Langkah pertama sebelum analisis adalah memastikan integritas data. Kita menemukan dan memperbaiki tiga masalah utama.
-- =====================================================

USE ecommerce;

-- 1. Memetakan Demografi Pelanggan
--    Siapa pelanggan utama kita berdasarkan usia dan jenis kelamin?

-- INPUT:
SELECT 
    gender, 
    age_group, 
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY 
    gender, 
    age_group
ORDER BY 
    total_customers DESC;

-- OUTPUT:
+--------+-----------+-----------------+
| gender | age_group | total_customers |
+--------+-----------+-----------------+
| Female | 25-34     |             189 |
| Male   | 25-34     |             143 |
| Female | 35-44     |             112 |
| Female | 18-24     |             108 |
| Male   | 18-24     |              92 |
| Male   | 35-44     |              81 |
| Female | 45+       |              42 |
| Male   | 45+       |              33 |
+--------+-----------+-----------------+
8 rows in set (0.002 sec)

-- 2. Mengidentifikasi Sumber Pendapatan Terbesar
--    Kategori produk apa yang menjadi tulang punggung pemasukan?

-- INPUT:
SELECT 
    cleaned_products.cleaned_category,
    COUNT(oi.item_id) AS total_items_sold,
    SUM(oi.subtotal_idr) AS total_revenue
FROM (
    SELECT 
        product_id,
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
) AS cleaned_products
JOIN order_items oi ON cleaned_products.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY cleaned_products.cleaned_category
ORDER BY total_revenue DESC;    

-- OUTPUT:
+------------------+------------------+---------------+
| cleaned_category | total_items_sold | total_revenue |
+------------------+------------------+---------------+
| Jacket           |              551 |     156400000 |
| Dress            |              474 |     154307000 |
| Shirt            |              444 |     150127000 |
| Pants            |              480 |     149269000 |
| Accessories      |              519 |     149064000 |
| T-Shirt          |              479 |     140770000 |
+------------------+------------------+---------------+
6 rows in set (0.016 sec)

