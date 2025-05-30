Create database Event_Management;
Use Event_Management; 
---  Events Table Creation 
CREATE TABLE Events (
    Event_Id INT AUTO_INCREMENT PRIMARY KEY,
    Event_Name VARCHAR(100),
    Event_Date DATE,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);

---- Attendees table creation 

CREATE TABLE Attendees (
    Attendee_Id INT AUTO_INCREMENT PRIMARY KEY,
    Attendee_Name VARCHAR(100),
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(100),
    Attendee_City VARCHAR(50)
);

---- Registrations table creation

CREATE TABLE Registrations(
    Registration_Id INT AUTO_INCREMENT PRIMARY KEY,
    Event_Id INT,
    Attendee_Id INT,
    Registration_Date DATE,
    Registration_Amount DECIMAL(10,2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
); 

----2.Data Creation 

---- Insert some sample data for Events

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES 
('Mumbai Tech Conference', '2025-07-15', 'Mumbai', 'A technology summit focused on AI and startups.'),
('Delhi Business Expo', '2025-08-10', 'New Delhi', 'An event showcasing Indian businesses and entrepreneurs.'),
('Hyderabad Food Fest', '2025-09-20', 'Hyderabad', 'A festival celebrating Indian street food and cuisines.');

---- Insert some sample data for Attendees

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES 
('Ravi Kumar', '9876543210', 'ravi.kumar@gmail.com', 'Bangalore'),
('Priya Sharma', '9123456780', 'priya.sharma@gmail.com', 'Mumbai'),
('Amit Verma', '9988776655', 'amit.verma@gmail.com', 'Delhi');
 
 ---- Insert some sample data for Registrations  
 
 INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES 
(1, 1, '2025-06-01', 1500.00),
(2, 2, '2025-06-02', 2000.00),
(1, 3, '2025-06-03', 1500.00);

---- 3.Manage Event Details (a- Inserting a new event.)

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES ('Chennai Art Carnival', '2025-10-05', 'Chennai', 'A cultural event showcasing Indian art.');

---- 3.Manage Event Details (b- Updating an event's information.)

UPDATE Events
SET Event_Description = 'India’s largest cultural and technology festival.'
WHERE Event_Name = 'Mumbai Tech Conference';



----- 3.Manage Event Details( C-Deleting an event.) - Note: Coudn't delete and explained the details below:

----  error Cannot delete or update a parent row: a foreign key constraint fails (event_management.registrations, CONSTRAINT registrations_ibfk_1 FOREIGN KEY (Event_Id) REFERENCES events (Event_Id))
-- Hence to perform this -- 

----- First need to delete the related records from registrations table
DELETE FROM registrations 
WHERE Event_Id = (SELECT Event_Id FROM Events WHERE Event_Name = 'Delhi Business Expo');

-- Then delete using below commands

DELETE FROM Events 
WHERE Event_Name = 'Delhi Business Expo';


---- 4. Manage Track Attendees & Handle Events (a- Inserting a new attendee.

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('Sunita Joshi', '9012345678', 'sunita.joshi@gmail.com', 'Pune');

---- 4. Manage Track Attendees & Handle Events (b- Registering an attendee for an event.)

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (3, 4, '2025-06-05', 1200.00);

----- 5.Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics.

--- Retrieve all event information

SELECT * FROM Events;

----- generate attendee lists

SELECT * FROM Attendees;

----- calculate event attendance statistics

SELECT 
    E.Event_Name,
    COUNT(R.Registration_Id) AS Total_Attendees
FROM 
    Events E
LEFT JOIN 
    Registrations R ON E.Event_Id = R.Event_Id
GROUP BY 
    E.Event_Id, E.Event_Name;