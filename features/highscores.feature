@vcr
Feature: Highscores API

  I want to be able to get a list of all the characters So that I know which
  characters have most experience

  Scenario: Tibia Site responds successfully
    Given that the Tibia website is up and responding successfully
    When I make a GET request to /api/worlds/premia/highscores/experiences.json
    Then I should get a "experiences" list JSON like the following:
      """json
      {
        "experiences": [
          {
            "rank": "1",
            "name": "<string>",
            "level": "<number>",
            "points": "<number>"
          },
          // ...
          {
            "rank": "85",
            "name": "<string>",
            "level": "<number>",
            "points": "<number>"
          },
          // ...
          {
            "rank": "180",
            "name": "<string>",
            "level": "<number>",
            "points": "<number>"
          },
          // ...
          {
            "rank": "300",
            "name": "<string>",
            "level": "<number>",
            "points": "<number>"
          }
          // ...
        ]
      }
      """
