-- =====================================================
-- Project     : Portofolio SQL E-Commerce
-- File        : 03_advanced_sql.sql
-- Author      : Ahmad Supandi
-- Description :
-- Teknik SQL tingkat lanjut menggunakan CTE, Subquery,
-- dan Window Functions.
-- =====================================================

USE ecommerce;

-- =====================================================
-- 1. Peringkat Penjualan Produk
 
-- Beri peringkat pada produk berdasarkan total kuantitas yang terjual.
-- =====================================================

SELECT
    p.product_id,
    p.name,
    SUM(oi.quantity) AS total_sold,
    RANK() OVER (
        ORDER BY SUM(oi.quantity) DESC
    ) AS product_rank
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name;


-- =====================================================
-- 2. Total Pendapatan Berjalan (Running Total)
 
-- Hitung pendapatan kumulatif dari waktu ke waktu.
-- =====================================================

SELECT
    order_date,
    SUM(total_amount_idr) AS daily_revenue,
    SUM(SUM(total_amount_idr))
        OVER(
            ORDER BY order_date
        ) AS running_total
FROM orders
WHERE order_status = 'Delivered'
GROUP BY order_date;


-- =====================================================
-- 3. Pelanggan Berulang (CTE)
 
-- Temukan pelanggan yang telah melakukan lebih dari satu pesanan.
-- =====================================================

WITH customer_orders AS
(
    SELECT
        customer_id,
        COUNT(*) AS total_orders
    FROM orders
    WHERE order_status='Delivered'
    GROUP BY customer_id
)

SELECT
    c.customer_id,
    c.name,
    customer_orders.total_orders
FROM customer_orders
JOIN customers c
ON customer_orders.customer_id=c.customer_id
WHERE customer_orders.total_orders>1
ORDER BY customer_orders.total_orders DESC;


-- =====================================================
-- 4. Produk di Atas Rata-rata Penjualan (Subquery)
 
-- Produk mana saja yang terjual di atas rata-rata volume penjualan?
-- =====================================================

SELECT
    p.product_id,
    p.name,
    SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.product_id,p.name
HAVING SUM(oi.quantity)>
(
    SELECT AVG(total_quantity)
    FROM
    (
        SELECT
            SUM(quantity) AS total_quantity
        FROM order_items
        GROUP BY product_id
    ) AS avg_sales
);


-- =====================================================
-- 5. Pelanggan Teratas di Setiap Kota
 
-- Identifikasi pelanggan dengan pengeluaran tertinggi di setiap kota.
-- =====================================================

WITH customer_spending AS
(
    SELECT
        c.city,
        c.customer_id,
        c.name,
        SUM(o.total_amount_idr) AS total_spending
    FROM customers c
    JOIN orders o
    ON c.customer_id=o.customer_id
    WHERE o.order_status='Delivered'
    GROUP BY
        c.city,
        c.customer_id,
        c.name
)

SELECT *
FROM
(
    SELECT
        *,
        ROW_NUMBER() OVER
        (
            PARTITION BY city
            ORDER BY total_spending DESC
        ) AS rn
    FROM customer_spending
) ranked
WHERE rn=1;

-- =====================================================
-- Akhir dari File
-- =====================================================