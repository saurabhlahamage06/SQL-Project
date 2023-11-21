--MUSIC STORE DATA ANALYSIS PROJECT
---------------------------------------

/*
Q1. Who is the senior most employee based on job title?
*/

select top 1* from employee 
order by levels desc;

/*
Q2. Which countries have the most invoices ?
*/
select  billing_country, count(*) as Count_C from invoice
group by(billing_country) order by Count_C desc;

/*
Q3. What are top 3 values of total invoice?
*/
select top 3 total from invoice
order by total desc;

/*
Q4.Which city has the best customers? We would like to throw a
promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals?
*/

select billing_city, sum(total) as total from invoice
group by billing_city order by total desc;

/*Q5. Who is the best customer? The customer who has spent the most 
money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

select top 1 invoice.customer_id, SUM(invoice.total) as total
from invoice
JOIN customer ON customer.customer_id = invoice.customer_id
GROUP BY invoice.customer_id
ORDER BY total DESC;

/* Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

select distinct customer.email,customer.first_name,customer.last_name from customer
JOIN invoice ON	customer.customer_id = invoice.invoice_id
JOIN invoiceline ON invoice.invoice_id = invoiceline.invoice_id
JOIN track ON invoiceline.track_id = track.track_id
JOIN genre ON track.genre_id = genre.genre_id 
WHERE genre.name like 'Rock' order by email;

/* Q7: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT artist.artist_id, max(artist.name),COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC;


/* Q8: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. 
Order by the song length with the longest songs listed first. */


select name, milliseconds from track
where milliseconds > (select AVG(milliseconds) as AvgMilliseconds from track)
order by milliseconds desc;

