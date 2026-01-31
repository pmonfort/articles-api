# Articles API

A RESTful API built with Ruby on Rails for managing articles and comments. This is the backend component of a small articles application that allows users to create articles, add comments, and view engagement statistics.

## Frontend

https://github.com/pmonfort/articles-frontend

## Features

- Create and list articles with title, body, and author name
- Add comments to articles
- View engagement statistics (total articles, total comments, most commented articles)
- RESTful JSON API endpoints
- PostgreSQL database
- RSpec test coverage

## Requirements

- Ruby 3.4.7
- PostgreSQL 9.3 or higher
- Bundler gem

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd articles-api
```

2. Install dependencies:
```bash
bundle install
```

3. Set up the database:
```bash
# Create the database
rails db:create

# Run migrations
rails db:migrate

# (Optional) Seed the database with sample data
rails db:seed
```

## Configuration

### Database Configuration

The application uses PostgreSQL. Configure your database settings in `config/database.yml`:

```yaml
development:
  adapter: postgresql
  encoding: unicode
  database: articles_api_development
  pool: 5
  username: your_username
  password: your_password
  host: localhost
```

## Running the Application

Start the Rails server:

```bash
rails server
```

The API will be available at `http://localhost:3000`

## Running Tests

Run the full test suite:

```bash
bundle exec rspec
```

## API Documentation

### Base URL

All API endpoints are prefixed with `/api`

### Endpoints

#### Articles

##### List Articles
```
GET /api/articles
```

Returns a list of all articles with their comment counts.

**Response:**
```json
[
  {
    "id": 1,
    "title": "Getting Started with Rails",
    "body": "Ruby on Rails is a powerful web framework...",
    "author_name": "Alice Johnson",
    "created_at": "2026-01-28T12:00:00.000Z",
    "comments_count": 3,
    "comments": [
      {
        "id": 1,
        "body": "Great article!",
        "author_name": "John Doe",
        "article_id": 1,
        "created_at": "2026-01-28T13:00:00.000Z"
      }
    ]
  }
]
```

##### Create Article
```
POST /api/articles
```

Creates a new article.

**Request Body:**
```json
{
  "article": {
    "title": "My New Article",
    "body": "This is the article content",
    "author_name": "John Doe"
  }
}
```

**Response (201 Created):**
```json
{
  "id": 1,
  "title": "My New Article",
  "body": "This is the article content",
  "author_name": "John Doe",
  "created_at": "2026-01-28T12:00:00.000Z",
  "comments_count": 0,
  "comments": []
}
```

#### Comments

##### Create Comment
```
POST /api/comments
```

Creates a new comment for an article.

**Request Body:**
```json
{
  "comment": {
    "body": "This is a great article!",
    "author_name": "Jane Smith",
    "article_id": 1
  }
}
```

**Response (201 Created):**
```json
{
  "id": 1,
  "body": "This is a great article!",
  "author_name": "Jane Smith",
  "article_id": 1,
  "created_at": "2026-01-28T13:00:00.000Z"
}
```

#### Engagement Overview

##### Get Engagement Statistics
```
GET /api/articles/engagement_overview
```

Returns engagement statistics including total articles, total comments, and most commented articles.

**Response:**
```json
{
  "total_articles": 10,
  "total_comments": 25,
  "most_commented_articles": [
    {
      "id": 5,
      "title": "Popular Article",
      "body": "Content...",
      "author_name": "Author Name",
      "created_at": "2026-01-28T10:00:00.000Z",
      "comments_count": 8,
      "comments": [...]
    }
  ]
}
```

## Data Models

### Article
- `id` (integer) - Primary key
- `title` (string) - Article title (required)
- `body` (text) - Article content (required)
- `author_name` (string) - Author's name (required)
- `created_at` (datetime) - Creation timestamp
- `updated_at` (datetime) - Last update timestamp

### Comment
- `id` (integer) - Primary key
- `body` (text) - Comment content (required)
- `author_name` (string) - Commenter's name (required)
- `article_id` (integer) - Foreign key to article (required)
- `created_at` (datetime) - Creation timestamp
- `updated_at` (datetime) - Last update timestamp

## Example Usage

### Using cURL

```bash
# Create an article
curl -X POST http://localhost:3000/api/articles \
  -H "Content-Type: application/json" \
  -d '{
    "article": {
      "title": "My Article",
      "body": "Article content here",
      "author_name": "John Doe"
    }
  }'

# List all articles
curl http://localhost:3000/api/articles

# Create a comment
curl -X POST http://localhost:3000/api/comments \
  -H "Content-Type: application/json" \
  -d '{
    "comment": {
      "body": "Great article!",
      "author_name": "Jane Smith",
      "article_id": 1
    }
  }'

# Get engagement overview
curl http://localhost:3000/api/articles/engagement_overview
```

## Project Structure

```
articles-api/
├── app/
│   ├── controllers/
│   │   └── api/
│   │       ├── articles_controller.rb
│   │       └── comments_controller.rb
│   ├── models/
│   │   ├── article.rb
│   │   └── comment.rb
│   └── serializers/
│       ├── article_serializer.rb
│       └── comment_serializer.rb
├── config/
│   ├── routes.rb
│   └── database.yml
├── db/
│   ├── migrate/
│   └── seeds.rb
└── spec/
    ├── controllers/
    ├── models/
    └── factories/
```

## Time & Next Steps

### Time Spent

Around 10 hours.

### With More Time

Things I'd add next:

- Paginationd
- Search/filter endpoints
- JWT auth
- Redis caching for the engagement endpoint
- Docker setup
- CI with GitHub Actions

## License

This project is part of a coding challenge.
