Feature: creacion de candidatos

  Background:
    Given url 'http://localhost:8080/api/candidate/'

  Scenario: Registrar un nuevo candidato correctamente
    Given request
    """
    {
      "name": "Daniel Jose",
      "lastName": "Ortiz Jimenez",
      "card": 1038234554,
      "phone": 3212004077,
      "city": "Bucaramanga",
      "email": "pablito@gmail.com",
      "birthdate": "1997-01-01",
      "source": "Computrabajo",
      "skills": "Java, MySQL, C+",
      "yearsExperience": "3",
      "workExperience": "developer",
      "seniority": "junior",
      "salaryAspiration": 3200000,
      "level": 13,
      "datePresentation": "2025-03-01",
      "origin": 1,
      "jobProfile": 1
    }
    """
    When method POST
    Then status 201

  Scenario: No permitir crear un candidato con datos incompletos
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
      "origin": 1,
      "jobProfile": 1
    }
    """
    When method POST
    Then status 400
    And match response == { "card": "card cannot be null" }

  Scenario: No permitir la creación de un candidato duplicado
    Given request
    """
    {
      "name": "Pablo Jose",
      "lastName": "Osorio Jimenez",
      "card": 1000234567,
      "phone": 3002004050,
      "city": "Manizales",
      "email": "pablito@gmail.com",
      "birthdate": "1999-01-01",
      "source": "Computrabajo",
      "skills": "Java, MySQL, C+",
      "yearsExperience": "2",
      "workExperience": "developer",
      "seniority": "junior",
      "salaryAspiration": 3000000,
      "level": 13,
      "datePresentation": "2025-03-01",
      "origin": 1,
      "jobProfile": 1
    }





    """
    When method POST
    Then status 409
    And match response == { "Message": "There is already a id card with that number" }


