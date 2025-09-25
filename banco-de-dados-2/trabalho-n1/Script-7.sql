

-- IFF
SELECT 
    id,
    saleId,
    status,
    deliveryDate,
    shippingDate,
    IIF(GETDATE() >= deliveryDate, 1, 0) AS deliveryed
FROM Tracking;

CREATE INDEX idx_stock_product ON stock(productId);

select productId from stock where productId = 1

SELECT IIF(GETDATE() > deliveryDate, 'Late', 'On time') AS status FROM Tracking;

-- While
DECLARE @id INT = 1;
DECLARE @maxId INT = (SELECT MAX(id) FROM Product);
DECLARE @productName VARCHAR(255);
DECLARE @value DECIMAL(10,2);
DECLARE @quantity INT;

WHILE @id <= @maxId
BEGIN
    SELECT 
        @productName = p.name,
        @value = p.value,
        @quantity = s.quantity
    FROM Product p
    JOIN Stock s ON p.id = s.productId
    WHERE p.id = @id;

    IF @quantity IS NULL OR @quantity = 0
    BEGIN
        SET @id = @id + 1;
        CONTINUE;
    END

    IF @value > 10000
    BEGIN
        PRINT 'Product expensive';
        BREAK;
    END

    PRINT 'Product: ' + @productName + ' | Stock Total : R$ ' + CAST(@value * @quantity AS VARCHAR);

    SET @id = @id + 1;
END

-- Sale
CREATE PROCEDURE InsertSaleWithStockCheck
@qtd int,
@productId int,
@userId int,
@payWay varchar(64)
as
begin
IF (SELECT quantity FROM Stock WHERE productId = @productId) < @qtd
begin
    PRINT 'insufficient stock';
end
ELSE
begin
	INSERT
	INTO
	Sales
	(productId,
userId,
quantity,
payWay)
values
(@productId,
@userId,
@qtd,
@payWay)
end
end


SELECT userId,
    CASE 
        WHEN COUNT(*) > 10 THEN 'Frequent Customer'
        ELSE 'Comum Customer'
    END AS clientType
FROM Sales
GROUP BY userId;


CREATE TRIGGER trg_CheckSalary
ON Employees
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE salary < 1412.00)
        RAISERROR ('Salary below of the minimum.', 16, 1);
    ELSE
        INSERT INTO Employees SELECT * FROM inserted;
END;


INSERT INTO Users (id, name, lastName, email) VALUES
(7, 'Igor', 'Silva', 'igor.silva@email.com');

INSERT INTO Employees (userId, role, salary) VALUES
(7, 'Administrador', 1300.00);

CREATE TRIGGER trg_UpdateStockAfterSale
ON Sales
AFTER INSERT
AS
BEGIN
    UPDATE Stock
    SET quantity = s.quantity - i.quantity
    FROM Stock s
    JOIN inserted i ON s.productId = i.productId;
END;

EXEC InsertSaleWithStockCheck @productId = 1, @userId = 2, @qtd = 20, @payWay = 'Cartão Crédito';

SELECT id, productId, quantity from Stock where productId = 1;

-- Function
CREATE FUNCTION fn_TotalBuy(@saleId INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @valor DECIMAL(10,2);

    SELECT @valor = s.quantity * p.value
    FROM Sales s
    JOIN Product p ON s.productId = p.id
    WHERE s.id = @saleId;

    RETURN @valor;
END;

select id, dbo.fn_TotalBuy(id) as Total from Sales
