#  NY Times API Example

## About

### General
This project is a simple example of a light, HIG (human interface guidelines) design used to consume the NYTimes Most Viewed API. Its possible to list all the news by section and period of time.
There is a simple pull-to-refresh implementation and a tagged-like collection view flow layout.

### Architecture
I chose MVP in order to promote easy testing as its possible to isolate all the business logic on the presenter component and the possiblity of mocking views for testing.
Also, even noticing that there is no dependency injection, the code should be easily to refactor into having it: just abstract the ```NyTimesApi``` class and inject.

### Testing
Although the code coverage is actually really low, most of the logics are easy to test. I will write a few more tests to show it.


## Usage
Just clone it to your mac and run with any version of XCode 9+.
