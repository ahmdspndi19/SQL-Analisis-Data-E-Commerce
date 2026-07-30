-- =====================================================
-- Project     : Portofolio SQL E-Commerce
-- File        : 02_business_analysis.sql
-- Author      : Ahmad Supandi
-- Description :
-- Analisis SQL berorientasi bisnis untuk data e-commerce.
-- =====================================================

USE ecommerce;

-- =====================================================
-- 1. Total Pendapatan
 
-- Berapa banyak pendapatan yang dihasilkan dari pesanan yang sudah selesai (Delivered)?
-- =====================================================

SELECT
    SUM(total_amount_idr) AS total_revenue
FROM orders
WHERE order_status = 'Delivered';


-- =====================================================
-- 2. 10 Pelanggan Teratas Berdasarkan Total Belanja
 
-- Siapa saja pelanggan teratas berdasarkan jumlah uang yang dihabiskan?
-- =====================================================

SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount_idr) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.name
ORDER BY total_spending DESC
LIMIT 10;


-- =====================================================
-- 3. 10 Produk Paling Laris
 
-- Produk mana saja yang memiliki volume penjualan tertinggi?
-- =====================================================

SELECT
    p.product_id,
    p.name,
    SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC
LIMIT 10;


-- =====================================================
-- 4. Pendapatan Berdasarkan Kategori Produk
 
-- Kategori produk mana yang menghasilkan pendapatan paling besar?
-- =====================================================

SELECT
    p.category,
    SUM(oi.subtotal_idr) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;


-- =====================================================
-- 5. Kota dengan Pendapatan Tertinggi
 
-- Kota mana saja yang memberikan kontribusi pendapatan tertinggi?
-- =====================================================

SELECT
    o.shipping_city,
    SUM(o.total_amount_idr) AS revenue
FROM orders o
WHERE o.order_status = 'Delivered'
GROUP BY o.shipping_city
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- 6. Rata-rata Penilaian Produk Berdasarkan Merek
 
-- Merek mana yang menerima penilaian (rating) pelanggan tertinggi?
-- =====================================================

SELECT
    p.brand,
    ROUND(AVG(r.rating),2) AS average_rating,
    COUNT(r.review_id) AS total_reviews
FROM products p
JOIN reviews r
ON p.product_id = r.product_id
GROUP BY p.brand
ORDER BY average_rating DESC;


-- =====================================================
-- 7. Produk dengan Penilaian Tinggi tetapi Penjualan Rendah
 
-- Produk apa yang memiliki penilaian sangat baik tetapi penjualannya rendah?
-- =====================================================

SELECT
    p.product_id,
    p.name,
    ROUND(AVG(r.rating),2) AS average_rating,
    COALESCE(SUM(oi.quantity),0) AS total_sold
FROM products p
LEFT JOIN reviews r
ON p.product_id = r.product_id
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
HAVING average_rating >= 4.5
ORDER BY total_sold ASC
LIMIT 10;


-- =====================================================
-- 8. Rata-rata Nilai Transaksi Pelanggan
 
-- Berapa rata-rata nilai transaksi untuk setiap pelanggan?
-- =====================================================

SELECT
    c.customer_id,
    c.name,
    ROUND(AVG(o.total_amount_idr),2) AS average_transaction
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.name
ORDER BY average_transaction DESC
LIMIT 10;

-- =====================================================
-- Akhir dari File
-- =====================================================