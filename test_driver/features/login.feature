Feature: Login

  Scenario Outline: Login with invalid values
    When I fill the "<field_fill>" field with the content "<value>"
    And I click the button "login"
    Then I should see the "<field_blank>" field error message

    Examples:
      | field_fill | field_blank | value         |
      | email      | password    | test@test.com |
      | password   | email       | test1         |

  Scenario: Login with wrong credentials
    When I fill the "email" field with the content "test@test.com.br"
    When I fill the "password" field with the content "test1234"
    And I click the button "login"
    Then I should see a error alert