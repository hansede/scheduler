# Coaching Scheduler Web App

A coaching scheduler web app that allows registration of clients and coaches and scheduling of appointments.

## Prerequisites
* Install [Git] (https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) (you're on Github!)
* Set up a [Google account](https://accounts.google.com/signup?hl=en) if you don't already have one
* Install [Node.js](https://nodejs.org/en/download/)
* Use npm to globally install gulp, bower, and coffee-script:
```
sudo npm install -g gulp bower coffee-script
```
* Install the [Coaching Scheduler Service](https://github.com/hansede/scheduler_service)
  * The Coaching Scheduler Web App makes API calls to the Coaching Scheduler Service. If needed, the location of the Coaching Scheduler Service can be configured in app/environment.coffee.
* Optionally, install [Docker](https://docs.docker.com/engine/installation/)

## Installation
* Clone this repo
* Install modules and build:
```
cd scheduler
npm install
```
* Start the server:
```
node server.js
```


## Usage

### Routes
The Coaching Scheduler has two routes:
* The Client Portal: [http://localhost:9999/#/client](http://localhost:9999/#/client)
* The Coach Portal: [http://localhost:9999/#/coach](http://localhost:9999/#/coach)

Navigating to the root URL will automatically redirect you to the Client Portal.

### Coach Portal
The Coaching Scheduler comes preinstalled with two sample coaches, but you may wish to register your own user as a coach. To do so, follow these steps:

1. Navigate to [http://localhost:9999/#/coach](http://localhost:9999/#/coach)
1. Log in using your Google credentials
1. Upon being redirected to the Coach Portal, you will be prompted to enter a phone number where clients can reach you.

You are now registered as a coach, you can use the Coach Portal to view appointments that your clients make.

### Client Portal
To register as a coaching client, please follow these steps:

1. Navigate to [http://localhost:9999/#/client](http://localhost:9999/#/client)
1. Log in using your Google credentials

You are now registered as a client and will be redirected to the Client Portal. Upon registering, you are automatically assigned a coach with whom you can schedule appointments. You may only schedule one appointment at a time, and you can schedule up to a month in advance. Coaches are available for hour-long appointments Mon-Fri 9-5, but you will not be able to schedule a time that has already been filled.

To schedule an appointment, simply follow the prompts. When you confirm your appointment, you will be sent a reminder email at the address associated with your Google account. Once you have scheduled an appointment, you will be allowed the opportunity to reschedule to any available time.

### API
The Coaching Scheduler has a resource-based public REST API that is intended for use by the web application, but which can be called separately if desired. All API calls start from the */api* root URL and all API calls require the Authorization header:
```
'Authorization': 'Bearer <A Google OAuth token>'
```

#### Available Appointments
```
GET /coach/:coach_id/available-appointments?date=<date>
Codes: 200, 401, 500
Response: An array of timestamps (ms since epoch). These timestamps are filtered to the provided calendar date.
URL Parameters:
  - coach_id <UUID>
Query Parameters:
  - date <ms since epoch>
```

#### Appointment
```
GET /client/:client_id/appointment
Codes: 200, 401, 404, 500
Response: An appointment object
URL Parameters:
  - client_id <UUID>
```
```
GET /coach/:coach_id/appointment
Codes: 200, 401, 500
Response: An array of appointment objects
URL Parameters:
  - coach_id <UUID>
```
```
POST /appointment
Codes: 201, 401, 500
Response: URL of the newly created appointment
Notes: This request also sends an email notification to the client's email address
Body Parameters:
  - client_id <UUID>
  - coach_id <UUID>
  - appointment_date: <ms since epoch>
```
```
DELETE /client/:client_id/appointment
Codes: 204, 401, 404, 500
URL Parameters:
  - client_id <UUID>
```

#### Client
```
GET /client/:id
Codes: 200, 401, 404, 500
Response: A client object with a coach sub-object
URL Parameters:
  - id <UUID>
```
```
POST /client
Codes: 201, 401, 500
Response: URL of the newly created client
Notes: 
  - If a client with the given email already exists, it will not be overwritten, but 201 will still be returned.
  - This request will randomly assign a coach to the client.
Body Parameters:
  - name <string>
  - email <string>
  - avatar <URI> (optional)
```

#### Coach
```
GET /coach?email=<email>
Codes: 200, 401, 404, 500
Response: A coach object
Query Parameters:
 - email <string>
```
```
GET /coach/:id
Codes: 200, 401, 404, 500
Response: A coach object
URL Parameters:
  - id <UUID>
```
```
POST /coach
Codes: 201, 401, 500
Response: URL of a newly created coach
Notes:
  - If a coach with the given email already exists, it will not be overwritten, but 201 will still be returned.
Body Parameters:
  - name <string>
  - email <string>
  - phone <string>
  - avatar <URI> (optional)
```

### Docker (optional)
The Coaching Scheduler can optionally be launched in a Docker container. This repository includes a Dockerfile from which the Docker container can be built. Please ensure that you have installed Docker, then run the following commands (*sudo* may not be necessary, depending on your environment):
```
sudo docker build --tag=scheduler .
sudo docker run -p 9999:9999 -it scheduler
```
When finished, the container can be stopped like so:
* Find the container ID:
```
sudo docker ps
```
* Stop the container:
```
sudo docker stop -t 0 <container_id>
```
