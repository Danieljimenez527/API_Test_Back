Feature: Pruebas de API para la búsqueda de candidatos

  Background:
    Given url 'http://localhost:8082/api/candidate/'

  Scenario: API-CP01 - Búsqueda por Nombre Completo Válido
    Given path 'search-fullName/Daniel Jimenez'
    When method get
    Then status 200
    * print 'Respuesta de la API:', response
    And match response.candidates[0].name == 'Daniel'

  Scenario: API-CP02 - Búsqueda por Nombre Parcial
    Given path 'search-fullName/Da'
    When method get
    Then status 200
    And match response.candidates[0].name == '#regex (?i)Daniel.*'

  Scenario: API-CP03 - Búsqueda por Nombre Inexistente
    Given path 'search-fullName/María García'
    When method get
    Then status 404
    And match response.Message == "The candidate does not exist"

  Scenario: API-CP04 - Búsqueda de candidato por ID
    Given path 'id/3'
    When method get
    Then status 200
    And match response.id == 3

  Scenario: API-CP05 - Búsqueda por ID inexistente
    Given path 'id/99999'
    When method get
    Then status 404
    And match response.Message == "The candidate does not exist"

  Scenario: API-CP14 - Busqueda de todos los candidatos en la BD
    Given path ''
    When method get
    Then status 200