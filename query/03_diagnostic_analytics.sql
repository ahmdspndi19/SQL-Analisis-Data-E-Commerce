-- =====================================================
-- Tahap 4: Analisis Diagnostik (Diagnostic Analytics)
-- Tahap ini mendiagnosis potensi kerugian operasional di sektor pembayaran dan logistik.
-- =====================================================

USE ecommerce;

-- 1. Rasio Pembatalan Pesanan per Metode Pembayaran
-- Mengevaluasi apakah ada metode pembayaran yang merugikan operasional karena sering batal.

-- INPUT:
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
5 rows in set (0.006 sec)

-- 2. Evaluasi Efisiensi Biaya Logistik Kurir
-- Melihat jasa ekspedisi mana yang memonopoli pengiriman dan berapa rata-rata biayanya.

-- INPUT:
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