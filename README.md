# README

This program is written by Viktor Kukhar for Teamvoy. The application uses Ruby 3 and Rails 7 framework. It uses the Webpacker gem for JavaScript management and PostgreSQL for the database, AJAX and jQuery to perform a search without reloading the entire page, Bootstrap for front-end design.

Data is loaded from a JSON file via seeds.rb. AJAX script is located in the javascript/packs/search.js file. The search functionality is implemented through a 'search' method in the ItemsController. Search function meets the following requirements:

It allows users to search for "Lisp Common" and it returns all programming languages named "Common Lisp".
The search results are ordered by relevance, meaning that the most relevant results appear first.
The search function supports exact matches, such as searching for "Thomas Eugene" which should only match "BASIC", but not "Haskell".
The search function matches in different fields, such as searching for "Scripting Microsoft" which returns all scripting languages designed by "Microsoft".
The search function supports negative searches, such as searching for "john -array" which matches "BASIC", "Haskell", "Lisp" and "S-Lang", but not "Chapel", "Fortran" or "S".
