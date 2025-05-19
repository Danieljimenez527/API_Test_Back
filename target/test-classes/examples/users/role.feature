Feature: Gestión de vacantes por empresa

  Background:
    * url 'http://localhost:8082/api/role/'

  Scenario: API-CP28 - Obtener vacante por ID válido
    Given path '1'
    When method get
    Then status 200

  Scenario: API-CP29 - Obtener vacante por ID inexistente
    Given path '99999'
    When method get
    Then status 404

  Scenario: API-CP30 - Obtener todas las vacantes
    When method get
    Then status 200

  Scenario: API-CP31 - Crear una nueva vacante correctamente
    Given request
    """
    {
      "nameRole": "abogado",
      "description": "especialista derecho de familia",
      "contract": "indefinido",
      "salary": 4200000,
      "level": 09,
      "seniority": "Senior",
      "skills": "Postman, Jira, screenplay",
      "experience": "3 años",
      "assignmentTime": "2026-05-19",
      "status": "ACTIVE",
      "jobProfile": 2,
      "origin": 2
    }
    """
    When method post
    Then status 201

  Scenario: API-CP32 - No permitir creación de vacante con datos incompletos
    Given request
    """
    {
      "description": "Vacante incompleta",
      "salary": 2800000
    }
    """
    When method post
    Then status 400

  Scenario: API-CP33 - Actualizar los datos de una vacante existente
    Given path '4'
    Given request
    """
    {
       "nameRole": "abogado",
      "description": "especialista derecho de familia",
      "contract": "indefinido",
      "salary": 4230000,
      "level": 10,
      "seniority": "Senior",
      "skills": "Postman, Jira, screenplay",
      "experience": "3 años",
      "assignmentTime": "2027-05-19",
      "status": "ACTIVE",
      "jobProfile": 2,
      "origin": 2
    }
    """
    When method PUT
    Then status 200

  Scenario: API-CP34 - Actualizar una vacante inexistente
    Given path '999'
    Given request
    """
    {
     "nameRole": "QC999999",
      "description": "Vacante para QA manual",
      "contract": "indefinido",
      "salary": 4000000,
      "level": 12,
      "seniority": "Junior",
      "skills": "Cucumber, karate, Postman, Jira",
      "experience": "1 año en QA manual",
      "assignmentTime": "2025-04-10",
      "status": "ACTIVE",
      "jobProfile": 2,
      "origin": 1
    }
    """
    When method PUT
    Then status 404
    And match response.Message == "There is not entity with that identification"

  Scenario: API-CP35 - Actualizar una vacante con datos incorrectos
    Given path '1'
    Given request
    """
    {
    "nameRole": "string",
  "description": "string",
  "contract": "string",
  "salary": 1000000,
  "level": 18,
  "seniority": "string",
  "skills": "string",
  "experience": "string",
  "assignmentTime": "2026/50/31",
  "status": "ACTIVE",
  "jobProfile": 1,
  "origin": 1
  }
    """
    When method PUT
    Then status 400

  Scenario: API-CP36 - Eliminar una vacante existente
    Given path '2'
    When method DELETE
    Then status 204

  Scenario: API-CP37 - Eliminacion de vacante inexistente
    Given path '888'
    When method DELETE
    Then status 404
    And match response.Message == "There is not entity with that identification"