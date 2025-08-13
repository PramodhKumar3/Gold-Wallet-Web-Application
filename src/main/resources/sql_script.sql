--- DIGITAL-GOLD-WALLET_SQL

CREATE DATABASE IF NOT EXISTS digitalgoldwallet;

USE digitalgoldwallet;

-- Table for Addresses
CREATE TABLE addresses (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    country VARCHAR(100) NOT NULL
);

-- Table for Users
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    address_id INT,
    balance DECIMAL(18, 2) DEFAULT 0.0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

-- Table for Gold Vendors
CREATE TABLE vendors (
    vendor_id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_name VARCHAR(100) NOT NULL,
    description TEXT,
    contact_person_name VARCHAR(100),
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    website_url VARCHAR(255),
    total_gold_quantity DECIMAL(18, 2) NOT NULL DEFAULT 0.0, 
    current_gold_price DECIMAL(18, 2) NOT NULL DEFAULT 5700.00,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table for Vendor Branches
CREATE TABLE vendor_branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_id INT,
    address_id INT,
    quantity DECIMAL(18, 2) NOT NULL DEFAULT 0.0, 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

-- Table for Virtual Gold Holdings
CREATE TABLE virtual_gold_holdings (
    holding_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    branch_id INT,
    quantity DECIMAL(18, 2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (branch_id) REFERENCES vendor_branches(branch_id)
);

-- Table for Physical Gold Transactions
CREATE TABLE physical_gold_transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    branch_id INT,
    quantity DECIMAL(18, 2) NOT NULL,
    delivery_address_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (branch_id) REFERENCES vendor_branches(branch_id),
    FOREIGN KEY (delivery_address_id) REFERENCES addresses(address_id)
);

-- Table for Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    amount DECIMAL(18, 2) NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'Google Pay', 'Amazon Pay', 'PhonePe', 'Paytm', 'Bank Transfer'),
    transaction_type ENUM('Credited to wallet', 'Debited from wallet'),
    payment_status ENUM('Success', 'Failed'),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table for Transaction History (for users and vendors)
