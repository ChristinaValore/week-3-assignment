/*Christina Valore
Winter Bridge 2019
1/13/19*/

/*Link to GitHub project: https://github.com/ChristinaValore/week-3-assignment */

/*An organization grants key-card access to rooms based on groups that key-card holders belong to. You may assume that
users below to only one group. Your job is to design the database that supports the key-card system.
There are six users, and four groups. Modesto and Ayine are in group “I.T.” Christopher and Cheong woo are in group
“Sales”. There are four rooms: “101”, “102”, “Auditorium A”, and “Auditorium B”. Saulat is in group
“Administration.” Group “Operations” currently doesn’t have any users assigned. I.T. should be able to access Rooms
101 and 102. Sales should be able to access Rooms 102 and Auditorium A. Administration does not have access to any
rooms. Heidy is a new employee, who has not yet been assigned to any group.*/

CREATE SCHEMA IF NOT EXISTS keycard;
USE keycard;

CREATE TABLE groups (ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, NAME VARCHAR(255) );
CREATE TABLE users (ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, NAME VARCHAR(255), group_id INT, foreign key (group_id) REFERENCES groups(ID));
CREATE TABLE rooms (ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, NAME VARCHAR(255) );
CREATE TABLE group_rooms (group_id INT NOT NULL, 
FOREIGN KEY (group_id) REFERENCES groups(ID),
 room_id INT NOT NULL, 
FOREIGN KEY (room_id) REFERENCES rooms(ID) );

INSERT INTO groups (NAME) VALUES ('I.T.'), ('Sales'), ('Administration'), ('Operations');
INSERT INTO rooms (NAME) VALUES ('101'), ('102'), ('Auditorium A'), ('Auditorium B');
INSERT INTO group_rooms (group_id, room_id) VALUES (1,1),(1,2),(2,2),(2,3);
INSERT INTO users (NAME, group_id) VALUES ('Modesto', 1), ('Ayine', 1), ('Christopher', 2), ('Cheong woo', 2), ('Saulat', 3), ('Heidy', NULL);

/*All groups, and the users in each group. A group should appear even if there are no users assigned to the group.*/
SELECT * FROM groups G LEFT JOIN users U ON G.ID = group_id;

/*All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been
assigned to them*/
SELECT * FROM rooms R LEFT OUTER JOIN group_rooms GR ON R.ID = GR.room_id LEFT OUTER JOIN groups G ON GR.group_id = G.ID;

/*A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
alphabetically by user, then by group, then by room*/
SELECT * FROM users U LEFT OUTER JOIN groups G ON U.group_id = G.ID 
LEFT OUTER JOIN group_rooms GR ON U.group_id = GR.group_id LEFT OUTER JOIN rooms R ON GR.room_id = R.ID
ORDER BY U.NAME, G.NAME, R.NAME;