CREATE TABLE users (
    Username VARCHAR(50) PRIMARY KEY,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    FullName VARCHAR(100),
    Address VARCHAR(255),
    Phone VARCHAR(20),
    Role VARCHAR(10) CHECK (Role IN ('User', 'Admin'))
);

CREATE TABLE category (
    CategoryName VARCHAR(50) PRIMARY KEY
);

CREATE TABLE subCategory (
    SubCategoryName VARCHAR(50) PRIMARY KEY,
    CategoryName VARCHAR(50) REFERENCES category(CategoryName)
);

CREATE TABLE producer (
    ProducerName VARCHAR(50) PRIMARY KEY
);

CREATE TABLE product (
    ProductName VARCHAR(100) PRIMARY KEY,
    SubCategoryName VARCHAR(50) REFERENCES subCategory(SubCategoryName),
    ProducerName VARCHAR(50) REFERENCES producer(ProducerName),
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    IsAvailable BOOLEAN NOT NULL
);

CREATE TABLE orders (
    OrderID SERIAL PRIMARY KEY,
    Username VARCHAR(50) REFERENCES users(Username),
    OrderDate TIMESTAMP NOT NULL,
    DeliveryDate TIMESTAMP,
    DeliveryAddress VARCHAR(255),
    PaymentMethod VARCHAR(20),
    OrderStatus VARCHAR(20)
);

CREATE TABLE orderItem (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID INT REFERENCES orders(OrderID),
    ProductName VARCHAR(100) REFERENCES product(ProductName),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL
);

CREATE TABLE wishlist (
    WishlistID SERIAL PRIMARY KEY,
    Username VARCHAR(50) REFERENCES users(Username),
    ProductName VARCHAR(100) REFERENCES product(ProductName)
);