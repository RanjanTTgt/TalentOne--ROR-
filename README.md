# TalentOne Project


## Table of Contents

1. [Introduction](#1-introduction)
2. [Technology Stack](#2-technology-stack)
3. [Installation](#3-installation)
4. [Directory Structure](#4-directory-structure)
5. [Web Application Features](#5-web-application-features)
   - [5.a. Authentication](#5a-authentication)
   - [5.b. Background Services](#5b-background-services)
   - [5.c. Live Data Updates](#5c-live-data-updates)
   - [5.d. Employee List](#5d-employee-list)
   - [5.e. Employee Types](#5e-employee-types)
   - [5.f. Employee Designation](#5f-employee-designation)
   - [5.g. Reporting](#5g-reporting)
   - [5.h. Daily Attendance](#5h-daily-attendance)
   - [5.i. Attendance Tracking](#5i-attendance-tracking)
   - [5.j. Auto-TimeOut Feature](#5j-auto-timeout-feature)

5. [Mobile App API](#6-mobile-app-api)
   - [6.a. API Documentation](#6a-api-documentation)


<!-- tocstop -->
## 1. Introduction

This project is a comprehensive web application and mobile API system designed to manage user authentication, attendance tracking, reporting, and user management. With a user-friendly web interface and a well-documented mobile API, our solution caters to a variety of user roles, including Super Admins, Admins, HR personnel, and standard Employees. Here's a quick overview of the key features:


## 2. Technology Stack:

* **Ruby on Rails 7:** The web application is built using Ruby on Rails version 7, a robust and modern web development framework. Rails 7 introduces new features and improvements that enhance application development and performance.
* **PostgreSQL Database:** We use a PostgreSQL database, a powerful and reliable relational database management system. PostgreSQL ensures data integrity and provides advanced data manipulation capabilities.

Please install Ruby and Rails according to your system requirements.

## 3. Installation

1. Clone this repository.
2. Run `bundle install` to install required gems.
3. Set up your database with `rails db:migrate`.
4. Set up your database records first time with `rails db:seed`.
5. Start the server with `rails server`.

## 4. Directory Structure

- `app/`: Contains application code.
  - `assets/`: Stylesheets, JavaScript, and images.
  - `channels/`: Channels (for realtime update - Action cable Channels).
  - `controllers/`: Controller files.
  - `helpers/`: Helpers files.
  - `jobs/`: Active Record Jobs files.
  - `mailers/`: Mailers files.
  - `models/`: Model files.
  - `serializers/`: Serializers files.
  - `uploaders/`: Uploaders files(File Image Video Uploader).
  - `views/`: View templates.
- `bin/`: Executable scripts.
- `config/`: Includes configuration files for various aspects of the application, such as routes, database settings, and environment variables.
- `db/`: Includes database-related files and migrations.
- `lib/`: Houses custom libraries and modules.
- `log/`: Contains application log files.
- `public/`: Contains publicly accessible assets like images and stylesheets.
- `storage/`: File storage (if used).
- `test/`: Test files and fixtures.
- `tmp/`: Stores temporary files.
- `vendor/`: Third-party code.
- `.gitignore`: Files and directories to ignore in version control.
- `Gemfile` and `Gemfile.lock`: Gem dependencies.
- `README.md`: This documentation file.

## 5. Web Application Features:

### 5.a. Authentication

* We use (devise Gem) authentication for the web application. Devise is a flexible authentication solution that provides features like user registration, session management, and user account management.

### 5.b. Background Services:

* We leverage Sidekiq for handling background services, ensuring efficient task processing and improved application performance. Sidekiq is a popular background job processing framework for Ruby applications, making it an essential component of our system.

### 5.c. Live Data Updates:

* We utilize Turbo Streams for live data updates, allowing real-time updates in the web application. For example, when a user time out from mobile app, the information is automatically updated in the browser without the need for a page refresh.

### 5.d. Employee List

* A list of employees is available for reference. Employees can access this list to see who is part of the organization, their contact information, and other relevant details.

### 5.e. Employee Types:

* Our application supports five types of users:
  * **Super Admin:** Has access to all administrative functions and can manage other user types.
  * **Admin:** Has administrative privileges but with certain restrictions compared to the Super Admin.
  * **HR (Human Resources):** Manages employee information, attendance, and related HR tasks.
  * **Employees:** Standard users of the system.

### 5.f. Employee Designation

* Employees can have different designations, such as Software Engineer, Project Managers, and more. Designations help categorize and organize users within the system, making it easier to assign roles and responsibilities.

### 5.g. Reporting

* Employees can share daily and weekly reports on the portal. This reporting functionality allows users to submit work updates, progress reports, or any relevant information.

### 5.h. Daily Attendance

* Employees can log in and log out, which records daily attendance. This feature is especially useful for tracking when employees start and end their workday.

### 5.i. Attendance Tracking

* Employees can view the attendance list, which helps in tracking attendance records. This list can be used for various purposes, including payroll processing, attendance monitoring, and performance evaluation.

### 5.j. Auto-TimeOut Feature:

* We have implemented an auto-timout feature using cron jobs. This feature automatically logs out users who may forget to timeout out after a sharing daily report or shift over.


## 6. Mobile App API

The Mobile App API's core features, including user authentication, time tracking, and daily reporting, make it an essential tool for efficient attendance management.

  * **Employee Authentication:** Offers user authentication through JWT tokens.
  * **TimeIn/TimeOut:** Allows users to log their time in and time out, recording daily attendance via the mobile app.
  * **Daily Reporting:** Facilitates the submission of daily reports through the mobile app.

### 6.a API Documentation

* We use Swagger documentation to provide detailed information for application developers about available endpoints, required parameters, and other relevant details of the API. Swagger simplifies the process of understanding and interacting with the API, making it easier for developers to work with the mobile application.
* Swagger Url http://domain-url/api-docs




