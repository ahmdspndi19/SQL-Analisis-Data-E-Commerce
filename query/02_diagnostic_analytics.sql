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