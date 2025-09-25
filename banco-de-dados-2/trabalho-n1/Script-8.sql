INSERT INTO ProductCategory (id, name, description) VALUES
(1, 'Eletrônicos', 'Produtos eletrônicos em geral'),
(2, 'Roupas', 'Vestuário masculino e feminino'),
(3, 'Livros', 'Literatura e material educativo');

INSERT INTO Product (name, description, value, categoryId) VALUES
('Smartphone X', 'Celular de última geração', 2999.90, 1),
('Notebook Pro', 'Laptop para uso profissional', 4999.99, 1),
('Camisa Polo', 'Camisa de algodão masculina', 89.90, 2),
('Calça Jeans', 'Calça jeans feminina', 119.90, 2),
('Livro de SQL', 'Aprenda SQL com exemplos práticos', 59.90, 3),
('Romance Moderno', 'Livro de ficção contemporânea', 39.90, 3);

INSERT INTO Users (id, name, lastName, email) VALUES
(1, 'João', 'Silva', 'joao.silva@email.com'),
(2, 'Maria', 'Souza', 'maria.souza@email.com'),
(3, 'Carlos', 'Pereira', 'carlos.p@email.com');

INSERT INTO Employees (userId, role, salary) VALUES
(1, 'Administrador', 5000.00),
(2, 'Vendedor', 3000.00);

INSERT INTO Stock (productId, quantity) VALUES
(1, 50),
(2, 30),
(3, 100),
(4, 80),
(5, 200),
(6, 150);

INSERT INTO Sales (productId, userId, quantity, payWay) VALUES
(1, 2, 1, 'Cartão Crédito'),
(3, 3, 2, 'Pix'),
(5, 2, 1, 'Boleto');

INSERT INTO Tracking (saleId, status, deliveryDate, shippingDate, delivered) VALUES
(1, 'Enviado', '2025-04-12', '2025-04-10', 0),
(2, 'Entregue', '2025-04-08', '2025-04-05', 1),
(3, 'Pendente', NULL, NULL, 0);