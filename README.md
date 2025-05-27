# BookMYShow - Problem Solving Case

This document provides a detailed description of the entities and their relationships within the cinema booking system like BMS. The design aims for a normalized and efficient database structure to manage theatres, movies, shows, bookings, and tickets.

---

## 1. Core Entities

### 1.1. `theatres`
* **Purpose:** Represents individual cinema locations.
* **Attributes:**
    * `id` (PK): Unique identifier for each theatre.
    * `name`: Name of the theatre (e.g., "Cineplex Grand").
    * `location`: Physical address or general location of the theatre.
* **Relationships:**
    * **`theatres` 1 -- N `screens`**: One theatre can have multiple screens.
        * Established via `screens.theatre` (Foreign Key).

### 1.2. `screens`
* **Purpose:** Represents individual cinema halls or auditoriums within a theatre.
* **Attributes:**
    * `id` (PK): Unique identifier for each screen.
    * `theatre` (FK): Links the screen to its parent theatre.
    * `audio_codec` (FK): Links the screen to its supported audio codec.
    * `seating_capacity`: Total number of seats in the screen.
* **Relationships:**
    * **`screens` N -- 1 `theatres`**: Each screen belongs to one theatre.
        * Established via `screens.theatre` (Foreign Key).
    * **`screens` N -- 1 `audio_codecs`**: Each screen uses one audio codec.
        * Established via `screens.audio_codec` (Foreign Key).
    * **`screens` 1 -- N `shows`**: One screen can host multiple shows.
        * Established via `shows.screen` (Foreign Key).
    * **`screens` 1 -- N `seats`**: One screen contains multiple seats.
        * Established via `seats.screen` (Foreign Key).

### 1.3. `movies`
* **Purpose:** Stores information about movies available for screening.
* **Attributes:**
    * `id` (PK): Unique identifier for each movie.
    * `type` (FK): Links the movie to its type (e.g., 2D, 3D, IMAX).
    * `censor_grade` (FK): Links the movie to its censor rating (e.g., U, U/A, A).
    * `genre` (FK): Links the movie to its primary genre (e.g., Action, Comedy).
    * `name`: Title of the movie.
    * `duration`: Running time of the movie (e.g., in minutes).
    * `release_date`: Date when the movie was released.
    * `language`: Primary language of the movie.
* **Relationships:**
    * **`movies` N -- 1 `movie_types`**: Each movie has one specific type.
        * Established via `movies.type` (Foreign Key).
    * **`movies` N -- 1 `censor_grades`**: Each movie has one specific censor grade.
        * Established via `movies.censor_grade` (Foreign Key).
    * **`movies` N -- 1 `genres`**: Each movie has one specific genre (as per the specified constraint).
        * Established via `movies.genre` (Foreign Key).
    * **`movies` 1 -- N `shows`**: One movie can be featured in multiple shows.
        * Established via `shows.movie` (Foreign Key).

### 1.4. `shows`
* **Purpose:** Represents a specific screening instance of a movie on a particular screen at a given date and time.
* **Attributes:**
    * `id` (PK): Unique identifier for each show.
    * `movie` (FK): Links the show to the movie being played.
    * `screen` (FK): Links the show to the screen it's being played on.
    * `show_date`: Date of the show.
    * `start_time`: Start time of the show.
* **Relationships:**
    * **`shows` N -- 1 `movies`**: Each show features one movie.
        * Established via `shows.movie` (Foreign Key).
    * **`shows` N -- 1 `screens`**: Each show is hosted on one screen.
        * Established via `shows.screen` (Foreign Key).
    * **`shows` 1 -- N `bookings`**: One show can have multiple bookings.
        * Established via `bookings.show_id` (Foreign Key).
    * **`shows` 1 -- N `tickets`**: One show can have multiple tickets sold for it.
        * Established via `tickets.show_id` (Foreign Key).

---

## 2. Supporting Entities

### 2.1. `audio_codecs`
* **Purpose:** Reference table for different audio codecs supported by screens.
* **Attributes:**
    * `id` (PK): Unique identifier for the audio codec.
    * `name`: Name of the audio codec (e.g., "Dolby Atmos", "DTS:X").
* **Relationships:**
    * **`audio_codecs` 1 -- N `screens`**: One audio codec can be used by multiple screens.
        * Established via `screens.audio_codec` (Foreign Key).

### 2.2. `movie_types`
* **Purpose:** Reference table for different movie formats/types.
* **Attributes:**
    * `id` (PK): Unique identifier for the movie type.
    * `name`: Name of the movie type (e.g., "2D", "3D", "IMAX").
    * `description`: Description of the movie type.
* **Relationships:**
    * **`movie_types` 1 -- N `movies`**: One movie type can be applied to multiple movies.
        * Established via `movies.type` (Foreign Key).

### 2.3. `censor_grades`
* **Purpose:** Reference table for movie censor ratings.
* **Attributes:**
    * `id` (PK): Unique identifier for the censor grade.
    * `code`: Short code for the grade (e.g., "U", "UA", "A").
    * `description`: Full description of the censor grade.
