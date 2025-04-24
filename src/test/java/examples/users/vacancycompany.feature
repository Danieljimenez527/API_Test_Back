Feature: Gestión de vacantes por empresa

  Background:
    * url 'http://localhost:8080/api/company_vacancy/'

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
      "description": "Vacante para QA manual",
      "contract": "Por hora",
      "salary": 4000000,
      "level": 12,
      "seniority": "Junior",
      "skills": "Cucumber, karate, Postman, Jira",
      "experience": "1 año en QA manual",
      "assignmentTime": "2025-04-10",
      "role": 2,
      "jobProfile": 3,
      "origin": 1
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
    Given path '6'
    Given request
    """
    {
    "description": "Vacante para QA Automatizador",
      "contract": "indefinido",
      "salary": 4000000,
      "level": 9,
      "seniority": "senior",
      "skills": "Cucumber, karate, Postman, Jira",
      "experience": "2 año en QA manual",
      "assignmentTime": "2025-04-10",
      "role": 3,
      "jobProfile": 3,
      "origin": 1
    }
    """
    When method PUT
    Then status 200

  Scenario: API-CP34 - Actualizar una vacante inexistente
    Given path '999'
    Given request
    """
    {
      "description": "Vacante para QA manual",
      "contract": "Por hora",
      "salary": 4000000,
      "level": 12,
      "seniority": "Junior",
      "skills": "Cucumber, karate, Postman, Jira",
      "experience": "1 año en QA manual",
      "assignmentTime": "2025-04-10",
      "role": 2,
      "jobProfile": 3,
      "origin": 1
    }
    """
    When method PUT
    Then status 404
    And match response.Message == "There is no entity with that identification"

  Scenario: API-CP35 - Actualizar una vacante con datos incorrectos
    Given path '7'
    Given request
    """
    {
    "id": 7,
    "description": "Vacante para QA manual",
    "contract": "Por hora",
    "salary": "4000000",
    "level": 12,
    "seniority": "Junior",
    "skills": "Cucumber, karate, Postman, Jira",
    "experience": "1 año en QA manual",
    "assignmentTime": "2025-50-10",
    "jobProfileId": 3,
    "jobProfileName": "Automatizador",
    "originId": 1,
    "originName": "Sub"
  }
    """
    When method PUT
    Then status 400

  Scenario: API-CP36 - Eliminar una vacante existente
    Given path '10'
    When method DELETE
    Then status 204

  Scenario: API-CP37 - Eliminacion de vacante inexistente
    Given path '888'
    When method DELETE
    Then status 404
    And match response.Message == "There is no entity with that identification"