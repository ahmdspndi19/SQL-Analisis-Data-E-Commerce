-- =====================================================
-- Project     : Portofolio SQL E-Commerce
-- File        : 02_business_and_diagnostic_analytics.sql
-- Author      : Ahmad Supandi
-- Description : Analisis bisnis deskriptif dan diagnostik operasional.
-- =====================================================

USE ecommerce;

-- 1. Memetakan Demografi Pelanggan Utama
-- Mengidentifikasi kelompok usia dan jenis kelamin yang paling banyak berbelanja.
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
8 rows in set (0.001 sec)

-- 2. Peringkat Pendapatan per Kategori (True Revenue)
-- Menggunakan Subquery agar data dikelompokkan berdasarkan kategori yang SUDAH dibersihkan.
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
6 rows in set (0.019 sec)

-- 3. Rasio Pembatalan Pesanan per Metode Pembayaran
-- Mendiagnosis kemungkinan masalah integrasi pada metode pembayaran tertentu (contoh: OVO).
SELECT 
    payment_method,
    COUNT(order_id) AS total_orders,
    SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(
        (SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(order_id)) * 100, 
    2) AS cancellation_rate_percentage
FROM orders
GROUP BY payment_method
ORDER BY cancellation_rate_percentage DESC;

-- OUTPUT:
+----------------+--------------+------------------+------------------------------+
| payment_method | total_orders | cancelled_orders | cancellation_rate_percentage |
+----------------+--------------+------------------+------------------------------+
| OVO            |          588 |               77 |                        13.10 |
| Kartu Kredit   |          445 |               53 |                        11.91 |
| Transfer Bank  |          907 |               93 |                        10.25 |
| GoPay          |          754 |               76 |                        10.08 |
| QRIS           |          306 |               29 |                         9.48 |
+----------------+--------------+------------------+------------------------------+
5 rows in set (0.105 sec)

-- 4. Evaluasi Efisiensi Biaya Logistik Kurir
-- Melihat dominasi pengiriman dan rata-rata ongkos kirim setiap ekspedisi.
SELECT 
    courier,
    COUNT(order_id) AS total_deliveries,
    ROUND(AVG(shipping_cost_idr), 2) AS average_shipping_cost
FROM orders
WHERE order_status = 'Delivered'
GROUP BY courier
ORDER BY total_deliveries DESC;

-- OUTPUT:
+---------------+------------------+-----------------------+
| courier       | total_deliveries | average_shipping_cost |
+---------------+------------------+-----------------------+
| JNE           |              510 |              24763.32 |
| SiCepat       |              497 |              22911.24 |
| J&T           |              485 |              23167.96 |
| Anteraja      |              181 |              24400.91 |
| Pos Indonesia |              103 |              22349.94 |
+---------------+------------------+-----------------------+
5 rows in set (0.003 sec)
