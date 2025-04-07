Feature: Gestión de vacantes por empresa

  Background:
    * url 'http://localhost:8080/api/vacancy_company/'

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
      "assignmentTime": "2025-05-10",
      "role": 2,
      "jobProfile": 1,
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