CREATE TABLE transaction_history (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    branch_id INT,
    transaction_type ENUM('Buy', 'Sell', 'Convert to Physical'),
    transaction_status ENUM('Success', 'Failed'),
    quantity DECIMAL(10, 2) NOT NULL,
    amount DECIMAL(18, 2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (branch_id) REFERENCES vendor_branches(branch_id)
);

-- Insert addresses data in addresses table
INSERT INTO addresses (street, city, state, postal_code, country)
VALUES
('123 Main Street', 'Mumbai', 'Maharashtra', '400001', 'India'),
('456 Oak Avenue', 'Delhi', 'Delhi', '110001', 'India'),
('789 Pine Road', 'Bangalore', 'Karnataka', '560001', 'India'),
('101 Cedar Lane', 'Chennai', 'Tamil Nadu', '600001', 'India'),
('202 Maple Street', 'Kolkata', 'West Bengal', '700001', 'India'),
('303 Palm Drive', 'Hyderabad', 'Telangana', '500001', 'India'),
('404 Pineapple Street', 'Pune', 'Maharashtra', '411001', 'India'),
('505 Olive Road', 'Ahmedabad', 'Gujarat', '380001', 'India'),
('606 Mango Lane', 'Jaipur', 'Rajasthan', '302001', 'India'),
('707 Banana Avenue', 'Lucknow', 'Uttar Pradesh', '226001', 'India'),
('808 Apple Street', 'Kanpur', 'Uttar Pradesh', '208001', 'India'),
('909 Cherry Road', 'Nagpur', 'Maharashtra', '440001', 'India'),
('101 Pinecone Lane', 'Indore', 'Madhya Pradesh', '452001', 'India'),
('202 Sunflower Street', 'Thane', 'Maharashtra', '400601', 'India'),
('303 Rose Avenue', 'Bhopal', 'Madhya Pradesh', '462001', 'India'),
('404 Tulip Road', 'Visakhapatnam', 'Andhra Pradesh', '530001', 'India'),
('505 Lotus Lane', 'Agra', 'Uttar Pradesh', '282001', 'India'),
('606 Orchid Drive', 'Coimbatore', 'Tamil Nadu', '641001', 'India'),
('707 Jasmine Road', 'Madurai', 'Tamil Nadu', '625001', 'India'),
('808 Lily Lane', 'Faridabad', 'Haryana', '121001', 'India'),
('909 Magnolia Street', 'Varanasi', 'Uttar Pradesh', '221001', 'India'),
('1011 Violet Road', 'Thiruvananthapuram', 'Kerala', '695001', 'India'),
('1212 Iris Lane', 'Patna', 'Bihar', '800001', 'India'),
('1313 Bluebell Avenue', 'Ranchi', 'Jharkhand', '834001', 'India'),
('1414 Sun Lane', 'Guwahati', 'Assam', '781001', 'India'),
('1515 Rainbow Road', 'Shimla', 'Himachal Pradesh', '171001', 'India'),
('1616 Cloud Lane', 'Dehradun', 'Uttarakhand', '248001', 'India'),
('1717 Mountain Avenue', 'Surat', 'Gujarat', '395001', 'India'),
('1818 River Road', 'Kochi', 'Kerala', '682001', 'India'),
('1919 Ocean Lane', 'Vadodara', 'Gujarat', '390001', 'India'),
('2020 Harbor Street', 'Raipur', 'Chhattisgarh', '492001', 'India'),
('2121 Beach Lane', 'Jamshedpur', 'Jharkhand', '831001', 'India'),
('2222 Forest Road', 'Jodhpur', 'Rajasthan', '342001', 'India'),
('2323 Desert Avenue', 'Amritsar', 'Punjab', '143001', 'India'),
('2424 Oasis Lane', 'Ghaziabad', 'Uttar Pradesh', '201001', 'India'),
('2525 Sunset Road', 'Noida', 'Uttar Pradesh', '201301', 'India'),
('2626 Horizon Street', 'Gandhinagar', 'Gujarat', '382001', 'India'),
('2727 Sky Lane', 'Bhubaneswar', 'Odisha', '751001', 'India'),
('2828 Star Avenue', 'Nashik', 'Maharashtra', '422001', 'India'),
('2929 Galaxy Road', 'Allahabad', 'Uttar Pradesh', '211001', 'India'),
('3030 Comet Lane', 'Cuttack', 'Odisha', '753001', 'India'),
('3131 Nebula Street', 'Howrah', 'West Bengal', '711001', 'India'),
('3232 Meteor Road', 'Srinagar', 'Jammu and Kashmir', '190001', 'India'),
('3333 Cosmos Lane', 'Dhanbad', 'Jharkhand', '826001', 'India'),
('3434 Planet Avenue', 'Gurgaon', 'Haryana', '122001', 'India'),
('3535 Starflower Street', 'Kollam', 'Kerala', '691001', 'India'),
('3636 Comet Lane', 'Rourkela', 'Odisha', '769001', 'India'),
('3737 Stardust Road', 'Mangalore', 'Karnataka', '575001', 'India'),
('3838 Celestial Lane', 'Siliguri', 'West Bengal', '734001', 'India'),
('3939 Galaxy Avenue', 'Tiruchirappalli', 'Tamil Nadu', '620001', 'India');

-- Insert gold vendors data into the vendors table 
INSERT INTO vendors (vendor_name, description, contact_person_name, contact_email, contact_phone, website_url, total_gold_quantity, current_gold_price, created_at) VALUES
('Sona Jewelers', 'Your trusted source for authentic gold jewelry', 'Rohit Verma', 'rohit.sona@example.com', '+91 9876541230', 'https://www.sonajewelers.com', 2200.00, 6400.00, '2025-07-07 10:00:00'),
('Golden Heritage', 'Preserving India''s rich heritage in gold craftsmanship', 'Ananya Kapoor', 'ananya.goldenheritage@example.com', '+91 9871239876', 'https://www.goldenheritageindia.in', 2800.00, 6400.00, '2025-07-07 10:00:00'),
('Regal Gold Emporium', 'Exuding regality through our gold collections', 'Aryan Singh', 'aryan.regalgold@example.com', '+91 9887612345', 'https://www.regalgoldemporium.com', 1600.00, 6400.00, '2025-07-07 10:00:00'),
('Radiant Ornaments', 'Reflecting radiance through meticulously crafted gold pieces', 'Sakshi Gupta', 'sakshi.radiant@example.com', '+91 9876785678', 'https://www.radiantornaments.in', 4500.00, 6400.00, '2025-07-07 10:00:00'),
('Om Shri Jewels', 'Blending spirituality with exquisite gold jewelry', 'Aditya Sharma', 'aditya.omshri@example.com', '+91 9873458765', 'https://www.omshrijewels.com', 1200.00, 6400.00, '2025-07-07 10:00:00'),
('Mystique Gold Designs', 'Creating mystique with unique and artistic gold designs', 'Ishaan Kapoor', 'ishaan.mystiquegold@example.com', '+91 9874567890', 'https://www.mystiquegolddesigns.in', 3200.00, 6400.00, '2025-07-07 10:00:00'),
('Golden Blossoms', 'Blooming beauty in every piece of our golden creations', 'Riya Patel', 'riya.goldenblossoms@example.com', '+91 9876545678', 'https://www.goldenblossoms.co.in', 1500.00, 6400.00, '2025-07-07 10:00:00'),
('Shubh Gold Crafts', 'Crafting auspicious gold pieces for your special moments', 'Kunal Verma', 'kunal.shubhgold@example.com', '+91 9873456789', 'https://www.shubhgoldcrafts.com', 4200.00, 6400.00, '2025-07-07 10:00:00'),
('Nirvana Jewels', 'Experience bliss with our ethereal gold jewelry designs', 'Tanvi Singh', 'tanvi.nirvanajewels@example.com', '+91 9876543219', 'https://www.nirvanajewelsindia.com', 2900.00, 6400.00, '2025-07-07 10:00:00'),
('Dynasty Gold', 'Continuing the legacy of timeless gold craftsmanship', 'Vikrant Gupta', 'vikrant.dynastygold@example.com', '+91 9876789012', 'https://www.dynastygold.in', 1900.00, 6400.00, '2025-07-07 10:00:00'),
('Divine Gold Exports', 'Exporting divine craftsmanship in gold worldwide', 'Ritu Kapoor', 'ritu.divinegold@example.com', '+91 9871234567', 'https://www.divinegoldexports.com', 3600.00, 6400.00, '2025-07-07 10:00:00'),
('Sovereign Gold', 'Ruling the gold industry with sovereign craftsmanship', 'Siddharth Verma', 'siddharth.sovereigngold@example.com', '+91 9872345678', 'https://www.sovereigngold.co.in', 1000.00, 6400.00, '2025-07-07 10:00:00'),
('Golden Glint Studios', 'Capturing the glint of gold in every jewelry piece', 'Shivangi Singh', 'shivangi.goldenglint@example.com', '+91 9873456789', 'https://www.goldenglintstudios.com', 2300.00, 6400.00, '2025-07-07 10:00:00'),
('Aureate Elegance', 'Elegance personified through our exquisite gold collections', 'Rohini Gupta', 'rohini.aureate@example.com', '+91 9874567890', 'https://www.aureateelegance.in', 4800.00, 6400.00, '2025-07-07 10:00:00'),
('Sunrise Gold Crafts', 'Crafting gold pieces that shine like the morning sun', 'Kartik Verma', 'kartik.sunrisegold@example.com', '+91 9875678901', 'https://www.sunrisegoldcrafts.com', 2900.00, 6400.00, '2025-07-07 10:00:00'),
('Velvet Gold Designs', 'Designs as soft and luxurious as velvet in gold jewelry', 'Aanya Patel', 'aanya.velvetgold@example.com', '+91 9876789012', 'https://www.velvetgolddesigns.in', 3700.00, 6400.00, '2025-07-07 10:00:00'),
('Eternal Gold Legacy', 'Carrying forward the legacy of eternal gold craftsmanship', 'Arnav Singh', 'arnav.eternalgold@example.com', '+91 9877890123', 'https://www.eternalgoldlegacy.com', 3300.00, 6400.00, '2025-07-07 10:00:00'),
('Golden Horizon Jewelers', 'Reaching new heights with our horizon of gold designs', 'Shreya Kapoor', 'shreya.goldenhorizon@example.com', '+91 9878901234', 'https://www.goldenhorizonjewelers.in', 1200.00, 6400.00, '2025-07-07 10:00:00'),
('Crown Jewels India', 'Fit for royalty every piece in our gold crown collection', 'Aarav Gupta', 'aarav.crownjewels@example.com', '+91 9879012345', 'https://www.crownjewelsindia.com', 4700.00, 6400.00, '2025-07-07 10:00:00'),
('Ethereal Gold Artistry', 'Artistry that transcends the ordinary in gold craftsmanship', 'Ishita Verma', 'ishita.etherealgold@example.com', '+91 9870123456', 'https://www.etherealgoldartistry.in', 1800.00, 6400.00, '2025-07-07 10:00:00'),
('Gold Symphony Creations', 'Creating a symphony of elegance with our gold designs', 'Rohan Patel', 'rohan.goldsymphony@example.com', '+91 9871234567', 'https://www.goldsymphonycreations.com', 3500.00, 6400.00, '2025-07-07 10:00:00'),
('Majestic Gold Studios', 'Capturing the majesty of gold in every jewelry creation', 'Tanishka Gupta', 'tanishka.majesticgold@example.com', '+91 9872345678', 'https://www.majesticgoldstudios.in', 2700.00, 6400.00, '2025-07-07 10:00:00'),
('Radiant Gold Crafts', 'Crafting radiance through our meticulous gold craftsmanship', 'Virat Verma', 'virat.radiantgold@example.com', '+91 9873456789', 'https://www.radiantgoldcrafts.com', 2900.00, 6400.00, '2025-07-07 10:00:00'),
('Gold Rhapsody', 'A rhapsody of gold in every note of our jewelry designs', 'Saumya Patel', 'saumya.goldrhapsody@example.com', '+91 9874567890', 'https://www.goldrhapsody.in', 3300.00, 6400.00, '2025-07-07 10:00:00'),
('Celestial Gold Designs', 'Designs that reach the celestial heights of gold elegance', 'Aryan Gupta', 'aryan.celestialgold@example.com', '+91 9875678901', 'https://www.celestialgolddesigns.com', 3000.00, 6400.00, '2025-07-07 10:00:00'),
('Mystic Gold Creations', 'Mystic allure in every piece of our handcrafted gold jewelry', 'Neha Kapoor', 'neha.mysticgold@example.com', '+91 9876789012', 'https://www.mysticgoldcreations.co.in', 1600.00, 6400.00, '2025-07-07 10:00:00'),
('Imperial Gold Arts', 'Artistic excellence fit for an imperial collection in gold', 'Kabir Verma', 'kabir.imperialgold@example.com', '+91 9877890123', 'https://www.imperialgoldarts.com', 4400.00, 6400.00, '2025-07-07 10:00:00'),
('Golden Essence', 'Capturing the essence of gold in every piece of jewelry', 'Aanya Singh', 'aanya.goldenessence@example.com', '+91 9878901234', 'https://www.goldenessence.co.in', 3700.00, 6400.00, '2025-07-07 10:00:00'),
('Prism Gold Crafts', 'Creating a prism of colors through our gold craftsmanship', 'Aarav Patel', 'aarav.prismgold@example.com', '+91 9879012345', 'https://www.prismgoldcrafts.in', 1200.00, 6400.00, '2025-07-07 10:00:00'),
('Golden Aura', 'Radiating a golden aura in every jewelry creation', 'Kavya Kapoor', 'kavya.goldenaura@example.com', '+91 9870123456', 'https://www.goldenaura.co.in', 3200.00, 6400.00, '2025-07-07 10:00:00'),
('Midas Touch Jewelers', 'Bestowing the Midas touch to every piece of gold', 'Rohan Singh', 'rohan.midastouch@example.com', '+91 9871234567', 'https://www.midastouchjewelers.in', 4500.00, 6400.00, '2025-07-07 10:00:00'),
('Pure Elegance Gold', 'Pure elegance personified in our gold jewelry designs', 'Anika Patel', 'anika.pureelegance@example.com', '+91 9872345678', 'https://www.pureelegancegold.com', 2200.00, 6400.00, '2025-07-07 10:00:00'),
('Opulent Gold Crafts', 'Crafting opulence through intricate gold designs', 'Vihaan Verma', 'vihaan.opulentgold@example.com', '+91 9873456789', 'https://www.opulentgoldcrafts.in', 1900.00, 6400.00, '2025-07-07 10:00:00'),
('Divine Treasures', 'Unveiling divine treasures through our gold craftsmanship', 'Aisha Gupta', 'aisha.divinetreasures@example.com', '+91 9874567890', 'https://www.divinetreasuresindia.com', 4200.00, 6400.00, '2025-07-07 10:00:00'),
('Enchanting Gold Studios', 'Enchanting souls with our spellbinding gold designs', 'Dev Kapoor', 'dev.enchantinggold@example.com', '+91 9875678901', 'https://www.enchantinggoldstudios.in', 2900.00, 6400.00, '2025-07-07 10:00:00'),
('Royal Radiance Jewelers', 'Exuding royal radiance in every piece of our gold collection', 'Ishani Patel', 'ishani.royalradiance@example.com', '+91 9876789012', 'https://www.royalradiancejewelers.com', 1900.00, 6400.00, '2025-07-07 10:00:00'),
('Gold Odyssey', 'Embarking on an odyssey of gold elegance and craftsmanship', 'Arjun Singh', 'arjun.goldodyssey@example.com', '+91 9877890123', 'https://www.goldodyssey.in', 3200.00, 6400.00, '2025-07-07 10:00:00'),
('Serene Gold Arts', 'Crafting serenity through the artistry of gold', 'Siya Verma', 'siya.serenegold@example.com', '+91 9878901234', 'https://www.serenegoldarts.co.in', 3500.00, 6400.00, '2025-07-07 10:00:00'),
('Eternal Elegance', 'Elegance that stands the test of time in gold creations', 'Advait Patel', 'advait.eternalelegance@example.com', '+91 9879012345', 'https://www.eternalelegancegold.com', 2700.00, 6400.00, '2025-07-07 10:00:00'),
('Golden Serendipity', 'Serendipitous moments created through our gold designs', 'Aradhya Gupta', 'aradhya.goldenserendipity@example.com', '+91 9870123456', 'https://www.goldenserendipity.in', 2900.00, 6400.00, '2025-07-07 10:00:00'),
('Lustrous Gold Designs', 'Lustrous designs that define the essence of gold', 'Yash Patel', 'yash.lustrousgold@example.com', '+91 9871234567', 'https://www.lustrousgolddesigns.co.in', 1600.00, 6400.00, '2025-07-07 10:00:00'),
('Vivid Gold Creations', 'Vivid and vibrant gold creations for every occasion', 'Myra Verma', 'myra.vividgold@example.com', '+91 9872345678', 'https://www.vividgoldcreations.in', 2200.00, 6400.00, '2025-07-07 10:00:00'),
('Timeless Gold Treasures', 'Treasures that withstand the test of time in gold', 'Aryan Gupta', 'aryan.timelessgold@example.com', '+91 9873456789', 'https://www.timelessgoldtreasures.com', 4800.00, 6400.00, '2025-07-07 10:00:00'),
('Golden Symphony Crafts', 'Creating a symphony of beauty with our gold craftsmanship', 'Riya Patel', 'riya.goldensymphony@example.com', '+91 9874567890', 'https://www.goldensymphonycrafts.in', 1800.00, 6400.00, '2025-07-07 10:00:00'),
('Ethereal Gold Elegance', 'Ethereal elegance in every piece of our handcrafted gold', 'Kabir Singh', 'kabir.etherealgold@example.com', '+91 9875678901', 'https://www.etherealgoldelegance.com', 3500.00, 6400.00, '2025-07-07 10:00:00'),
('Divine Ornaments', 'Crafting ornaments that embody divine elegance', 'Anvi Gupta', 'anvi.divineornaments@example.com', '+91 9878909876', 'https://www.divineornaments.co.in', 1000.00, 6400.00, '2025-07-07 10:00:00'),
('Golden Traditions', 'Preserving and celebrating golden traditions through jewelry', 'Arnav Kapoor', 'arnav.goldentraditions@example.com', '+91 9876543210', 'https://www.goldentraditionsindia.com', 2300.00, 6400.00, '2025-07-07 10:00:00'),
('Harmony Gold Studios', 'Harmonizing beauty and craftsmanship in every gold creation', 'Kavya Singh', 'kavya.harmonygold@example.com', '+91 9870123456', 'https://www.harmonygoldstudios.in', 1800.00, 6400.00, '2025-07-07 10:00:00'),
('Rustic Gold Designs', 'Embracing rustic charm in modern gold jewelry designs', 'Rudra Patel', 'rudra.rusticgold@example.com', '+91 9876789012', 'https://www.rusticgolddesigns.com', 3200.00, 6400.00, '2025-07-07 10:00:00'),
('Golden Silhouettes', 'Crafting gold silhouettes that tell unique stories', 'Anika Verma', 'anika.goldensilhouettes@example.com', '+91 9878901234', 'https://www.goldensilhouettes.in', 1900.00, 6400.00, '2025-07-07 10:00:00');

-- Update for vendors table
UPDATE vendors SET created_at = '2025-07-07 10:00:00' WHERE vendor_id IN (1,2,3,4,5,6,7,8,9,10);
UPDATE vendors SET created_at = '2025-07-14 10:00:00' WHERE vendor_id IN (11,12,13,14,15,16,17,18,19,20);
UPDATE vendors SET created_at = '2025-07-21 10:00:00' WHERE vendor_id IN (21,22,23,24,25,26,27,28,29,30);
UPDATE vendors SET created_at = '2025-07-25 10:00:00' WHERE vendor_id IN (31,32,33,34,35,36,37,38,39,40);
UPDATE vendors SET created_at = '2025-07-29 10:00:00' WHERE vendor_id IN (41,42,43,44,45,46,47,48,49,50);



INSERT INTO vendor_branches (vendor_id, address_id, quantity, created_at)
VALUES
(1, 1, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(2, 2, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(3, 3, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(4, 4, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(5, 5, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(6, 6, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(7, 7, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(8, 8, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(9, 9, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(10, 10, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(11, 11, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(12, 12, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(13, 13, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(14, 14, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(15, 15, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(16, 16, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(17, 17, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(18, 18, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(19, 19, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(20, 20, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(21, 21, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(22, 22, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(23, 23, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(24, 24, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(25, 25, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(26, 26, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(27, 27, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(28, 28, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(29, 29, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(30, 30, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(31, 31, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(32, 32, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(33, 33, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(34, 34, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(35, 35, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(36, 36, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(37, 37, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(38, 38, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(39, 39, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(40, 40, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(41, 41, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(42, 42, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(43, 43, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(44, 44, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(45, 45, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(46, 46, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(47, 47, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(48, 48, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(49, 49, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00'),
(50, 50, FLOOR(RAND() * (2000 - 500 + 1)) + 500, '2025-07-07 10:00:00');

-- Update for vendor_branches table
UPDATE vendor_branches SET created_at = '2025-07-07 10:00:00' WHERE branch_id IN (1,2,3,4,5,6,7,8,9,10);
UPDATE vendor_branches SET created_at = '2025-07-14 10:00:00' WHERE branch_id IN (11,12,13,14,15,16,17,18,19,20);
UPDATE vendor_branches SET created_at = '2025-07-21 10:00:00' WHERE branch_id IN (21,22,23,24,25,26,27,28,29,30);
UPDATE vendor_branches SET created_at = '2025-07-25 10:00:00' WHERE branch_id IN (31,32,33,34,35,36,37,38,39,40);
UPDATE vendor_branches SET created_at = '2025-07-29 10:00:00' WHERE branch_id IN (41,42,43,44,45,46,47,48,49,50);



-- Insert users data into the users table
INSERT INTO users (email, name, address_id, balance, created_at) VALUES
('aman.gupta@example.in', 'Aman Gupta', 21, 5500.00, '2025-06-07 10:00:00'),
('bhuvan.sharma@example.in', 'Bhuvan Sharma', 22, 6800.00, '2025-06-07 10:00:00'),
('chitra.patel@example.in', 'Chitra Patel', 23, 3200.00, '2025-06-07 10:00:00'),
('dhruv.kumar@example.in', 'Dhruv Kumar', 24, 4700.00, '2025-06-07 10:00:00'),
('esha.verma@example.in', 'Esha Verma', 25, 5100.00, '2025-06-07 10:00:00'),
('faisal.ali@example.in', 'Faisal Ali', 26, 6200.00, '2025-06-07 10:00:00'),
('geeta.singh@example.in', 'Geeta Singh', 27, 2800.00, '2025-06-07 10:00:00'),
('hitesh.rawat@example.in', 'Hitesh Rawat', 28, 3900.00, '2025-06-07 10:00:00'),
('isha.joshi@example.in', 'Isha Joshi', 29, 4200.00, '2025-06-07 10:00:00'),
('jay.patel@example.in', 'Jay Patel', 30, 5800.00, '2025-06-07 10:00:00'),
('kavya.mehta@example.in', 'Kavya Mehta', 31, 3200.00, '2025-06-07 10:00:00'),
('lokesh.agarwal@example.in', 'Lokesh Agarwal', 32, 4700.00, '2025-06-07 10:00:00'),
('mira.sharma@example.in', 'Mira Sharma', 33, 3100.00, '2025-06-07 10:00:00'),
('nishit.gupta@example.in', 'Nishit Gupta', 34, 4600.00, '2025-06-07 10:00:00'),
('olivia.verma@example.in', 'Olivia Verma', 35, 3900.00, '2025-06-07 10:00:00'),
('pranav.kumar@example.in', 'Pranav Kumar', 36, 4300.00, '2025-06-07 10:00:00'),
('quincy.singh@example.in', 'Quincy Singh', 37, 5700.00, '2025-06-07 10:00:00'),
('rahul.thakur@example.in', 'Rahul Thakur', 38, 3800.00, '2025-06-07 10:00:00'),
('simran.agarwal@example.in', 'Simran Agarwal', 39, 4900.00, '2025-06-07 10:00:00'),
('tushar.jain@example.in', 'Tushar Jain', 40, 5400.00, '2025-06-07 10:00:00'),
('urvi.singh@example.in', 'Urvi Singh', 41, 2900.00, '2025-06-07 10:00:00'),
('vishal.rawat@example.in', 'Vishal Rawat', 42, 4700.00, '2025-06-07 10:00:00'),
('wafa.ali@example.in', 'Wafa Ali', 43, 3200.00, '2025-06-07 10:00:00'),
('xander.sharma@example.in', 'Xander Sharma', 44, 4100.00, '2025-06-07 10:00:00'),
('yamini.patel@example.in', 'Yamini Patel', 45, 3400.00, '2025-06-07 10:00:00'),
('zaid.kumar@example.in', 'Zaid Kumar', 46, 4600.00, '2025-06-07 10:00:00'),
('amisha.singh@example.in', 'Amisha Singh', 47, 5000.00, '2025-06-07 10:00:00'),
('bhavin.gupta@example.in', 'Bhavin Gupta', 48, 4300.00, '2025-06-07 10:00:00'),
('charul.joshi@example.in', 'Charul Joshi', 49, 4700.00, '2025-06-07 10:00:00'),
('deepak.rawat@example.in', 'Deepak Rawat', 50, 4100.00, '2025-06-07 10:00:00'),
('nishant.sharma@example.in', 'Nishant Sharma', 20, 1000.00, '2025-06-07 10:00:00'),
('oprah.verma@example.in', 'Oprah Verma', 25, 3500.00, '2025-06-07 10:00:00'),
('pradeep.kumar@example.in', 'Pradeep Kumar', 30, 20000.00, '2025-06-07 10:00:00'),
('queen.patel@example.in', 'Queen Patel', 35, 4000.00, '2025-06-07 10:00:00'),
('rajan.mehta@example.in', 'Rajan Mehta', 40, 4500.00, '2025-06-07 10:00:00'),
('sanya.jain@example.in', 'Sanya Jain', 45, 9000.00, '2025-06-07 10:00:00'),
('tarun.agarwal@example.in', 'Tarun Agarwal', 50, 1400.00, '2025-06-07 10:00:00'),
('urvashi.singh@example.in', 'Urvashi Singh', 1, 1800.00, '2025-06-07 10:00:00'),
('vijay.kapoor@example.in', 'Vijay Kapoor', 5, 6000.00, '2025-06-07 10:00:00'),
('wasiq.ali@example.in', 'Wasiq Ali', 10, 2500.00, '2025-06-07 10:00:00'),
('xena.thomas@example.in', 'Xena Thomas', 15, 3000.00, '2025-06-07 10:00:00'),
('yuvraj.singh@example.in', 'Yuvraj Singh', 20, 1500.00, '2025-06-07 10:00:00'),
('zara.kapoor@example.in', 'Zara Kapoor', 25, 4300.00, '2025-06-07 10:00:00'),
('arjun.sharma@example.in', 'Arjun Sharma', 30, 2100.00, '2025-06-07 10:00:00'),
('bhavna.mehta@example.in', 'Bhavna Mehta', 35, 1700.00, '2025-06-07 10:00:00'),
('chirag.agarwal@example.in', 'Chirag Agarwal', 40, 2300.00, '2025-06-07 10:00:00'),
('deepika.sharma@example.in', 'Deepika Sharma', 45, 1100.00, '2025-06-07 10:00:00'),
('ekta.patel@example.in', 'Ekta Patel', 50, 2000.00, '2025-06-07 10:00:00'),
('farhan.khan@example.in', 'Farhan Khan', 1, 6500.00, '2025-06-07 10:00:00'),
('gaurav.rawat@example.in', 'Gaurav Rawat', 5, 6800.00, '2025-06-07 10:00:00'),
('hema.gupta@example.in', 'Hema Gupta', 10, 1200.00, '2025-06-07 10:00:00'),
('ishan.singh@example.in', 'Ishan Singh', 15, 1900.00, '2025-06-07 10:00:00'),
('jyoti.yadav@example.in', 'Jyoti Yadav', 20, 1600.00, '2025-06-07 10:00:00'),
('kunal.shah@example.in', 'Kunal Shah', 25, 2100.00, '2025-06-07 10:00:00'),
('leena.nair@example.in', 'Leena Nair', 30, 1400.00, '2025-06-07 10:00:00'),
('mohan.goswami@example.in', 'Mohan Goswami', 35, 2000.00, '2025-06-07 10:00:00'),
('neha.verma@example.in', 'Neha Verma', 25, 1900.00, '2025-06-07 10:00:00'),
('omkar.singh@example.in', 'Omkar Singh', 30, 1400.00, '2025-06-07 10:00:00'),
('poonam.thakur@example.in', 'Poonam Thakur', 35, 1800.00, '2025-06-07 10:00:00'),
('qadir.khan@example.in', 'Qadir Khan', 40, 1600.00, '2025-06-07 10:00:00'),
('radha.mehta@example.in', 'Radha Mehta', 45, 2100.00, '2025-06-07 10:00:00'),
('suresh.gupta@example.in', 'Suresh Gupta', 50, 1400.00, '2025-06-07 10:00:00'),
('tara.kumar@example.in', 'Tara Kumar', 1, 2000.00, '2025-06-07 10:00:00'),
('umesh.agarwal@example.in', 'Umesh Agarwal', 5, 1500.00, '2025-06-07 10:00:00'),
('vidya.singh@example.in', 'Vidya Singh', 10, 1900.00, '2025-06-07 10:00:00'),
('waseem.ali@example.in', 'Waseem Ali', 15, 1400.00, '2025-06-07 10:00:00'),
('yogita.verma@example.in', 'Yogita Verma', 25, 1600.00, '2025-06-07 10:00:00'),
('zahir.khan@example.in', 'Zahir Khan', 30, 2100.00, '2025-06-07 10:00:00'),
('amrita.gupta@example.in', 'Amrita Gupta', 35, 1400.00, '2025-06-07 10:00:00'),
('brijesh.sharma@example.in', 'Brijesh Sharma', 40, 2000.00, '2025-06-07 10:00:00'),
('chhaya.verma@example.in', 'Chhaya Verma', 45, 1500.00, '2025-06-07 10:00:00'),
('darshan.mehta@example.in', 'Darshan Mehta', 50, 1900.00, '2025-06-07 10:00:00'),
('esha.singh@example.in', 'Esha Singh', 1, 1400.00, '2025-06-07 10:00:00'),
('farhan.thakur@example.in', 'Farhan Thakur', 5, 1800.00, '2025-06-07 10:00:00'),
('gita.agarwal@example.in', 'Gita Agarwal', 10, 1600.00, '2025-06-07 10:00:00'),
('harish.kumar@example.in', 'Harish Kumar', 15, 2100.00, '2025-06-07 10:00:00'),
('akash.sharma@example.in', 'Akash Sharma', 10, 1600.00, '2025-06-07 10:00:00'),
('bhavana.mehta@example.in', 'Bhavana Mehta', 15, 2100.00, '2025-06-07 10:00:00'),
('chetan.gupta@example.in', 'Chetan Gupta', 20, 1400.00, '2025-06-07 10:00:00'),
('disha.verma@example.in', 'Disha Verma', 25, 2000.00, '2025-06-07 10:00:00'),
('ekansh.thakur@example.in', 'Ekansh Thakur', 30, 1500.00, '2025-06-07 10:00:00'),
('farida.khan@example.in', 'Farida Khan', 35, 1900.00, '2025-06-07 10:00:00'),
('girish.agarwal@example.in', 'Girish Agarwal', 40, 1400.00, '2025-06-07 10:00:00'),
('hina.singh@example.in', 'Hina Singh', 45, 1800.00, '2025-06-07 10:00:00'),
('ishan.kumar@example.in', 'Ishan Kumar', 1, 1600.00, '2025-06-07 10:00:00'),
('juhi.mehta@example.in', 'Juhi Mehta', 5, 2100.00, '2025-06-07 10:00:00'),
('kamal.joshi@example.in', 'Kamal Joshi', 10, 1400.00, '2025-06-07 10:00:00'),
('lata.sharma@example.in', 'Lata Sharma', 15, 2000.00, '2025-06-07 10:00:00'),
('mohan.agarwal@example.in', 'Mohan Agarwal', 20, 1500.00, '2025-06-07 10:00:00');

-- Update for users table
UPDATE users SET created_at = '2025-06-07 10:00:00' WHERE user_id IN (1,2,3,4,5,6,7,8,9,10);
UPDATE users SET created_at = '2025-06-14 10:00:00' WHERE user_id IN (11,12,13,14,15,16,17,18,19,20);
UPDATE users SET created_at = '2025-06-21 10:00:00' WHERE user_id IN (21,22,23,24,25,26,27,28,29,30);
UPDATE users SET created_at = '2025-06-28 10:00:00' WHERE user_id IN (31,32,33,34,35,36,37,38,39,40);
UPDATE users SET created_at = '2025-07-04 10:00:00' WHERE user_id IN (41,42,43,44,45,46,47,48,49,50);
UPDATE users SET created_at = '2025-07-11 10:00:00' WHERE user_id IN (51,52,53,54,55,56,57,58,59,60);
UPDATE users SET created_at = '2025-07-18 10:00:00' WHERE user_id IN (61,62,63,64,65,66,67,68,69,70);
UPDATE users SET created_at = '2025-07-25 10:00:00' WHERE user_id IN (71,72,73,74,75,76,77,78,79,80);
UPDATE users SET created_at = '2025-05-01 10:00:00' WHERE user_id IN (81,82,83,84,85,86,87,88,89);



-- Insert data into the virtual_gold_holdings table
INSERT INTO virtual_gold_holdings (user_id, branch_id, quantity, created_at)
VALUES
(1, 1, 5.25, '2025-07-07 10:00:00'),
(2, 2, 8.75, '2025-07-07 10:00:00'),
(3, 3, 12.50, '2025-07-07 10:00:00'),
(4, 4, 6.30, '2025-07-07 10:00:00'),
(5, 5, 15.80, '2025-07-07 10:00:00'),
(6, 6, 3.90, '2025-07-07 10:00:00'),
(7, 7, 10.25, '2025-07-07 10:00:00'),
(8, 8, 7.75, '2025-07-07 10:00:00'),
(9, 9, 4.20, '2025-07-07 10:00:00'),
(10, 10, 9.60, '2025-07-07 10:00:00'),
(11, 11, 11.80, '2025-07-07 10:00:00'),
(12, 12, 14.00, '2025-07-07 10:00:00'),
(13, 13, 6.75, '2025-07-07 10:00:00'),
(14, 14, 8.40, '2025-07-07 10:00:00'),
(15, 15, 3.25, '2025-07-07 10:00:00'),
(16, 16, 10.50, '2025-07-07 10:00:00'),
(17, 17, 5.90, '2025-07-07 10:00:00'),
(18, 18, 12.75, '2025-07-07 10:00:00'),
(19, 19, 9.20, '2025-07-07 10:00:00'),
(20, 20, 7.00, '2025-07-07 10:00:00'),
(21, 21, 13.25, '2025-07-07 10:00:00'),
(22, 22, 8.90, '2025-07-07 10:00:00'),
(23, 23, 4.50, '2025-07-07 10:00:00'),
(24, 24, 11.30, '2025-07-07 10:00:00'),
(25, 25, 6.00, '2025-07-07 10:00:00'),
(26, 26, 14.50, '2025-07-07 10:00:00'),
(27, 27, 7.10, '2025-07-07 10:00:00'),
(28, 28, 9.75, '2025-07-07 10:00:00'),
(29, 29, 5.40, '2025-07-07 10:00:00'),
(30, 30, 12.00, '2025-07-07 10:00:00'),
(31, 31, 8.20, '2025-07-07 10:00:00'),
(32, 32, 5.75, '2025-07-07 10:00:00'),
(33, 33, 10.90, '2025-07-07 10:00:00'),
(34, 34, 3.40, '2025-07-07 10:00:00'),
(35, 35, 12.60, '2025-07-07 10:00:00'),
(36, 36, 6.80, '2025-07-07 10:00:00'),
(37, 37, 9.25, '2025-07-07 10:00:00'),
(38, 38, 14.50, '2025-07-07 10:00:00'),
(39, 39, 7.75, '2025-07-07 10:00:00'),
(40, 40, 4.30, '2025-07-07 10:00:00'),
(41, 41, 11.20, '2025-07-07 10:00:00'),
(42, 42, 8.60, '2025-07-07 10:00:00'),
(43, 43, 5.00, '2025-07-07 10:00:00'),
(44, 44, 13.75, '2025-07-07 10:00:00'),
(45, 45, 9.90, '2025-07-07 10:00:00'),
(46, 46, 7.15, '2025-07-07 10:00:00'),
(47, 47, 12.30, '2025-07-07 10:00:00'),
(48, 48, 5.60, '2025-07-07 10:00:00'),
(49, 49, 10.00, '2025-07-07 10:00:00'),
(50, 50, 6.50, '2025-07-07 10:00:00');

-- Update for virtual_gold_holdings table
UPDATE virtual_gold_holdings SET created_at = '2025-07-07 10:00:00' WHERE holding_id IN (1,2,3,4,5,6,7,8,9,10);
UPDATE virtual_gold_holdings SET created_at = '2025-07-14 10:00:00' WHERE holding_id IN (11,12,13,14,15,16,17,18,19,20);
UPDATE virtual_gold_holdings SET created_at = '2025-07-21 10:00:00' WHERE holding_id IN (21,22,23,24,25,26,27,28,29,30);
UPDATE virtual_gold_holdings SET created_at = '2025-07-25 10:00:00' WHERE holding_id IN (31,32,33,34,35,36,37,38,39,40);
UPDATE virtual_gold_holdings SET created_at = '2025-07-29 10:00:00' WHERE holding_id IN (41,42,43,44,45,46,47,48,49,50);



-- Insert data into the physical_gold_transactions table
INSERT INTO physical_gold_transactions (user_id, branch_id, quantity, delivery_address_id, created_at)
VALUES
(1, 1, 5.25, 1, '2025-07-07 10:00:00'),
(2, 2, 8.75, 5, '2025-07-07 10:00:00'),
(3, 3, 12.50, 10, '2025-07-07 10:00:00'),
(4, 4, 6.30, 15, '2025-07-07 10:00:00'),
(5, 5, 15.80, 20, '2025-07-07 10:00:00'),
(6, 6, 3.90, 25, '2025-07-07 10:00:00'),
(7, 7, 10.25, 30, '2025-07-07 10:00:00'),
(8, 8, 7.75, 35, '2025-07-07 10:00:00'),
(9, 9, 4.20, 40, '2025-07-07 10:00:00'),
(10, 10, 9.60, 45, '2025-07-07 10:00:00'),
(11, 11, 11.80, 1, '2025-07-07 10:00:00'),
(12, 12, 14.00, 5, '2025-07-07 10:00:00'),
(13, 13, 6.75, 10, '2025-07-07 10:00:00'),
(14, 14, 8.40, 15, '2025-07-07 10:00:00'),
(15, 15, 3.25, 20, '2025-07-07 10:00:00'),
(16, 16, 10.50, 25, '2025-07-07 10:00:00'),
(17, 17, 5.90, 30, '2025-07-07 10:00:00'),
(18, 18, 12.75, 35, '2025-07-07 10:00:00'),
(19, 19, 9.20, 40, '2025-07-07 10:00:00'),
(20, 20, 7.00, 45, '2025-07-07 10:00:00'),
(21, 21, 13.25, 1, '2025-07-07 10:00:00'),
(22, 22, 8.90, 5, '2025-07-07 10:00:00'),
(23, 23, 4.50, 10, '2025-07-07 10:00:00'),
(24, 24, 11.30, 15, '2025-07-07 10:00:00'),
(25, 25, 6.00, 20, '2025-07-07 10:00:00'),
(26, 26, 14.50, 25, '2025-07-07 10:00:00'),
(27, 27, 7.10, 30, '2025-07-07 10:00:00'),
(28, 28, 9.75, 35, '2025-07-07 10:00:00'),
(29, 29, 5.40, 40, '2025-07-07 10:00:00'),
(30, 30, 12.00, 45, '2025-07-07 10:00:00'),
(31, 31, 8.20, 1, '2025-07-07 10:00:00'),
(32, 32, 5.75, 5, '2025-07-07 10:00:00'),
(33, 33, 10.90, 10, '2025-07-07 10:00:00'),
(34, 34, 3.40, 15, '2025-07-07 10:00:00'),
(35, 35, 12.60, 20, '2025-07-07 10:00:00'),
(36, 36, 6.80, 25, '2025-07-07 10:00:00'),
(37, 37, 9.25, 30, '2025-07-07 10:00:00'),
(38, 38, 14.50, 35, '2025-07-07 10:00:00'),
(39, 39, 7.75, 40, '2025-07-07 10:00:00'),
(40, 40, 4.30, 45, '2025-07-07 10:00:00'),
(41, 41, 11.20, 1, '2025-07-07 10:00:00'),
(42, 42, 8.60, 5, '2025-07-07 10:00:00'),
(43, 43, 5.00, 10, '2025-07-07 10:00:00'),
(44, 44, 13.75, 15, '2025-07-07 10:00:00'),
(45, 45, 9.90, 20, '2025-07-07 10:00:00'),
(46, 46, 7.15, 25, '2025-07-07 10:00:00'),
(47, 47, 12.30, 30, '2025-07-07 10:00:00'),
(48, 48, 5.60, 35, '2025-07-07 10:00:00'),
(49, 49, 10.00, 40, '2025-07-07 10:00:00'),
(50, 50, 6.50, 45, '2025-07-07 10:00:00');

-- Update for physical_gold_transactions table
UPDATE physical_gold_transactions SET created_at = '2025-07-07 10:00:00' WHERE transaction_id IN (1,2,3,4,5,6,7,8,9,10);
UPDATE physical_gold_transactions SET created_at = '2025-07-14 10:00:00' WHERE transaction_id IN (11,12,13,14,15,16,17,18,19,20);
UPDATE physical_gold_transactions SET created_at = '2025-07-21 10:00:00' WHERE transaction_id IN (21,22,23,24,25,26,27,28,29,30);
UPDATE physical_gold_transactions SET created_at = '2025-07-25 10:00:00' WHERE transaction_id IN (31,32,33,34,35,36,37,38,39,40);
UPDATE physical_gold_transactions SET created_at = '2025-07-29 10:00:00' WHERE transaction_id IN (41,42,43,44,45,46,47,48,49,50);



-- Insert payments data into the payments table
INSERT INTO payments (user_id, amount, payment_method, transaction_type, payment_status, created_at)
VALUES
(1, 54504, 'PhonePe', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(2, 23956, 'PhonePe', 'DebitedFromWallet', 'Success', '2025-07-07 10:00:00'),
(3, 6342, 'GooglePay', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(4, 94544, 'CreditCard', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(5, 7484, 'PhonePe', 'CreditedToWallet', 'Failed', '2025-07-07 10:00:00'),
(6, 43433, 'CreditCard', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(7, 77473, 'CreditCard', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(8, 82021, 'GooglePay', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(9, 61219, 'PhonePe', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(10, 97210, 'BankTransfer', 'CreditedToWallet', 'Failed', '2025-07-07 10:00:00'),
(11, 45873, 'GooglePay', 'CreditedToWallet', 'Failed', '2025-07-07 10:00:00'),
(12, 4132, 'GooglePay', 'DebitedFromWallet', 'Success', '2025-07-07 10:00:00'),
(13, 29025, 'CreditCard', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(14, 41152, 'PhonePe', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(15, 62672, 'PhonePe', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(16, 95167, 'GooglePay', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(17, 24059, 'CreditCard', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(18, 29615, 'GooglePay', 'DebitedFromWallet', 'Success', '2025-07-07 10:00:00'),
(19, 62602, 'BankTransfer', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(20, 62397, 'CreditCard', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(21, 60312, 'PhonePe', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(22, 71595, 'PhonePe', 'CreditedToWallet', 'Failed', '2025-07-07 10:00:00'),
(23, 42414, 'BankTransfer', 'CreditedToWallet', 'Failed', '2025-07-07 10:00:00'),
(24, 3192, 'BankTransfer', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(25, 11349, 'CreditCard', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(26, 25229, 'BankTransfer', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(27, 50324, 'BankTransfer', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(28, 52853, 'CreditCard', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(29, 42622, 'PhonePe', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(30, 2490, 'BankTransfer', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(31, 70667, 'CreditCard', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(32, 10523, 'GooglePay', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(33, 53244, 'CreditCard', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(34, 97184, 'GooglePay', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(35, 53922, 'PhonePe', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(36, 28031, 'BankTransfer', 'DebitedFromWallet', 'Success', '2025-07-07 10:00:00'),
(37, 54045, 'GooglePay', 'CreditedToWallet', 'Failed', '2025-07-07 10:00:00'),
(38, 66364, 'PhonePe', 'DebitedFromWallet', 'Success', '2025-07-07 10:00:00'),
(39, 83344, 'GooglePay', 'DebitedFromWallet', 'Success', '2025-07-07 10:00:00'),
(40, 14595, 'PhonePe', 'CreditedToWallet', 'Failed', '2025-07-07 10:00:00'),
(41, 45251, 'PhonePe', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(42, 26667, 'CreditCard', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(43, 51760, 'PhonePe', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(44, 54783, 'CreditCard', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(45, 27614, 'PhonePe', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00'),
(46, 33192, 'PhonePe', 'DebitedFromWallet', 'Failed', '2025-07-07 10:00:00'),
(47, 4920, 'PhonePe', 'DebitedFromWallet', 'Success', '2025-07-07 10:00:00'),
(48, 93530, 'BankTransfer', 'DebitedFromWallet', 'Success', '2025-07-07 10:00:00'),
(49, 92280, 'PhonePe', 'DebitedFromWallet', 'Success', '2025-07-07 10:00:00'),
(50, 60340, 'GooglePay', 'CreditedToWallet', 'Success', '2025-07-07 10:00:00');

-- Update for payments table
UPDATE payments SET created_at = '2025-07-07 10:00:00' WHERE payment_id IN (1,2,3,4,5,6,7,8,9,10);
UPDATE payments SET created_at = '2025-07-14 10:00:00' WHERE payment_id IN (11,12,13,14,15,16,17,18,19,20);
UPDATE payments SET created_at = '2025-07-21 10:00:00' WHERE payment_id IN (21,22,23,24,25,26,27,28,29,30);
UPDATE payments SET created_at = '2025-07-25 10:00:00' WHERE payment_id IN (31,32,33,34,35,36,37,38,39,40);
UPDATE payments SET created_at = '2025-07-29 10:00:00' WHERE payment_id IN (41,42,43,44,45,46,47,48,49,50);



-- Insert transaction history data into the transaction_history table
INSERT INTO transaction_history (user_id, branch_id, transaction_type, transaction_status, quantity, amount, created_at)
VALUES
(1, 1, 'Buy', 'Success', 25.0, 142500.00, '2025-07-07 10:00:00'),
(2, 2, 'Sell', 'Success', 18.0, 102600.00, '2025-07-07 10:00:00'),
(3, 3, 'ConvertToPhysical', 'Success', 30.0, 171000.00, '2025-07-07 10:00:00'),
(4, 4, 'Buy', 'Success', 15.0, 85500.00, '2025-07-07 10:00:00'),
(5, 5, 'Sell', 'Success', 20.0, 114000.00, '2025-07-07 10:00:00'),
(6, 6, 'ConvertToPhysical', 'Success', 22.0, 125400.00, '2025-07-07 10:00:00'),
(7, 7, 'Buy', 'Success', 35.0, 199500.00, '2025-07-07 10:00:00'),
(8, 8, 'Sell', 'Success', 10.0, 57000.00, '2025-07-07 10:00:00'),
(9, 9, 'ConvertToPhysical', 'Success', 28.0, 159600.00, '2025-07-07 10:00:00'),
(10, 10, 'Buy', 'Success', 20.0, 114000.00, '2025-07-07 10:00:00'),
(11, 11, 'Sell', 'Success', 12.0, 68400.00, '2025-07-07 10:00:00'),
(12, 12, 'ConvertToPhysical', 'Success', 32.0, 182400.00, '2025-07-07 10:00:00'),
(13, 13, 'Buy', 'Success', 25.0, 142500.00, '2025-07-07 10:00:00'),
(14, 14, 'Sell', 'Success', 18.0, 102600.00, '2025-07-07 10:00:00'),
(15, 15, 'ConvertToPhysical', 'Success', 20.0, 114000.00, '2025-07-07 10:00:00'),
(16, 16, 'Buy', 'Success', 15.0, 85500.00, '2025-07-07 10:00:00'),
(17, 17, 'Sell', 'Success', 22.0, 125400.00, '2025-07-07 10:00:00'),
(18, 18, 'ConvertToPhysical', 'Success', 30.0, 171000.00, '2025-07-07 10:00:00'),
(19, 19, 'Buy', 'Success', 28.0, 159600.00, '2025-07-07 10:00:00'),
(20, 20, 'Sell', 'Success', 10.0, 57000.00, '2025-07-07 10:00:00'),
(21, 21, 'Buy', 'Failed', 35.0, 199500.00, '2025-07-07 10:00:00'),
(22, 22, 'Sell', 'Failed', 12.0, 68400.00, '2025-07-07 10:00:00'),
(23, 23, 'ConvertToPhysical', 'Failed', 25.0, 142500.00, '2025-07-07 10:00:00'),
(24, 24, 'Buy', 'Failed', 20.0, 114000.00, '2025-07-07 10:00:00'),
(25, 25, 'Sell', 'Failed', 32.0, 182400.00, '2025-07-07 10:00:00'),
(26, 26, 'ConvertToPhysical', 'Failed', 18.0, 102600.00, '2025-07-07 10:00:00'),
(27, 27, 'Buy', 'Failed', 22.0, 125400.00, '2025-07-07 10:00:00'),
(28, 28, 'Sell', 'Failed', 28.0, 159600.00, '2025-07-07 10:00:00'),
(29, 29, 'ConvertToPhysical', 'Failed', 10.0, 57000.00, '2025-07-07 10:00:00'),
(30, 30, 'Buy', 'Failed', 1.0, 5700.00, '2025-07-07 10:00:00'),
(31, 31, 'Buy', 'Success', 14.0, 79800.00, '2025-07-07 10:00:00'),
(32, 32, 'Sell', 'Success', 25.0, 142500.00, '2025-07-07 10:00:00'),
(33, 33, 'ConvertToPhysical', 'Success', 18.0, 102600.00, '2025-07-07 10:00:00'),
(34, 34, 'Buy', 'Success', 30.0, 171000.00, '2025-07-07 10:00:00'),
(35, 35, 'Sell', 'Success', 20.0, 114000.00, '2025-07-07 10:00:00'),
(36, 36, 'ConvertToPhysical', 'Success', 22.0, 125400.00, '2025-07-07 10:00:00'),
(37, 37, 'Buy', 'Success', 25.0, 142500.00, '2025-07-07 10:00:00'),
(38, 38, 'Sell', 'Success', 15.0, 85500.00, '2025-07-07 10:00:00'),
(39, 39, 'ConvertToPhysical', 'Success', 28.0, 159600.00, '2025-07-07 10:00:00'),
(40, 40, 'Buy', 'Success', 20.0, 114000.00, '2025-07-07 10:00:00'),
(41, 41, 'Sell', 'Success', 12.0, 68400.00, '2025-07-07 10:00:00'),
(42, 42, 'ConvertToPhysical', 'Success', 32.0, 182400.00, '2025-07-07 10:00:00'),
(43, 43, 'Buy', 'Success', 25.0, 142500.00, '2025-07-07 10:00:00'),
(44, 44, 'Sell', 'Success', 18.0, 102600.00, '2025-07-07 10:00:00'),
(45, 45, 'ConvertToPhysical', 'Success', 20.0, 114000.00, '2025-07-07 10:00:00'),
(46, 46, 'Buy', 'Success', 15.0, 85500.00, '2025-07-07 10:00:00'),
(47, 47, 'Sell', 'Success', 22.0, 125400.00, '2025-07-07 10:00:00'),
(48, 48, 'ConvertToPhysical', 'Success', 30.0, 171000.00, '2025-07-07 10:00:00'),
(49, 49, 'Buy', 'Success', 28.0, 159600.00, '2025-07-07 10:00:00'),
(50, 50, 'Sell', 'Success', 10.0, 57000.00, '2025-07-07 10:00:00');

-- Update for transaction_history table
UPDATE transaction_history SET created_at = '2025-07-07 10:00:00' WHERE transaction_id IN (1,2,3,4,5,6,7,8,9,10);
UPDATE transaction_history SET created_at = '2025-07-14 10:00:00' WHERE transaction_id IN (11,12,13,14,15,16,17,18,19,20);
UPDATE transaction_history SET created_at = '2025-07-21 10:00:00' WHERE transaction_id IN (21,22,23,24,25,26,27,28,29,30);
UPDATE transaction_history SET created_at = '2025-07-25 10:00:00' WHERE transaction_id IN (31,32,33,34,35,36,37,38,39,40);
UPDATE transaction_history SET created_at = '2025-07-29 10:00:00' WHERE transaction_id IN (41,42,43,44,45,46,47,48,49,50);



SELECT * FROM addresses;
SELECT * FROM payments;
SELECT * FROM physical_gold_transactions;
SELECT * FROM transaction_history;
SELECT * FROM users;
SELECT * FROM vendor_branches;
SELECT * FROM vendors;
SELECT * FROM virtual_gold_holdings;