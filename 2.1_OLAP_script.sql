CREATE TABLE Dim_Customer (
    CustomerKey SERIAL PRIMARY KEY,
    Username VARCHAR(50),
    FullName VARCHAR(100),
    Address VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Role VARCHAR(10),
    StartDate DATE,
    EndDate DATE,
    IsCurrent BOOLEAN
);

CREATE TABLE Dim_Product (
    ProductKey SERIAL PRIMARY KEY,
    ProductName VARCHAR(100),
    SubCategoryName VARCHAR(50),
    ProducerName VARCHAR(50),
    Price DECIMAL(10, 2)
);

CREATE TABLE Dim_Time (
    TimeKey SERIAL PRIMARY KEY,
    OrderDate TIMESTAMP,
    DeliveryDate TIMESTAMP,
    Year INT,
    Month INT,
    Day INT
);


CREATE TABLE Fact_Order (
    OrderID SERIAL PRIMARY KEY,
    CustomerKey INT,
    ProductKey INT,
    TimeKey INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    FOREIGN KEY (CustomerKey) REFERENCES Dim_Customer(CustomerKey),
    FOREIGN KEY (ProductKey) REFERENCES Dim_Product(ProductKey),
    FOREIGN KEY (TimeKey) REFERENCES Dim_Time(TimeKey)
);

CREATE TABLE Fact_Wishlist (
    WishlistID SERIAL PRIMARY KEY,
    CustomerKey INT,
    ProductKey INT,
    FOREIGN KEY (CustomerKey) REFERENCES Dim_Customer(CustomerKey),
    FOREIGN KEY (ProductKey) REFERENCES Dim_Product(ProductKey)
);