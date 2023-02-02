# Receipt Processor Backend

Hey Launch Scout Team! My name is Julian and here is the backend for my project!
The tech stack I chose for the backend was Ruby on Rails and Docker. This is a light-weight rails project
that is not hooked up to a database and uses an in-memory solution.

## Summary of API Specification

The purpose of this API is to process receipt information in the form of JSON.
These rules collectively define how many points should be awarded to a receipt.

#### Rules

- One point for every alphanumeric character in the retailer name.
- 50 points if the total is a round dollar amount with no cents.
- 25 points if the total is a multiple of 0.25.
- 5 points for every two items on the receipt.
- If the trimmed length of the item description is a multiple of 3, multiply the price by 0.2 and round up to the nearest integer. The result is the number of points earned.
- 6 points if the day in the purchase date is odd.
- 10 points if the time of purchase is after 2:00pm and before 4:00pm.

### Example

```
{
   "retailer": "Target",
   "purchaseDate": "2022-01-01",
   "purchaseTime": "13:01",
   "items": [
      {
         "shortDescription": "Mountain Dew 12PK",
         "price": "6.49"
      },{
         "shortDescription": "Emils Cheese Pizza",
         "price": "12.25"
      },{
         "shortDescription": "Knorr Creamy Chicken",
         "price": "1.26"
      },{
         "shortDescription": "Doritos Nacho Cheese",
         "price": "3.35"
      },{
         "shortDescription": " Klarbrunn 12-PK 12 FL OZ ",
         "price": "12.00"
      }
   ],
   "total": "35.35"
}
```

```
Total Points: 28
Breakdown:
   6 points - retailer name has 6 characters
   10 points - 4 items (2 pairs @ 5 points each)
   3 Points - "Emils Cheese Pizza" is 18 characters (a multiple of 3)
   item price of 12.25 _ 0.2 = 2.45, rounded up is 3 points
   3 Points - "Klarbrunn 12-PK 12 FL OZ" is 24 characters (a multiple of 3)
   item price of 12.00 _ 0.2 = 2.4, rounded up is 3 points
   6 points - purchase day is odd

  + ---------
  = 28 points
```

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

To make sure the app runs, the only prerequisite you should have is Docker installed on your machine.

### Instatlling

1. Clone the repository to your local machine using Git:

```
git clone https://github.com/jayastronomic/launch-scout-project-server.git
```

2. Install the project dependencies by running the following command in the project's root directory:

```
docker compose up
```

This command will build the docker image and run the cointaner for this project. The container is set to listen on "http://localhost:4000"

3. After the you see the Rails welcome page, you are good to go on sending data to the server from the front end.

# Rspec Tests

Though you guys didn't specify if tests needed to be written, I added a testing library called RSpec to the project to help me test my Receipt Processor API.

## Run Test Suite

To run the automated tests for this project, run the following command in the project's root directory:

```
rspec
```

This will run the test specified in the `spec` folder of the root directory under the folder `spec/models` and `spec/requests/`. You can check out the folder to see what I tested for this API.

# Receipt Processor Front-end

I built the front-end app with React and I used Docker as well for easy installment. I used the TailwindCSS libray to style and bring the client to life. To get the client to run follow this link to the seperate repo!
https://github.com/jayastronomic/launch-scout-project-client

## Authors

- **Julian Smith** - _Initial work_ - [jayastronomic](https://github.com/jayastronomic)
