CREATE TABLE "User"(
    "id" INTEGER NOT NULL,
    "fullName" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "role" VARCHAR(10) NULL DEFAULT 'USER',
    "verified" TIMESTAMP(0) WITHOUT TIME ZONE NULL,
    "provider" VARCHAR(255) NULL,
    "providerId" VARCHAR(255) NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "User" ADD PRIMARY KEY("id");
ALTER TABLE
    "User" ADD CONSTRAINT "user_email_unique" UNIQUE("email");
CREATE TABLE "Category"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "Category" ADD PRIMARY KEY("id");
ALTER TABLE
    "Category" ADD CONSTRAINT "category_name_unique" UNIQUE("name");
CREATE TABLE "Product"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "imageUrl" VARCHAR(255) NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "Product" ADD PRIMARY KEY("id");
CREATE TABLE "ProductItem"(
    "id" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,
    "size" INTEGER NULL,
    "pizzaType" INTEGER NULL,
    "productId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "ProductItem" ADD PRIMARY KEY("id");
CREATE TABLE "Ingredient"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "price" INTEGER NOT NULL,
    "imageUrl" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "Ingredient" ADD PRIMARY KEY("id");
CREATE TABLE "Cart"(
    "id" INTEGER NOT NULL,
    "userId" INTEGER NULL,
    "token" VARCHAR(255) NOT NULL,
    "totalAmount" INTEGER NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "Cart" ADD PRIMARY KEY("id");
ALTER TABLE
    "Cart" ADD CONSTRAINT "cart_userid_unique" UNIQUE("userId");
CREATE TABLE "CartItem"(
    "id" INTEGER NOT NULL,
    "cartId" INTEGER NOT NULL,
    "productItemId" INTEGER NOT NULL,
    "quantity" INTEGER NULL DEFAULT '1',
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "CartItem" ADD PRIMARY KEY("id");
CREATE TABLE "Order"(
    "id" INTEGER NOT NULL,
    "userId" INTEGER NULL,
    "token" VARCHAR(255) NOT NULL,
    "totalAmount" INTEGER NOT NULL,
    "status" VARCHAR(10) NOT NULL,
    "paymentId" VARCHAR(255) NULL,
    "items" JSON NOT NULL,
    "fullName" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(50) NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "comment" VARCHAR(255) NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "Order" ADD PRIMARY KEY("id");
CREATE TABLE "VerificationCode"(
    "id" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "code" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "VerificationCode" ADD CONSTRAINT "verificationcode_userid_code_unique" UNIQUE("userId", "code");
ALTER TABLE
    "VerificationCode" ADD PRIMARY KEY("id");
ALTER TABLE
    "VerificationCode" ADD CONSTRAINT "verificationcode_userid_unique" UNIQUE("userId");
CREATE TABLE "Story"(
    "id" INTEGER NOT NULL,
    "previewImageUrl" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "Story" ADD PRIMARY KEY("id");
CREATE TABLE "StoryItem"(
    "id" INTEGER NOT NULL,
    "storyId" INTEGER NOT NULL,
    "sourceUrl" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(0) WITHOUT TIME ZONE NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE
    "StoryItem" ADD PRIMARY KEY("id");
CREATE TABLE "Product_Ingredients"(
    "productId" INTEGER NOT NULL,
    "ingredientId" INTEGER NOT NULL
);
ALTER TABLE
    "Product_Ingredients" ADD PRIMARY KEY("productId");
ALTER TABLE
    "Product_Ingredients" ADD PRIMARY KEY("ingredientId");
CREATE TABLE "CartItem_Ingredients"(
    "cartItemId" INTEGER NOT NULL,
    "ingredientId" INTEGER NOT NULL
);
ALTER TABLE
    "CartItem_Ingredients" ADD PRIMARY KEY("cartItemId");
ALTER TABLE
    "CartItem_Ingredients" ADD PRIMARY KEY("ingredientId");
ALTER TABLE
    "Ingredient" ADD CONSTRAINT "ingredient_id_foreign" FOREIGN KEY("id") REFERENCES "CartItem_Ingredients"("ingredientId");
ALTER TABLE
    "Product" ADD CONSTRAINT "product_id_foreign" FOREIGN KEY("id") REFERENCES "Product_Ingredients"("productId");
ALTER TABLE
    "VerificationCode" ADD CONSTRAINT "verificationcode_userid_foreign" FOREIGN KEY("userId") REFERENCES "User"("id");
ALTER TABLE
    "Ingredient" ADD CONSTRAINT "ingredient_id_foreign" FOREIGN KEY("id") REFERENCES "Product_Ingredients"("ingredientId");
ALTER TABLE
    "CartItem" ADD CONSTRAINT "cartitem_cartid_foreign" FOREIGN KEY("cartId") REFERENCES "Cart"("id");
ALTER TABLE
    "Order" ADD CONSTRAINT "order_userid_foreign" FOREIGN KEY("userId") REFERENCES "User"("id");
ALTER TABLE
    "Product" ADD CONSTRAINT "product_categoryid_foreign" FOREIGN KEY("categoryId") REFERENCES "Category"("id");
ALTER TABLE
    "CartItem" ADD CONSTRAINT "cartitem_id_foreign" FOREIGN KEY("id") REFERENCES "CartItem_Ingredients"("cartItemId");
ALTER TABLE
    "StoryItem" ADD CONSTRAINT "storyitem_storyid_foreign" FOREIGN KEY("storyId") REFERENCES "Story"("id");
ALTER TABLE
    "Cart" ADD CONSTRAINT "cart_userid_foreign" FOREIGN KEY("userId") REFERENCES "User"("id");
ALTER TABLE
    "CartItem" ADD CONSTRAINT "cartitem_productitemid_foreign" FOREIGN KEY("productItemId") REFERENCES "ProductItem"("id");
ALTER TABLE
    "ProductItem" ADD CONSTRAINT "productitem_productid_foreign" FOREIGN KEY("productId") REFERENCES "Product"("id");