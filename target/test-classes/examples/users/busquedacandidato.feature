Feature: Pruebas de API para la búsqueda de candidatos

  Background:
    Given url 'http://localhost:8080/api/candidate/'

  Scenario: API-CP01 - Búsqueda por Nombre Completo Válido
    Given path 'search-fullName/Raul Rodriguez'
    When method get
    Then status 200
    * print 'Respuesta de la API:', response
    And match response.candidates[0].name == 'Raul'

  Scenario: API-CP02 - Búsqueda por Nombre Parcial
    Given path 'search-fullName/Juan'
    When method get
    Then status 200
    And match response.candidates[0].name == '#regex (?i)Juan.*'

  Scenario: API-CP03 - Búsqueda por Nombre Inexistente
    Given path 'search-fullName/María García'
    When method get
    Then status 404
    And match response.Message == '#regex (?i).*candidate does not exist.*'

  Scenario: API-CP04 - Búsqueda de candidato por ID
    Given path 'id/1'
    When method get
    Then status 200
    And match response.id == 1

  Scenario: API-CP05 - Búsqueda por ID inexistente
    Given path 'id/99999'
    When method get
    Then status 404
    And match response.Message == '#regex (?i).*candidate does not exist.*'