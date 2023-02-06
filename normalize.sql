   

DROP TABLE products

CREATE TABLE products(
    id serial PRIMARY KEY,
    name varchar(300) CHECK (name != '') NOT NULL
);

CREATE TABLE manufacturers(
    id serial PRIMARY KEY,
    name varchar(300) CHECK (name != '') NOT NULL,
    address text NOT NULL,
    tel_number varchar(20) NOT NULL 
);

CREATE TABLE orders(
    id serial PRIMARY KEY,
    product_id int REFERENCES products(id),
    quantity_plan int NOT NULL,
    contract_number int NOT NULL,
    contract_date date NOT NULL,
    manufacturer_id int REFERENCES manufacturers(id),
    cost decimal(10,2) NOT NULL
);

CREATE TABLE shipments(
    id serial PRIMARY KEY,
    order_id int REFERENCES orders(id),
    shipment_date date NOT NULL
);

CREATE TABLE products_to_shipments(
    product_id REFERENCES products(id),
    shipment_id REFERENCES shipments(id),
    product_quantity int NOT NULL,
    PRIMARY KEY(product_id, shipment_id)
);