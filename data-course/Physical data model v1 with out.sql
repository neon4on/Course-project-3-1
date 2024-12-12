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

CREATE TABLE Category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now()
);

CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    imageUrl VARCHAR(255) NOT NULL,
    categoryId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now(),
    FOREIGN KEY (categoryId) REFERENCES Category(id)
);

CREATE TABLE ProductItem (
    id SERIAL PRIMARY KEY,
    price INT NOT NULL,
    size INT,
    pizzaType INT,
    productId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now(),
    FOREIGN KEY (productId) REFERENCES Product(id)
);

CREATE TABLE Ingredient (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    imageUrl VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now()
);

CREATE TABLE Cart (
    id SERIAL PRIMARY KEY,
    userId INT UNIQUE,
    token VARCHAR(255) NOT NULL,
    totalAmount INT DEFAULT 0,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now(),
    FOREIGN KEY (userId) REFERENCES User(id)
);

CREATE TABLE CartItem (
    id SERIAL PRIMARY KEY,
    cartId INT NOT NULL,
    productItemId INT NOT NULL,
    quantity INT DEFAULT 1,
    createdAt TIMESTAMP DEFAULT now(),
    updatedAt TIMESTAMP DEFAULT now(),
    FOREIGN KEY (cartId) REFERENCES Cart(id),
    FOREIGN KEY (productItemId) REFERENCES ProductItem(id)
);

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
    FOREIGN KEY (userId) REFERENCES User(id)
);

CREATE TABLE VerificationCode (
    id SERIAL PRIMARY KEY,
    userId INT UNIQUE NOT NULL,
    code VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    FOREIGN KEY (userId) REFERENCES User(id),
    UNIQUE (userId, code)
);

CREATE TABLE Story (
    id SERIAL PRIMARY KEY,
    previewImageUrl VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT now()
);

CREATE TABLE StoryItem (
    id SERIAL PRIMARY KEY,
    storyId INT NOT NULL,
    sourceUrl VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    FOREIGN KEY (storyId) REFERENCES Story(id)
);

CREATE TABLE Product_Ingredients (
    productId INT NOT NULL,
    ingredientId INT NOT NULL,
    PRIMARY KEY (productId, ingredientId),
    FOREIGN KEY (productId) REFERENCES Product(id),
    FOREIGN KEY (ingredientId) REFERENCES Ingredient(id)
);

CREATE TABLE CartItem_Ingredients (
    cartItemId INT NOT NULL,
    ingredientId INT NOT NULL,
    PRIMARY KEY (cartItemId, ingredientId),
    FOREIGN KEY (cartItemId) REFERENCES CartItem(id),
    FOREIGN KEY (ingredientId) REFERENCES Ingredient(id)
);
