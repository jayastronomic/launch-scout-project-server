# Receipt Processor Backend Challenge

Hey Fetch Rewards Team! My name is Julian and I here is my submission for the challenge.
The tech stack I chose for the backend challenge was Ruby on Rails and Docker. This is a light-weight rails project
that is not hooked up to a database and uses an in-memory solution to to solve this challenge.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for the assesment of my submission.

### Prerequisites

There are no prequisites for thus project since Docker is installed on Fetch Rewards systems.

### Instatlling

1.1. Clone the repository to your local machine using Git:

```
git clone https://github.com/jayastronomic/fetch-backend-challenge.git
```

2. Install the project dependencies by running the following command in the project's root directory:

```
docker compose up
```

This command will build the docker image and run the cointaner for this project. The container is set to listen on "http://localhost:4000"

3. After the you see the Rails welcome page, you are good to go on sending data to the server to get a response on the specified routes on the README.me of this repo
   "https://github.com/fetch-rewards/receipt-processor-challenge"

## Rspec Tests

Though the challenge didin't specify that tests needed to be written, I added a testing library called RSpec to the project to help me test my Receipt Processor API.

# Run Test Suite

To run the automated tests for this project, run the following command in the project's root directory:

```
rspec
```

This will run the test specified in the `spec` folder of the root directory under the folder `spec/models` and `spec/requests/`. You can check out the folder to see what I tested for this API.

### BONUS Receipt Processor Front-end

After I finished building the backend, the full stack engineer came out of my spirit and wanted to build a front-end for you guys to test and interface with the backend!
I build the front-end app with React. I used the TailwindCSS libray to style and bring the client to life. To get the client to run follow this link to the seperate repo!
"https://github.com/jayastronomic/fetch-frontend-bonus"

I would love for you guys to check it out and play around with it!

## Authors

- **Julian Smith** - _Initial work_ - [jayastronomic](https://github.com/jayastronomic)
