-- Создание таблицы User
CREATE TABLE User (
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(10) DEFAULT 'USER',
    verified TIMESTAMP,
    provider VARCHAR(255),
    providerId VARCHAR(255),
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now()
);

-- Создание таблицы Category
CREATE TABLE Category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now()
);

-- Создание таблицы Product
CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    imageUrl VARCHAR(255) NOT NULL,
    categoryId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now(),
    CONSTRAINT fk_category FOREIGN KEY (categoryId) REFERENCES Category(id)
);

-- Создание таблицы ProductItem
CREATE TABLE ProductItem (
    id SERIAL PRIMARY KEY,
    price INT NOT NULL,
    size INT,
    pizzaType INT,
    productId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now(),
    CONSTRAINT fk_product FOREIGN KEY (productId) REFERENCES Product(id)
);

-- Создание таблицы Ingredient
CREATE TABLE Ingredient (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    imageUrl VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now()
);

-- Создание таблицы Cart
CREATE TABLE Cart (
    id SERIAL PRIMARY KEY,
    userId INT UNIQUE,
    token VARCHAR(255) NOT NULL,
    totalAmount INT DEFAULT 0,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES User(id)
);

-- Создание таблицы CartItem
CREATE TABLE CartItem (
    id SERIAL PRIMARY KEY,
    cartId INT NOT NULL,
    productItemId INT NOT NULL,
    quantity INT DEFAULT 1,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now(),
    CONSTRAINT fk_cart FOREIGN KEY (cartId) REFERENCES Cart(id),
    CONSTRAINT fk_productItem FOREIGN KEY (productItemId) REFERENCES ProductItem(id)
);

-- Создание таблицы Order
CREATE TABLE "Order" (
    id SERIAL PRIMARY KEY,
    userId INT,
    token VARCHAR(255) NOT NULL,
    totalAmount INT NOT NULL,
    status VARCHAR(10) NOT NULL,
    paymentId VARCHAR(255),
    items JSON NOT NULL,
    fullName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    comment VARCHAR(255),
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now(),
    CONSTRAINT fk_order_user FOREIGN KEY (userId) REFERENCES User(id)
);

-- Создание таблицы VerificationCode
CREATE TABLE VerificationCode (
    id SERIAL PRIMARY KEY,
    userId INT UNIQUE NOT NULL,
    code VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    CONSTRAINT fk_verification_user FOREIGN KEY (userId) REFERENCES User(id),
    UNIQUE (userId, code)
);

-- Создание таблицы Story
CREATE TABLE Story (
    id SERIAL PRIMARY KEY,
    previewImageUrl VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT now()
);

-- Создание таблицы StoryItem
CREATE TABLE StoryItem (
    id SERIAL PRIMARY KEY,
    storyId INT NOT NULL,
    sourceUrl VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    CONSTRAINT fk_story FOREIGN KEY (storyId) REFERENCES Story(id)
);

-- Создание таблиц связей для M:N отношений
-- Таблица связей между Product и Ingredient
CREATE TABLE Product_Ingredients (
    productId INT NOT NULL,
    ingredientId INT NOT NULL,
    PRIMARY KEY (productId, ingredientId),
    CONSTRAINT fk_product_ingredient_product FOREIGN KEY (productId) REFERENCES Product(id),
    CONSTRAINT fk_product_ingredient_ingredient FOREIGN KEY (ingredientId) REFERENCES Ingredient(id)
);

-- Таблица связей между CartItem и Ingredient
CREATE TABLE CartItem_Ingredients (
    cartItemId INT NOT NULL,
    ingredientId INT NOT NULL,
    PRIMARY KEY (cartItemId, ingredientId),
    CONSTRAINT fk_cartitem_ingredient_cartitem FOREIGN KEY (cartItemId) REFERENCES CartItem(id),
    CONSTRAINT fk_cartitem_ingredient_ingredient FOREIGN KEY (ingredientId) REFERENCES Ingredient(id)
);
