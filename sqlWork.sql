
      CREATE DATABASE IF NOT EXISTS HumanFriends;
      USE HumanFriends;


   CREATE TABLE Commands
   (
       id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
       name varchar(30),
       description varchar(255)
   );


   CREATE TABLE AnimalGroup
   (
       id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
       name varchar(30)
   );

   CREATE TABLE AnimalGenius
   (
       id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
       name varchar(30),
       group_id INT,
       FOREIGN KEY (group_id) REFERENCES AnimalGroup (id)
       ON DELETE NO ACTION ON UPDATE CASCADE
   );

   CREATE TABLE KennelAnimal
   (
       id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
       name varchar(30),
       birthDate DATE,
       genius_id INT,
       FOREIGN KEY (genius_id) REFERENCES AnimalGenius (id)
       ON DELETE NO ACTION ON UPDATE CASCADE
   );

   CREATE TABLE AnimalCommands
   (
       animal_id INT NOT NULL,
       command_id INT NOT NULL,

       PRIMARY KEY (animal_id, command_id),
       FOREIGN KEY (animal_id) REFERENCES KennelAnimal (id)
        ON DELETE NO ACTION ON UPDATE CASCADE,
       FOREIGN KEY (command_id) REFERENCES Commands (id)
        ON DELETE NO ACTION  ON UPDATE CASCADE
   );
    
            
    USE HumanFriends;

   INSERT INTO commands(name)
   VALUES
    ('Принести вещи'),
    ('Вертеться в колесе'),
    ('Галоп!'),
    ('Поклон!'),
    ('КАШ!');

   INSERT INTO AnimalGroup (name)
   VALUES
    ('Вьючные животные'),
    ('Домашние животные');

   INSERT INTO AnimalGenius (name, group_id)
   VALUES
    ('Лошадь', 1),
    ('Верблюд', 1),
    ('Осел', 1),
    ('Кошка', 2),
    ('Собака', 2),
    ('Хомяк', 2);

   INSERT INTO KennelAnimal (name, birthDate, genius_id)
   VALUES
    ('Гнедой', '2021-02-04', 1),
    ('Гнедой_2', '2022-12-01', 1),
    ('Тупица', '2020-08-24', 3),
    ('Рыжий', '2022-05-20', 2),
    ('Песик', '2023-01-24', 5),
    ('Хомяк', '2022-12-20', 6),
    ('Эльза', '2022-07-12', 4);

   INSERT INTO AnimalCommands (animal_id, command_id)
   VALUES
    (1, 3), (2, 3), (2, 4), (3, 4),
    (4, 5), (5, 1), (5, 4), (6, 2),
    (7, 1);
    
    
     USE HumanFriends;
   DELETE FROM KennelAnimal WHERE genius_id = 2;

   CREATE TABLE HorseAndDonkey AS
   SELECT * from KennelAnimal WHERE genius_id = 1
   UNION
   SELECT * from KennelAnimal WHERE genius_id = 3;
   
   
   CREATE TABLE YoungAnimals AS
      SELECT id, name, birthDate, 
      datediff(curdate(),birthDate) DIV 31 as age, genius_id 
      from KennelAnimal 
      WHERE date_add(birthDate, INTERVAL 1 YEAR) < curdate() 
            AND date_add(birthDate, INTERVAL 3 YEAR) > curdate();
            
             SELECT id, name, birthDate, genius_id FROM HorseDonkey
   UNION
   SELECT id, name, birthDate, genius_id FROM YoungAnimals;