Given(/^that the Tibia website is up and responding successfully$/) do
end

When(/^I make a GET request to ([^\s]+)$/) do |url|
  get url
end

Then(/^I should get a "(.*?)" list JSON like the following:$/) do |json_root, json_string|
  actual_json = JSON.parse(last_response.body)[json_root]
  expected_json = JSON.parse(json_string)[json_root]

  expect(actual_json).to include_hashes expected_json
end

