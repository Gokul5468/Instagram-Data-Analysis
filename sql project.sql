-- Drop the database if it already exists to start fresh
DROP DATABASE IF EXISTS ig_clone;

-- Create the database
CREATE DATABASE ig_clone;

-- Select the database to use for subsequent commands
USE ig_clone;

-- Users Table: Stores user account information.
CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

-- Photos Table: Stores information about each photo uploaded.
CREATE TABLE photos(
	id INT AUTO_INCREMENT PRIMARY KEY,
	image_url VARCHAR(355) NOT NULL,
	user_id INT NOT NULL,
	-- Corrected typo from 'created_dat' to 'created_at'
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Comments Table: Stores comments made by users on photos.
CREATE TABLE comments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY(photo_id) REFERENCES photos(id) ON DELETE CASCADE
);

-- Likes Table: Tracks which user liked which photo.
CREATE TABLE likes(
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY(photo_id) REFERENCES photos(id) ON DELETE CASCADE,
    -- Composite primary key prevents a user from liking the same photo more than once.
	PRIMARY KEY(user_id, photo_id)
);

-- Follows Table: Tracks follower/followee relationships.
CREATE TABLE follows(
	follower_id INT NOT NULL,
	followee_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(follower_id) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY(followee_id) REFERENCES users(id) ON DELETE CASCADE,
    -- Composite primary key prevents a user from following the same person more than once.
	PRIMARY KEY(follower_id, followee_id)
);

-- Tags Table: Stores a unique list of all hashtags.
CREATE TABLE tags(
	id INT AUTO_INCREMENT PRIMARY KEY,
	tag_name VARCHAR(255) UNIQUE,
	created_at TIMESTAMP DEFAULT NOW()
);

-- Photo_Tags Table (Junction Table): Links photos and tags in a many-to-many relationship.
CREATE TABLE photo_tags(
	photo_id INT NOT NULL,
	tag_id INT NOT NULL,
	FOREIGN KEY(photo_id) REFERENCES photos(id) ON DELETE CASCADE,
	FOREIGN KEY(tag_id) REFERENCES tags(id) ON DELETE CASCADE,
    -- Composite primary key prevents a tag from being added to the same photo more than once.
	PRIMARY KEY(photo_id, tag_id)
);


-- Inserting sample data into all tables (provided data is used here)
INSERT INTO users (username) VALUES
('Kenton_Kirlin'), ('Andre_Purdy85'), ('Harley_Lind18'), ('Arely_Bogan63'),
('Aniya_Hackett'), ('Travon.Waters'), ('Kasandra_Homenick'), ('Tabitha_Schamberger11'),
('Gus93'), ('Presley_McClure'), ('Justina.Gaylord27'), ('Dereck65'),
('Alexandro35'), ('Jaclyn81'), ('Billy52'), ('Annalise.McKenzie16'),
('Norbert_Carroll35'), ('Odessa2'), ('Hailee26'), ('Delpha.Kihn'),
('Rocio33'), ('Kenneth64'), ('Eveline95'), ('Maxwell.Halvorson'),
('Tierra.Trantow'), ('Josianne.Friesen'), ('Darwin29'), ('Dario77'),
('Jaime53'), ('Kaley9'), ('Aiyana_Hoeger'), ('Irwin.Larson'),
('Yvette.Gottlieb91'), ('Pearl7'), ('Lennie_Hartmann40'), ('Ollie_Ledner37'),
('Yazmin_Mills95'), ('Jordyn.Jacobson2'), ('Kelsi26'), ('Rafael.Hickle2'),
('Mckenna17'), ('Maya.Farrell'), ('Janet.Armstrong'), ('Seth46'),
('David.Osinski47'), ('Malinda_Streich'), ('Harrison.Beatty50'), ('Granville_Kutch'),
('Morgan.Kassulke'), ('Gerard79'), ('Mariano_Koch3'), ('Zack_Kemmer93'),
('Linnea59'), ('Duane60'), ('Meggie_Doyle'), ('Peter.Stehr0'),
('Julien_Schmidt'), ('Aurelie71'), ('Cesar93'), ('Sam52'),
('Jayson65'), ('Ressie_Stanton46'), ('Elenor88'), ('Florence99'),
('Adelle96'), ('Mike.Auer39'), ('Emilio_Bernier52'), ('Franco_Keebler64'),
('Karley_Bosco'), ('Erick5'), ('Nia_Haag'), ('Kathryn80'),
('Jaylan.Lakin'), ('Hulda.Macejkovic'), ('Leslie67'), ('Janelle.Nikolaus81'),
('Donald.Fritsch'), ('Colten.Harris76'), ('Katarina.Dibbert'), ('Darby_Herzog'),
('Esther.Zulauf61'), ('Aracely.Johnston98'), ('Bartholome.Bernhard'), ('Alysa22'),
('Milford_Gleichner42'), ('Delfina_VonRueden68'), ('Rick29'), ('Clint27'),
('Jessyca_West'), ('Esmeralda.Mraz57'), ('Bethany20'), ('Frederik_Rice'),
('Willie_Leuschke'), ('Damon35'), ('Nicole71'), ('Keenan.Schamberger60'),
('Tomas.Beatty93'), ('Imani_Nicolas17'), ('Alek_Watsica'), ('Javonte83');