* **Relationships:**
    * **`censor_grades` 1 -- N `movies`**: One censor grade can be applied to multiple movies.
        * Established via `movies.censor_grade` (Foreign Key).

### 2.4. `genres`
* **Purpose:** Reference table for movie genres.
* **Attributes:**
    * `id` (PK): Unique identifier for the genre.
    * `title`: Name of the genre (e.g., "Action", "Comedy", "Drama").
    * `description`: Description of the genre.
* **Relationships:**
    * **`genres` 1 -- N `movies`**: One genre can be assigned to multiple movies (based on the constraint that a movie has a single genre).
        * Established via `movies.genre` (Foreign Key).

---

## 3. Booking & Transaction Entities

### 3.1. `seats`
* **Purpose:** Represents individual physical seats within a screen.
* **Attributes:**
    * `id` (PK): Unique identifier for each seat.
    * `screen` (FK): Links the seat to the screen it belongs to.
    * `row_code`: Row number of the seat.
    * `number`: Seat number within the row.
    * `zone`: Seating zone (e.g., "Standard", "Premium").
    * `type`: Type of seat (e.g., "Regular", "Recliner").
* **Relationships:**
    * **`seats` N -- 1 `screens`**: Each seat belongs to one screen.
        * Established via `seats.screen` (Foreign Key).
    * **`seats` 1 -- N `tickets`**: One seat can have multiple tickets associated with it over different shows.
        * Established via `tickets.seat` (Foreign Key).

### 3.2. `customers`
* **Purpose:** Stores information about registered users of the booking system.
* **Attributes:**
    * `id` (PK): Unique identifier for each customer.
    * `name`: Customer's full name.
    * `email`: Customer's email address (should be unique).
    * `mobile`: Customer's mobile number.
    * `password`: Hashed password for customer login.
    * `location`: General location of the customer.
    * `city`: City of the customer.
* **Relationships:**
    * **`customers` 1 -- N `bookings`**: One customer can make multiple bookings.
        * Established via `bookings.booked_by` and `bookings.booked_for` (Foreign Keys).

### 3.3. `bookings`
* **Purpose:** Represents a single transaction or order made by a customer for a specific show, which can include multiple tickets.
* **Attributes:**
    * `id` (PK): Unique identifier for each booking.
    * `booked_by` (FK): Links to the customer who initiated the booking.
    * `show_id` (FK): Links the booking to the specific show it is for.
* **Relationships:**
    * **`bookings` N -- 1 `customers`**: Each booking is made by one customer (`booked_by`).
        * Established via `bookings.booked_by` (Foreign Key).
    * **`bookings` N -- 1 `shows`**: Each booking is for a specific show.
        * Established via `bookings.show_id` (Foreign Key).
    * **`bookings` 1 -- N `tickets`**: One booking can contain multiple tickets.
        * Established via `tickets.booking` (Foreign Key).

### 3.4. `tickets`
* **Purpose:** Represents an individual ticket for a specific seat at a specific show, part of a booking, and linked to a payment.
* **Attributes:**
    * `id` (PK): Unique identifier for each ticket.
    * `show_id` (FK): Links the ticket to the specific show it is for.
    * `payment` (FK): Links the ticket to the payment transaction.
    * `seat` (FK): Links the ticket to the specific seat it reserves.
    * `booking` (FK): Links the ticket to the overall booking transaction.
* **Relationships:**
    * **`tickets` N -- 1 `shows`**: Each ticket is for one specific show.
        * Established via `tickets.show_id` (Foreign Key).
    * **`tickets` N -- 1 `payments`**: Each ticket is associated with one payment.
        * Established via `tickets.payment` (Foreign Key).
    * **`tickets` N -- 1 `seats`**: Each ticket reserves one specific seat.
        * Established via `tickets.seat` (Foreign Key).
    * **`tickets` N -- 1 `bookings`**: Each ticket belongs to one booking.
        * Established via `tickets.booking` (Foreign Key).

### 3.5. `payments`
* **Purpose:** Records details of financial transactions for bookings.
* **Attributes:**
    * `id` (PK): Unique identifier for each payment.
    * `mode` (FK): Links the payment to the payment method used.
    * `amount`: Total amount of the payment.
    * `created_at`: Timestamp when the payment was recorded.
* **Relationships:**
    * **`payments` N -- 1 `payment_modes`**: Each payment uses one specific payment mode.
        * Established via `payments.mode` (Foreign Key).
    * **`payments` 1 -- N `tickets`**: One payment can cover multiple tickets.
        * Established via `tickets.payment` (Foreign Key).

### 3.6. `payment_modes`
* **Purpose:** Reference table for different payment methods.
* **Attributes:**
    * `id` (PK): Unique identifier for the payment mode.
    * `type`: Type of payment (e.g., "Credit Card", "Debit Card", "UPI", "Cash").
* **Relationships:**
    * **`payment_modes` 1 -- N `payments`**: One payment mode can be used for multiple payments.
        * Established via `payments.mode` (Foreign Key).

