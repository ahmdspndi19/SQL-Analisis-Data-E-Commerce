ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

ALTER TABLE products
ADD PRIMARY KEY (product_id);

ALTER TABLE orders
ADD PRIMARY KEY (order_id);

ALTER TABLE order_items
ADD PRIMARY KEY (item_id);

ALTER TABLE reviews
ADD PRIMARY KEY (review_id);