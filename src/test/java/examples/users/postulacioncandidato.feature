Feature: Validar la postulacion de un candidato

  Background:
    Given url 'http://localhost:8082/api/postulation/'

  Scenario: API-CP15 Postular un candidato a una vacante
    Given request
    """
    {
  "datePresentation": "2025-02-01",
  "roleId": 3,
  "candidateId": 10,
  "status": true
}
    """
    When method POST
    Then status 201

  Scenario: API-CP17 No permitir postular un candidato con proceso activo
    Given request
    """
    {
  "datePresentation": "2025-03-01",
  "roleId": 4,
  "candidateId": 1,
  "status": true
}
    """
    When method POST
    Then status 409
    And match response.Message == "You have already submitted an active application"

  Scenario: API-CP20 Verificar que no se permita postular un candidato con datos invalidos
    Given request
    """
    {
  "datePresentation": "2025-50-01",
  "roleId": 4,
  "candidateId": 2,
  "status": true
}
    """
    When method POST
    Then status 400