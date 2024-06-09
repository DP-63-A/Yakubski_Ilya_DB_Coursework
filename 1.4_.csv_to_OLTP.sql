CREATE TEMP TABLE tmp_users (
    Username VARCHAR(50),
    Password VARCHAR(255),
    Email VARCHAR(100),
    FullName VARCHAR(100),
    Address VARCHAR(255),
    Phone VARCHAR(20),
    Role VARCHAR(10)
);

COPY tmp_users FROM 'C:\\Program Files\\PostgreSQL\\16\\data\\course2\\users.csv' DELIMITER ',' CSV HEADER;

INSERT INTO users (Username, Password, Email, FullName, Address, Phone, Role)
SELECT tmp.Username, tmp.Password, tmp.Email, tmp.FullName, tmp.Address, tmp.Phone, tmp.Role
FROM tmp_users tmp
LEFT JOIN users u ON tmp.Username = u.Username
WHERE u.Username IS NULL;

DROP TABLE tmp_users;


CREATE TEMP TABLE tmp_category (
    CategoryName VARCHAR(50)
);

COPY tmp_category FROM 'C:\\Program Files\\PostgreSQL\\16\\data\\course2\\category.csv' DELIMITER ',' CSV HEADER;

INSERT INTO category (CategoryName)
SELECT tmp.CategoryName
FROM tmp_category tmp
LEFT JOIN category c ON tmp.CategoryName = c.CategoryName
WHERE c.CategoryName IS NULL;

DROP TABLE tmp_category;


CREATE TEMP TABLE tmp_subCategory (
    SubCategoryName VARCHAR(50),
    CategoryName VARCHAR(50)
);

COPY tmp_subCategory FROM 'C:\\Program Files\\PostgreSQL\\16\\data\\course2\\subCategory.csv' DELIMITER ',' CSV HEADER;

INSERT INTO subCategory (SubCategoryName, CategoryName)
SELECT tmp.SubCategoryName, tmp.CategoryName
FROM tmp_subCategory tmp
LEFT JOIN subCategory sc ON tmp.SubCategoryName = sc.SubCategoryName
WHERE sc.SubCategoryName IS NULL;

DROP TABLE tmp_subCategory;


CREATE TEMP TABLE tmp_producer (
    ProducerName VARCHAR(50)
);

COPY tmp_producer FROM 'C:\\Program Files\\PostgreSQL\\16\\data\\course2\\producers.csv' DELIMITER ',' CSV HEADER;

INSERT INTO producer (ProducerName)
SELECT tmp.ProducerName
FROM tmp_producer tmp
LEFT JOIN producer p ON tmp.ProducerName = p.ProducerName
WHERE p.ProducerName IS NULL;

DROP TABLE tmp_producer;


CREATE TEMP TABLE tmp_product (
    ProductName VARCHAR(100),
    SubCategoryName VARCHAR(50),
    ProducerName VARCHAR(50),
    Description TEXT,
    Price DECIMAL(10, 2),
    StockQuantity INT,
    IsAvailable BOOLEAN
);

COPY tmp_product FROM 'C:\\Program Files\\PostgreSQL\\16\\data\\course2\\products.csv' DELIMITER ',' CSV HEADER;

INSERT INTO product (ProductName, SubCategoryName, ProducerName, Description, Price, StockQuantity, IsAvailable)
SELECT tmp.ProductName, tmp.SubCategoryName, tmp.ProducerName, tmp.Description, tmp.Price, tmp.StockQuantity, tmp.IsAvailable
FROM tmp_product tmp
LEFT JOIN product p ON tmp.ProductName = p.ProductName
WHERE p.ProductName IS NULL;

DROP TABLE tmp_product;


CREATE TEMP TABLE tmp_orders (
    OrderID INT,
    Username VARCHAR(50),
    OrderDate TIMESTAMP,
    DeliveryDate TIMESTAMP,
    DeliveryAddress VARCHAR(255),
    PaymentMethod VARCHAR(20),
    OrderStatus VARCHAR(20)
);

COPY tmp_orders FROM 'C:\\Program Files\\PostgreSQL\\16\\data\\course2\\orders.csv' DELIMITER ',' CSV HEADER;

INSERT INTO orders (OrderID, Username, OrderDate, DeliveryDate, DeliveryAddress, PaymentMethod, OrderStatus)
SELECT tmp.OrderID, tmp.Username, tmp.OrderDate, tmp.DeliveryDate, tmp.DeliveryAddress, tmp.PaymentMethod, tmp.OrderStatus
FROM tmp_orders tmp
LEFT JOIN orders o ON tmp.OrderID = o.OrderID
WHERE o.OrderID IS NULL;

DROP TABLE tmp_orders;


CREATE TEMP TABLE tmp_orderItem (
    OrderItemID INT,
    OrderID INT,
    ProductName VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);

COPY tmp_orderItem FROM 'C:\\Program Files\\PostgreSQL\\16\\data\\course2\\orderItem.csv' DELIMITER ',' CSV HEADER;

INSERT INTO orderItem (OrderItemID, OrderID, ProductName, Quantity, UnitPrice)
SELECT tmp.OrderItemID, tmp.OrderID, tmp.ProductName, tmp.Quantity, tmp.UnitPrice
FROM tmp_orderItem tmp
LEFT JOIN orderItem oi ON tmp.OrderItemID = oi.OrderItemID
WHERE oi.OrderItemID IS NULL;

DROP TABLE tmp_orderItem;


CREATE TEMP TABLE tmp_wishlist (
    WishlistID INT,
    Username VARCHAR(50),
    ProductName VARCHAR(50)
);

COPY tmp_wishlist FROM 'C:\\Program Files\\PostgreSQL\\16\\data\\course2\\wishlist.csv' DELIMITER ',' CSV HEADER;

INSERT INTO wishlist (WishlistID, Username, ProductName)
SELECT tmp.WishlistID, tmp.Username, tmp.ProductName
FROM tmp_wishlist tmp
LEFT JOIN wishlist w ON tmp.WishlistID = w.WishlistID
WHERE w.WishlistID IS NULL;

DROP TABLE tmp_wishlist;