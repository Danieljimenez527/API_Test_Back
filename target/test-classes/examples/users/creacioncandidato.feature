Feature: creacion de candidatos

  Background:
    Given url 'http://localhost:8082/api/candidate/'

  Scenario: CP06 Registrar un nuevo candidato correctamente
    Given request
    """
    {
      "name": "Austin",
      "lastName": "Santos",
      "card": 00357855,
      "phone": 3000005555,
      "city": "San juan",
      "email": "arcangel@hotmail.com",
      "birthdate": "1982-07-07",
      "source": "linkedin",
      "skills": " MySQL worbench, postman, swagger",
      "yearsExperience": "3",
      "workExperience": "3 años",
      "seniority": "junior",
      "salaryAspiration": 3100000,
      "level": 12,
      "datePresentation": "2025-03-17",
      "status": "ACTIVE",
      "origin": 1,
      "jobProfile": 1
    }
    """
    When method POST
    Then status 201

  Scenario: CP07 No permitir crear un candidato con datos incompletos
    Given request
    """
    {
      "name": "Andres",
      "lastName": "Parra",
      "card": null,
      "phone": 3002004050,
      "city": "Quibdo",
      "email": "pablito@gmail.com",
      "birthdate": "1999-12-12",
      "source": "Computrabajo",
      "skills": "Angular, AWS, MySQL",
      "yearsExperience": "2",
      "workExperience": "developer",
      "seniority": "junior",
      "salaryAspiration": 3500000,
      "level": 13,
      "datePresentation": "2025-03-01",
      "status": "ACTIVE",
      "origin": 1,
      "jobProfile": 1
    }
    """
    When method POST
    Then status 400
    And match response == { "card": "card cannot be null" }

  Scenario: CP08 No permitir la creación de un candidato duplicado
    Given request
    """
    {
     "name": "Daniel",
    "lastName": "Jimenez",
    "card": 1035863287,
    "phone": 3193961767,
    "city": "Copacabana",
    "email": "nacional@gmail.com",
    "birthdate": "1993-12-02",
    "source": "string",
    "skills": "string",
    "yearsExperience": "2",
    "workExperience": "1 año en zynoa software house",
    "seniority": "senior",
    "salaryAspiration": "3000000",
    "level": 13,
    "datePresentation": "2025-04-01",
    "status": "ACTIVE",
    "origin": 1,
    "jobProfile": 1
    }
    """
    When method POST
    Then status 409
    And match response == {"message":"There is already a card with that parameter"}