INSERT INTO photos (image_url, user_id) VALUES
('http://elijah.biz', 1),('https://shanon.org', 1),('http://vicky.biz', 1),
('http://oleta.net', 1),('https://jennings.biz', 1),('https://quinn.biz', 2),
('https://selina.name', 2),('http://malvina.org', 2),('https://branson.biz', 2),
('https://elenor.name', 3),('https://marcelino.com', 3),('http://felicity.name', 3),
('https://fred.com', 3),('https://gerhard.biz', 4),('https://sherwood.net', 4),
('https://maudie.org', 4),('http://annamae.name', 6),('https://mac.org', 6),
('http://miracle.info', 6),('http://emmet.com', 6),('https://lisa.com', 6),
('https://brooklyn.name', 8),('http://madison.net', 8),('http://annie.name', 8),
('http://darron.info', 8),('http://saige.com', 9),('https://reece.net', 9),
('http://vance.org', 9),('http://ignacio.net', 9),('http://kenny.com', 10);
-- NOTE: The rest of your large INSERT statements would go here.
-- For brevity, I've truncated them, but your full script would include all of them.

INSERT INTO comments (comment_text, user_id, photo_id) VALUES
('unde at dolorem', 2, 1),('quae ea ducimus', 3, 1),('alias a voluptatum', 5, 1),
('facere suscipit sunt', 14, 1),('totam eligendi quaerat', 17, 1);

INSERT INTO likes (user_id, photo_id) VALUES
(2, 1),(5, 1),(9, 1),(10, 1),(11, 1),(14, 1),(19, 1),(21, 1),(24, 1),(35, 1),
(3, 2),(5, 2),(6, 2),(8, 2),(14, 2),(17, 2),(19, 2),(21, 2);

INSERT INTO follows (follower_id, followee_id) VALUES
(2, 1),(2, 3),(2, 4),(2, 5),(2, 6),(3, 1),(3, 2),(3, 4);

INSERT INTO tags (tag_name) VALUES
('sunset'),('photography'),('sunrise'),('landscape'),('food'),('foodie'),
('delicious'),('beauty'),('stunning'),('dreamy'),('lol'),('happy'),('fun'),
('style'),('hair'),('fashion'),('party'),('concert'),('drunk'),('beach'),('smile');

INSERT INTO photo_tags (photo_id, tag_id) VALUES
(1, 18),(1, 17),(1, 21),(1, 13),(1, 19),(2, 4),(2, 3),(2, 20),(2, 2),(3, 8);

/* ------- ANALYTICAL QUERIES ------- */

-- 1. Find the 5 oldest users to reward them.
SELECT 
    username, 
    created_at
FROM users
ORDER BY created_at ASC
LIMIT 5;

-- 2. Find the most popular day of the week for registrations to schedule an ad campaign.
SELECT 
    DAYNAME(created_at) AS day_of_week,
    COUNT(*) AS total_registrations
FROM users
GROUP BY day_of_week
ORDER BY total_registrations DESC
LIMIT 1;

-- 3. Find users who have never posted a photo to target them with an email campaign.
SELECT username
FROM users
LEFT JOIN photos 
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- 4. Find the winner of the photo contest (photo with the most likes).
SELECT 
    u.username,
    p.image_url,
    COUNT(l.user_id) AS total_likes
FROM photos p
JOIN likes l 
    ON p.id = l.photo_id
JOIN users u 
    ON p.user_id = u.id
GROUP BY p.id
ORDER BY total_likes DESC
LIMIT 1;

-- 5. Calculate the average number of posts per user.
SELECT 
    ROUND((SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users), 2) AS avg_posts_per_user;

-- 6. Find the top 5 most used hashtags for a brand partnership.
SELECT 
    t.tag_name,
    COUNT(pt.photo_id) AS tag_count
FROM tags t
JOIN photo_tags pt 
    ON t.id = pt.tag_id
GROUP BY t.tag_name
ORDER BY tag_count DESC
LIMIT 5;

-- 7. Identify bots: users who have liked every single photo on the site.
SELECT 
    u.username
FROM users u
JOIN likes l 
    ON u.id = l.user_id
GROUP BY u.id
HAVING COUNT(DISTINCT l.photo_id) = (SELECT COUNT(*) FROM photos);

-- 8. Identify potential "celebrity" accounts: users who have never commented on any photo.
-- Corrected Query Logic:
SELECT u.username
FROM users u
LEFT JOIN comments c 
    ON u.id = c.user_id
WHERE c.id IS NULL;

-- 9. Mega Challenge: Analyze user engagement by finding the percentage of users who have never commented.
-- Corrected and simplified query:
SELECT
    COUNT(CASE WHEN c.id IS NULL THEN u.id ELSE NULL END) AS users_who_never_commented,
    COUNT(u.id) AS total_users,
    (COUNT(CASE WHEN c.id IS NULL THEN u.id ELSE NULL END) / COUNT(u.id)) * 100 AS percentage_inactive
FROM users u
LEFT JOIN (
    SELECT DISTINCT user_id, id FROM comments
) AS c ON u.id = c.user_id;

