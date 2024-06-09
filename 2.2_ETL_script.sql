SELECT
    Username,
    FullName,
    Address,
    Phone,
    Email,
    Role,
    CURRENT_DATE AS StartDate,
    CAST(NULL AS DATE) AS EndDate,
    TRUE AS IsCurrent
INTO
    Dim_Customer_Load
FROM
    users;

INSERT INTO Dim_Customer (Username, FullName, Address, Phone, Email, Role, StartDate, EndDate, IsCurrent)
SELECT
    Username,
    FullName,
    Address,
    Phone,
    Email,
    Role,
    StartDate,
    EndDate,
    IsCurrent
FROM
    Dim_Customer_Load;
	

SELECT
    ProductName,
    SubCategoryName,
    ProducerName,
    Price
INTO
    Dim_Product_Load
FROM
    product;

INSERT INTO Dim_Product (ProductName, SubCategoryName, ProducerName, Price)
SELECT
    ProductName,
    SubCategoryName,
    ProducerName,
    Price
FROM
    Dim_Product_Load;


SELECT
    OrderDate AS OrderDate,
    DeliveryDate AS DeliveryDate,
	EXTRACT(YEAR FROM OrderDate) AS Year,
    EXTRACT(MONTH FROM OrderDate) AS Month,
    EXTRACT(DAY FROM OrderDate) AS Day
INTO
    Dim_Time_Load
FROM
    orders;

INSERT INTO Dim_Time (OrderDate, DeliveryDate, Year, Month, Day)
SELECT
    OrderDate,
	DeliveryDate,
	Year,
	Month,
	Day
FROM
    Dim_Time_Load;


SELECT
    orders.OrderID,
    Dim_Customer.CustomerKey,
    Dim_Product.ProductKey,
    Dim_Time.TimeKey,
    Quantity,
    UnitPrice,
    Quantity * UnitPrice AS Total
INTO
    Fact_Order_Load
FROM
    orderItem
JOIN
    orders ON orderItem.OrderID = orders.OrderID
JOIN
    Dim_Customer ON orders.Username = Dim_Customer.Username
JOIN
    Dim_Product ON orderItem.ProductName = Dim_Product.ProductName
JOIN
    Dim_Time ON orders.OrderDate = Dim_Time.OrderDate;

INSERT INTO Fact_Order (OrderID, CustomerKey, ProductKey, TimeKey, Quantity, UnitPrice, Total)
SELECT
    OrderID,
    CustomerKey,
    ProductKey,
    TimeKey,
    Quantity,
    UnitPrice,
    Total
FROM
    Fact_Order_Load;


SELECT
    WishlistID,
    Dim_Customer.CustomerKey,
    Dim_Product.ProductKey
INTO
    Fact_Wishlist_Load
FROM
    wishlist
JOIN
    Dim_Customer ON wishlist.Username = Dim_Customer.Username
JOIN
    Dim_Product ON wishlist.ProductName = Dim_Product.ProductName;

INSERT INTO Fact_Wishlist (WishlistID, CustomerKey, ProductKey)
SELECT
    WishlistID,
    CustomerKey,
    ProductKey
FROM
    Fact_Wishlist_Load;