Feature: Casos de prueba de la tabla candidate state

  Background:
    Given url 'http://localhost:8082'
    And path 'api', 'candidate_state', 1

  Scenario: CP18 avanzar un candidato al siguiente estado
    Given request
  """
  {
    "stateId": 5,
    "description": "Termino prueba",
    "status": true,
    "assignedDate": "2025-01-01"
  }
  """
    When method PUT
    Then status 200

    Scenario: CP23 verificar que se rechace un candidato correctamente
      Given request
      """
  {
    "stateId": 2,
    "description": "candidato rechazado",
    "status": false,
    "assignedDate": "2025-01-01"
  }
  """
      When method PUT
      Then status 200