# Flarum & AI Tagger - Development Environment

This repository contains the full Docker-based development environment for a Flarum instance integrated with a custom AI-powered tagging extension.

It uses Docker Compose to orchestrate a multi-container setup that includes the Flarum web application, a background job scheduler, a Python AI microservice, a database, and a web server.

## Project Architecture

This project is composed of three separate repositories that work together:

1.  **`flarum-aws-development` (This Repo):** Contains the Docker and Docker Compose files to build and run the entire application stack.
2.  **`flarum-ext-ai-tagger`:** A Flarum extension that triggers the AI tagging process.
3.  **`forum-ai-backend`:** A Flask-based Python service that performs the AI content analysis.

### Service Interaction Flow

```
+----------------+      +----------------+      +----------------+
|                |      |                |      |                |
|  User's        |----->|   Nginx Web    |----->|   Flarum App   |
|  Browser       |      |   Server       |      |   (PHP-FPM)    |
|                |      | (port 8080)    |      |                |
+----------------+      +-------+--------+      +-------+--------+
                                |                       |
        +-----------------------+-----------------------+--------+
        |                                                        |
+-------+--------+      +----------------+      +-------+--------+      +----------------+
|                |      |                |      |                |      |                |
| Flarum         |----->| AI Backend     |      | Flarum         |<---->| MariaDB        |
| Scheduler      |      | (Python/Flask) |      | (Job Queue)    |      | Database       |
| (Runs Job)     |      | (port 5001)    |      |                |      |                |
+----------------+      +----------------+      +----------------+      +----------------+
```

## Prerequisites

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Local Development Setup

To run the entire system on your local machine, you must set up the following directory structure. This structure is required because the Flarum Docker container mounts local directories for development.

```
your-workspace/
├── flarum-aws-development/   (This repository)
├── forum-ai-backend/         (The AI backend repository)
└── packages/
    └── flarum-ext-ai-tagger/ (The Flarum extension repository)
```

**Steps:**

1.  **Clone all repositories** into the structure shown above.
2.  **Navigate to the `flarum-aws-development` directory.**
3.  **Create the environment file:**
    ```bash
    cp docker-compose/.env.example docker-compose/.env
    ```
4.  **(Optional) Review `docker-compose/.env`** and change passwords or ports if needed. The defaults are fine for local development.
5.  **Build and start the services:**
    ```bash
    docker-compose -f docker-compose/local-dev.yml up --build -d
    ```