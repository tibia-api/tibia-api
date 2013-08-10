Feature: Worlds API

  I want to be able to get a list of all the worlds
  So that I know which worlds exist and their information
  such as online players, region and type

  Scenario: Tibia Site responds successfully
    Given that the Tibia website is up and responding successfully
    When I make a GET request to /api/worlds.json
    Then I should get a "worlds" list JSON like the following:
      """
      {
        "worlds": [
          {
            "name": "Aldora",
            "online": "<number>",
            "location": "Europe",
            "type": "Open PvP",
            "additional": ""
          },
          // ...
          {
            "name": "Aurera",
            "online": "<number>",
            "location": "North America",
            "type": "Open PvP",
            "additional": "locked, preview game world"
          },
          // ...
          {
            "name": "Calva",
            "online": "<number>",
            "location": "Europe",
            "type": "Hardcore PvP",
            "additional": "free-to-move"
          },
          // ...
          {
            "name": "Unitera",
            "online": "<number>",
            "location": "North America",
            "type": "Optional PvP",
            "additional": ""
          }
          // ...
        ]
      }
      """
