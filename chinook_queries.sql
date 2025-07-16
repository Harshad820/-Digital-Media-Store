USE CHINOOK;

-- 1. List all customers and their associated employee support representatives.
SELECT c.FirstName AS CustomerFirstName, c.LastName AS CustomerLastName, e.FirstName AS SupportRepFirstName, e.LastName AS SupportRepLastName
FROM customer c
JOIN employee e ON c.SupportRepId = e.EmployeeId;

-- 2. Retrieve all invoices with total amounts greater than $100.
SELECT * FROM invoice WHERE Total > 100;

-- 3. Show the number of customers per country.
SELECT Country, COUNT(CustomerId) AS NumberOfCustomers FROM customer GROUP BY Country;

-- 4. Get a list of all genres available in the database.
SELECT * FROM genre;

-- 5. Display all tracks that cost more than $0.99.
SELECT * FROM track WHERE UnitPrice > 0.99;

-- 6. Find the top 5 customers who have spent the most.
SELECT C.CustomerId,c.FirstName, c.LastName, SUM(i.Total) AS TotalSpent
FROM customer c
JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
ORDER BY TotalSpent DESC
LIMIT 5;

-- 7. List all albums by the artist "AC/DC".
SELECT a.Title
FROM album a
JOIN artist ar ON a.ArtistId = ar.ArtistId
WHERE ar.Name = 'AC/DC';

-- 8. Display the total number of invoices per customer.
SELECT c.FirstName, c.LastName, COUNT(i.InvoiceId) AS NumberOfInvoices
FROM customer c
JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId;

-- 9. Show names of employees who report to the same manager.
SELECT e1.FirstName, e1.LastName, e2.FirstName AS ManagerFirstName, e2.LastName AS ManagerLastName
FROM employee e1
JOIN employee e2 ON e1.ReportsTo = e2.EmployeeId;

-- 10. Find the total quantity sold per track.
SELECT t.Name, SUM(il.Quantity) AS TotalQuantitySold
FROM track t
JOIN invoiceline il ON t.TrackId = il.TrackId
GROUP BY t.TrackId;

-- 11. Which genre generates the highest revenue?
SELECT g.Name, SUM(il.UnitPrice * il.Quantity) AS Revenue
FROM genre g
JOIN track t ON g.GenreId = t.GenreId
JOIN invoiceline il ON t.TrackId = il.TrackId
GROUP BY g.GenreId
ORDER BY Revenue DESC
LIMIT 1;

-- 12. Which artist has the most tracks?
SELECT ar.Name, COUNT(t.TrackId) AS NumberOfTracks
FROM artist ar
JOIN album al ON ar.ArtistId = al.ArtistId
JOIN track t ON al.AlbumId = t.AlbumId
GROUP BY ar.ArtistId
ORDER BY NumberOfTracks DESC
LIMIT 1;

-- 13. Total sales per country, ordered by highest sales.
SELECT c.Country, SUM(i.Total) AS TotalSales
FROM customer c
JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.Country
ORDER BY TotalSales DESC;

-- 14. Average invoice total per customer.
SELECT c.FirstName, c.LastName, ROUND(AVG(i.Total), 2)AS AverageInvoiceTotal
FROM customer c
JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId;

-- 15. Customer who purchased the most tracks.
SELECT c.FirstName, c.LastName, SUM(il.Quantity) AS TotalTracksPurchased
FROM customer c
JOIN invoice i ON c.CustomerId = i.CustomerId
JOIN invoiceline il ON i.InvoiceId = il.InvoiceId
GROUP BY c.CustomerId
ORDER BY TotalTracksPurchased DESC
;

-- 16. Monthly sales totals for 2012.
SELECT YEAR(InvoiceDate) AS Year, MONTH(InvoiceDate) AS Month, SUM(Total) AS MonthlySales
FROM invoice
WHERE YEAR(InvoiceDate) = 2021
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate);

-- 17. Which year had the highest total sales.
SELECT YEAR(InvoiceDate) AS Year, SUM(Total) AS YearlySales
FROM invoice
GROUP BY YEAR(InvoiceDate)
ORDER BY YearlySales DESC
LIMIT 1;

-- 18. Employee hiring dates.
SELECT FirstName, LastName, HireDate FROM employee;

-- 19. List playlists with the number of tracks.
SELECT p.Name, COUNT(pt.TrackId) AS NumberOfTracks
FROM playlist p
JOIN playlisttrack pt ON p.PlaylistId = pt.PlaylistId
GROUP BY p.PlaylistId;

-- 20. Total amount spent and number of invoices per customer.
SELECT c.FirstName, c.LastName, SUM(i.Total) AS TotalSpent, COUNT(i.InvoiceId) AS NumberOfInvoices
FROM customer c
JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId;

-- 21. Most common media type.
SELECT m.Name, COUNT(t.TrackId) AS NumberOfTracks
FROM mediatype m
JOIN track t ON m.MediaTypeId = t.MediaTypeId
GROUP BY m.MediaTypeId
ORDER BY NumberOfTracks DESC
LIMIT 1;

-- 22. Average track length per genre.
SELECT g.Name, AVG(t.Milliseconds) AS AverageLength
FROM genre g
JOIN track t ON g.GenreId = t.GenreId
GROUP BY g.GenreId;

-- 23. Customers who never made a purchase.
SELECT c.FirstName, c.LastName
FROM customer c
LEFT JOIN invoice i ON c.CustomerId = i.CustomerId
WHERE i.CustomerId IS NULL;

-- 24. Highest selling album by quantity.
SELECT al.Title, SUM(il.Quantity) AS TotalSold
FROM album al
JOIN track t ON al.AlbumId = t.AlbumId
JOIN invoiceline il ON t.TrackId = il.TrackId
GROUP BY al.AlbumId
ORDER BY TotalSold DESC
LIMIT 1;

-- 25. Tracks never purchased.
SELECT t.Name
FROM track t
LEFT JOIN invoiceline il ON t.TrackId = il.TrackId
WHERE il.TrackId IS NULL;
