# Clear existing data
Comment.destroy_all
Article.destroy_all

# Create 5 articles
articles = [
  {
    title: "Getting Started with Rails",
    body: "Ruby on Rails is a powerful web framework that makes building web " \
          "applications fast and fun. In this guide, we'll explore the basics " \
          "of Rails and how to get started with your first application.",
    author_name: "Alice Johnson"
  },
  {
    title: "Angular Best Practices",
    body: "Angular is a comprehensive JavaScript framework for building " \
          "dynamic web applications. This article covers essential best " \
          "practices for writing clean, maintainable Angular code including " \
          "component structure, services, and reactive programming.",
    author_name: "Bob Smith"
  },
  {
    title: "Database Optimization Tips",
    body: "Learn how to optimize your database queries for better performance. " \
          "We'll cover indexing strategies, query analysis, and common " \
          "pitfalls to avoid when working with large datasets.",
    author_name: "Charlie Brown"
  },
  {
    title: "API Design Principles",
    body: "Building a well-designed API is crucial for modern web applications. " \
          "Discover the key principles of REST API design, including resource " \
          "naming, status codes, versioning, and documentation best practices.",
    author_name: "Diana Prince"
  },
  {
    title: "Testing in Ruby on Rails",
    body: "Testing is a fundamental practice in Rails development. This " \
          "comprehensive guide covers RSpec, factories, request specs, and " \
          "integration tests to ensure your application is robust and " \
          "maintainable.",
    author_name: "Eve Wilson"
  }
]

created_articles = articles.map do |article_data|
  Article.create!(article_data)
end

# Create sample comments
comments_data = [
  {
    body: "This is a fantastic article! Really helped me understand the concepts better.",
    author_name: "John Doe"
  },
  {
    body: "Thanks for sharing this valuable information. Very well written.",
    author_name: "Jane Smith"
  },
  {
    body: "I have a question about the third point you mentioned. Could you elaborate?",
    author_name: "Mike Johnson"
  },
  {
    body: "Excellent explanation! The examples were super clear and easy to follow.",
    author_name: "Sarah Williams"
  },
  {
    body: "This article solved a problem I've been struggling with for weeks. Thanks!",
    author_name: "Tom Davis"
  },
  {
    body: "Looking forward to reading more articles on this topic from you.",
    author_name: "Lisa Anderson"
  },
  {
    body: "Really appreciated the detailed walkthrough and code examples.",
    author_name: "Paul Martinez"
  },
  {
    body: "Can you provide more information about the performance implications?",
    author_name: "Emma Taylor"
  },
  {
    body: "Perfect! This is exactly what I needed to get started. Great job!",
    author_name: "Chris White"
  },
  {
    body: "Thanks for breaking down such a complex topic into digestible pieces.",
    author_name: "Rachel Green"
  }
]

# Distribute comments across articles
comment_count = 0
created_articles.each do |article|
  # Each article gets a random number of comments between 2 and 5
  rand(2..5).times do
    comment_data = comments_data.sample
    Comment.create!(
      article: article,
      body: comment_data[:body],
      author_name: comment_data[:author_name]
    )
    comment_count += 1
  end
end

puts "\n✅ ✅ ✅ Seed data created successfully! ✅ ✅ ✅"
puts "\n✅ Articles: #{Article.count}"
puts "✅ Comments: #{Comment.count}"
