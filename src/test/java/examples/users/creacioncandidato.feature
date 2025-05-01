Feature: creacion de candidatos

  Background:
    Given url 'http://localhost:8082/api/candidate/'

  Scenario: CP06 Registrar un nuevo candidato correctamente
    Given request
    """
    {
      "name": "Romulo",
      "lastName": "Caicedo",
      "card": 43357855,
      "phone": 3198005555,
      "city": "Sonson",
      "email": "cerrolargo@hotmail.com",
      "birthdate": "1980-03-08",
      "source": "linkedin",
      "skills": " MySQL, swagger",
      "yearsExperience": "2",
      "workExperience": "desarrollador",
      "seniority": "junior",
      "salaryAspiration": 2900000,
      "level": 12,
      "datePresentation": "2025-03-17",
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
     "name": "Sara",
    "lastName": "Cifuentes",
    "card": 1000025059,
    "phone": 3205270001,
    "city": "Medellin",
    "email": "sharis@gmail.com",
    "birthdate": "1999-12-16",
    "source": "Linkedin",
    "skills": "cucumber, java, karate",
    "yearsExperience": "1",
    "workExperience": "QA manual",
    "seniority": "junior",
    "salaryAspiration": "2000000",
    "level": 12,
    "datePresentation": "2023-07-29",
    "origin": 1,
    "jobProfile": 3
    }
    """
    When method POST
    Then status 409
    And match response == {"message":"There is already a card with that parameter"}
