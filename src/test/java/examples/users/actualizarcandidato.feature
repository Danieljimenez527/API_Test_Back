Feature: Validar actualización y eliminación de candidatos

  Background:
    * url 'http://localhost:8080/api/candidate'

  Scenario: API-CP09 - Actualizar datos correctamente de un candidato existente
    Given path '1'
    And request
      """
      {
    "name": "Jose Jose",
    "lastName": "Pérez Pineda",
    "card": 1035883010,
    "phone": 3012005060,
    "city": "Ibague",
    "email": "juan.perez@example.com",
    "birthdate": "2002-10-29",
    "source": "LinkedIn",
    "skills": "Java, SQL, Python",
    "yearsExperience": "3 años",
    "workExperience": "Developer",
    "seniority": "Junior",
    "salaryAspiration": "1000000",
    "level": 11,
    "datePresentation": "2025-04-22",
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
    "origin": 1,
    "jobProfile": 1,
   }
   """
    When method PUT
    Then status 404
    And match response.Message == "There is no entity with that identification"

  Scenario: API-CP11 - No se puede actualizar con datos inválidos (fecha incorrecta)
    Given path '1'
    And request
      """
      {
        "id": 1,
    "name": "Juan",
    "lastName": "Pérez",
    "card": 1035883010,
    "phone": 3012005060,
    "city": "Neiva",
    "email": "juan.perez@example.com",
    "birthdate": "2002-10-29",
    "source": "LinkedIn",
    "skills": "Java, SQL, Python",
    "yearsExperience": "3 años",
    "workExperience": "Developer",
    "seniority": "Junior",
    "salaryAspiration": "DOS LUCAS",
    "level": 1,
    "datePresentation": "2025-50-22",
    "origin": 1,
    "jobProfile": 1,
      }
      """
    When method PUT
    Then status 400


  Scenario: API-CP12 - Eliminar un candidato correctamente
    Given path '16'
    When method DELETE
    Then status 204

  Scenario: API-CP13 - No se puede eliminar un candidato que no existe
    Given path '99999'
    When method DELETE
    Then status 404
    And match response.Message == "There is no entity with that identification"