> For better visualization of the entities and their relationships, refer to the BMS_ER.html file in the root directory.

---

## 4. Example Data Rows

Here are some example data rows for each entity to illustrate the relationships and data types.

### 4.1. `audio_codecs`

| id | name         |
|----|--------------|
| 1  | Dolby Atmos  |
| 2  | DTS:X        |
| 3  | Standard 5.1 |

### 4.2. `censor_grades`

| id | code | description                 |
|----|------|-----------------------------|
| 1  | U    | Universal                   |
| 2  | UA   | Universal with parental guidance |
| 3  | A    | Adults only                 |

### 4.3. `customers`

| id | name          | email               | mobile        | password (hashed) | location    | city        |
|----|---------------|---------------------|---------------|-------------------|-------------|-------------|
| 1  | Devansh Sharma   | devansh@example.com   | +1234567890   | abcdef12345       | Downtown    | New York    |
| 2  | Bobby Singh   | bobby@example.com     | +1987654321   | ghijkl67890       | Uptown      | New York    |
| 3  | Aditi Dahare | aditi@example.com | +1122334455   | mnopqr11223       | Midtown     | New York    |

### 4.4. `genres`

| id | title    | description                 |
|----|----------|-----------------------------|
| 1  | Action   | High-energy, fast-paced     |
| 2  | Comedy   | Humorous, light-hearted     |
| 3  | Sci-Fi   | Speculative fiction         |
| 4  | Drama    | Serious, character-driven   |

### 4.5. `movie_types`

| id | name  | description                 |
|----|-------|-----------------------------|
| 1  | 2D    | Standard two-dimensional projection |
| 2  | 3D    | Three-dimensional projection |
| 3  | IMAX  | Immersive large-format projection |

### 4.6. `movies`

| id | type | censor_grade | genre | name             | duration | release_date | language |
|----|------|--------------|-------|------------------|----------|--------------|----------|
| 1  | 1    | 2            | 1     | The Great Escape | 150      | 2023-01-15   | English  |
| 2  | 2    | 1            | 2     | Laugh Out Loud   | 100      | 2023-02-20   | English  |
| 3  | 3    | 2            | 3     | Cosmic Journey   | 180      | 2023-03-10   | English  |

### 4.7. `payment_modes`

| id | type        |
|----|-------------|
| 1  | Credit Card |
| 2  | UPI         |
| 3  | Debit Card  |

### 4.8. `theatres`

| id | name             | location                 |
|----|------------------|--------------------------|
| 1  | Grand Cinema     | 123 Main St, New York    |
| 2  | Star Theatres    | 456 Elm Ave, Old York    |

### 4.9. `screens`

| id | theatre | audio_codec | seating_capacity |
|----|---------|-------------|------------------|
| 1  | 1       | 1           | 200              |
| 2  | 1       | 3           | 150              |
| 3  | 2       | 2           | 250              |

### 4.10. `seats`

| id | screen | row_code | number | zone     | type    |
|----|--------|-----|--------|----------|---------|
| 1  | 1      | A   | 1      | Standard | Regular |
| 2  | 1      | A   | 2      | Standard | Regular |
| 3  | 1      | B   | 5      | Premium  | Recliner|
| 4  | 2      | C   | 10     | Standard | Regular |
| 5  | 3      | D   | 3      | Premium  | Regular |

### 4.11. `shows`

| id | movie | screen | show_date  | start_time |
|----|-------|--------|------------|------------|
| 1  | 1     | 1      | 2023-05-28 | 19:00:00   |
| 2  | 2     | 2      | 2023-05-28 | 14:30:00   |
| 3  | 1     | 1      | 2023-05-29 | 21:00:00   |
| 4  | 3     | 3      | 2023-05-28 | 18:00:00   |

### 4.12. `bookings`

| id | booked_by | show_id |
|----|-----------|-------
| 1  | 1         | 1    |
| 2  | 2         | 2    |
| 3  | 1         | 1    |

### 4.13. `payments`

| id | mode | amount | created_at          |
|----|------|--------|---------------------|
| 1  | 1    | 25.00  | 2023-05-27 10:00:00 |
| 2  | 2    | 12.50  | 2023-05-27 11:30:00 |
| 3  | 1    | 25.00  | 2023-05-27 12:00:00 |
| 4  | 3    | 18.00  | 2023-05-27 13:00:00 |

### 4.14. `tickets`

| id | show_id | payment | seat | booking |
|----|------|---------|------|---------|
| 1  | 1    | 1       | 1    | 1       |
| 2  | 1    | 1       | 2    | 1       |
| 3  | 2    | 2       | 4    | 2       |
| 4  | 1    | 3       | 3    | 3       |
| 5  | 4    | 4       | 5    | 4       |

## 5. Solutions
- P1 - SQL query files can be found in the following directories
  - Create tables - `queries/createTables`
  - Insert sample data - `queries/insertSampleData`
- P2 - SQL query and its query result can be found in the following files
  - SQL query - `queries/p2Query.sql`
  - Query result - `queries/p2QueryResult.csv`