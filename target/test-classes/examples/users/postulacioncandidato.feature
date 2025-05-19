Feature: Validar la postulacion de un candidato

  Background:
    Given url 'http://localhost:8082/api/postulation/'

  Scenario: API-CP15 Postular un candidato a una vacante
    Given request
    """
    {
  "datePresentation": "2025-05-01",
  "status": "ACTIVE",
  "roleId": 3,
  "candidateId": 2,
}
    """
    When method POST
    Then status 201

  Scenario: API-CP17 No permitir postular un candidato con proceso activo
    Given request
    """
    {
  "datePresentation": "2025-03-01",
  "status": "ACTIVE",
  "roleId": 3,
  "candidateId": 2,

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
  "status": "ACTIVE",
  "roleId": 4,
  "candidateId": 4,

}
    """
    When method POST
    Then status 400

    Scenario: API-CP21 mensaje adecuado de candidato sin postulacion
      Given path '999'
      When method get
      Then status 404
      And match response.Message == "There is not entity with that identification"