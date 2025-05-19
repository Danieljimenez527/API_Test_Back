Feature: Validar actualización y eliminación de candidatos

  Background:
    * url 'http://localhost:8082/api/candidate'

  Scenario: API-CP09 - Actualizar datos correctamente de un candidato existente
    Given path '2'
    And request
      """
      {
    "name": "Daniel",
    "lastName": "Peña Jimenez",
    "card": 1035863287,
    "phone": 3193961767,
    "city": "Copacabana",
    "email": "Dany@gmail.com",
    "birthdate": "1993-12-02",
    "source": "LinkedIn",
    "skills": "Java, cucumber, karate, Python",
    "yearsExperience": "2 años",
    "workExperience": "2 años en zynoa",
    "seniority": "Junior",
    "salaryAspiration": "3000000",
    "level": 13,
    "datePresentation": "2025-04-01",
    "status": "ACTIVE",
    "origin": 1,
    "jobProfile": 1,
  }
      """
    When method PUT
    Then status 200

  Scenario: API-CP10 - No se puede actualizar un candidato que no existe
    Given path '99999'
    And request
   """
   {
   "name": "pepito",
    "lastName": "Pérez",
    "card": 1035883019,
    "phone": 3012005069,
    "city": "Neiva",
    "email": "juan.perez@example.com",
    "birthdate": "2002-10-29",
    "source": "LinkedIn",
    "skills": "Java, SQL, Python",
    "yearsExperience": "3 años",
    "workExperience": "Developer",
    "seniority": "Junior",
    "salaryAspiration": "2000000",
    "level": 11,
    "datePresentation": "2025-04-22",
    "status": "ACTIVE",
    "origin": 1,
    "jobProfile": 1,
   }
   """
    When method PUT
    Then status 404
    And match response.Message == "There is not entity with that identification"

  Scenario: API-CP11 - No se puede actualizar un candidato con datos inválidos (fecha incorrecta)
    Given path '3'
    And request
      """
      {
    "name": "Sofia",
    "lastName": "Vergara",
    "card": 45667724,
    "phone": 3193951767,
    "city": "Sonson",
    "email": "unaula@gmail.com",
    "birthdate": "1993-12-02",
    "source": "string",
    "skills": "string",
    "yearsExperience": "2",
    "workExperience": "1 año en zynoa",
    "seniority": "Junior",
    "salaryAspiration": "DOS LUCAS",
    "level": 13,
    "datePresentation": "2025-50-22",
    "status": "ACTIVE",
    "origin": 1,
    "jobProfile": 1,
      }
      """
    When method PUT
    Then status 400


  Scenario: API-CP12 - Eliminar un candidato correctamente
    Given path '1'
    When method DELETE
    Then status 204

  Scenario: API-CP13 - No se puede eliminar un candidato que no existe
    Given path '99999'
    When method DELETE
    Then status 404
    And match response.Message == "There is not entity with that identification"
