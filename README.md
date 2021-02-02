# Marley Recipes

![Screen](https://i.ibb.co/9rKwgf5/Screen-Shot-2021-02-01-at-09-49-51.png)

This is a really cool code test for a really cool company.
## Project setup

### Clone and build the project

```sh
git clone git@github.com:anchietajunior/marleyrecipes.git

cd marleyrecipes

docker-compose up --build
```

If you need to stop the project use ***CTRL+C***, and...

Run again with:

```sh
docker-compose up
```

[Link to your localhost:3000](http://localhost:3000)

## Running the tests

```sh
docker-compose run web bundle exec rspec
```
## Caching techniques used in this project

- Page caching for recipe details pages
- Low-leve caching for third API requests

## Engineering Principles this project was based on

### *A class can be no longer than 100 lines of code.*

A class can be no longer than 100 lines of code. If a class has more than 100 lines of code, the possibility for this class to have more than one reason to change is pretty high

### *5 lines per method*

A method can be no longer than 5 lines of code.

* The first rule of functions is that they should be small. The second rule of functions is that they should be smaller than that. (Clean Code by Robert Martin) *

5 lines of code equals to 1 if statement

So this rule is asking us to

1. Do not write logic more complicated than an if statement
2. Write only 1 line per branch
3. Never use elsif
## *4 parameters per method*

Pass no more than 4 parameters into a method.

Hash options are also parameters Do not fool ourselves with a hash full of parameters.

If there are more than 4 parameters, most of the time we can pull a new object out of some of the parameters.

## *1 object per view*

A view template should only refer to 1 object. 

## We write tests for our code

Testing will provide a few main benefits when done correctly. First, it will help you develop the behaviors within your app. You may write a test that your model is validating the presence of an email. Then realizing you needed to include validations for the password or add a “retype password” input box.

Another great reason to test is to protect yourself against regressions within your application as your modifying code or adding new features. This will also give you confidence and assurance when your refactoring classes, collapsing code or removing extraneous code. If written tests pass both before and after changes you should be good to go! Another testing method is to write a test after you find an issue or bug in your application. Ensuring the fix works and does not plague your application in the future.

In our application we are using RSPEC 3 for unit tests and integration tests. We are following the pattern define in the better specs website. http://www.betterspecs.org/

## Service Oriented Architecture

Rails follows a Model-View-Controller pattern. This raises questions around where programming logic should go once a Ruby on Rails application reaches a certain size. Generally, the principles are:

* Forget fat Models (don’t allow them to become bloated)
* Keep Views dumb (so don’t put complex logic there)
* And Controllers skinny (so don’t put too much there)

*So where should you put anything that’s more than a simple query or action?*

One way to support Object-Oriented Design is with the Service Object. This can be a class or module in Ruby that performs an action. It can help take out logic from other areas of the MVC files.


Our template for service looks like the code below:
 1. Strong initializer to receive parameters
 2. One public method to expose the service. The other methods should be private.
 3. Strong result from our service. Our services always return a Result objecti with the result of the operation, the error and the object
 4. Our service always handle expections
 
```ruby
class ServiceName < ApplicationService
  def initialize(params)
    @params = params 
  end
  
  def call
    result(true, nil, object)
  rescue StandardError => e 
    result(false, e.message, nil)
  end
  
  private 
  
  attr_accessor :params
end
```
