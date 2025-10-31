-- Active: 1759583043400@@localhost@5454@coffee_shop

-- fk 0

CREATE TABLE users(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    password VARCHAR NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    deleted_at TIMESTAMP
);

CREATE TABLE payment_methods(
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR NOT NULL,
    image VARCHAR(100) NOT NULL,
    no_va VARCHAR(50) NOT NULL
);

CREATE TABLE shippings (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) UNIQUE
);

CREATE TABLE sizes (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE products (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price NUMERIC NOT NULL DEFAULT 0,
    stock INT,
    created_at TIMESTAMP DEFAULT now(),
    deleted_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE categories(
    id int generated always as identity PRIMARY KEY,
    name VARCHAR(50) NOT NULL
)

CREATE TABLE promos (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    discount FLOAT NOT NULL,
    created_at TIMESTAMP DEFAULT now(),
    deleted_at TIMESTAMP
);

CREATE TABLE status (
    id int generated always as identity PRIMARY KEY,
    name VARCHAR(20)
);




-- fk 1
CREATE TABLE profiles (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT UNIQUE REFERENCES users(id),
    fullname VARCHAR(50),
    image VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR
);

CREATE TABLE product_images(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INT REFERENCES products(id),
    image VARCHAR(100)    
);




-- fk 2

CREATE TABLE product_categories (
    product_id INT,
    category_id INT
);

CREATE TABLE products_sizes_available (
    product_id BIGINT REFERENCES products(id),
    size_id INT REFERENCES sizes(id)
);

CREATE TABLE products_promos (
    product_id INT,
    promos_id INT
);




-- fk 3
CREATE TABLE orders(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT REFERENCES users(id),
    shipping_id INT NOT NULL,
    payment_method_id INT REFERENCES payment_methods(id),
    total_order NUMERIC NOT NULL,
    no_order VARCHAR(50),
    status_id INT REFERENCES status(id),
    promo_id INT REFERENCES promos(id),
    created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE orders_products (
    order_id BIGINT REFERENCES orders(id),
    product_id INT REFERENCES products(id),
    size_id INT NOT NULL,
    is_ice BOOLEAN NOT NULL DEFAULT true
);

