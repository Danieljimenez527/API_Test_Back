Feature: creacion de candidatos

  Background:
    Given url 'http://localhost:8080/api/candidate/'

  Scenario: Registrar un nuevo candidato correctamente
    Given request
    """
    {
      "name": "Pastor",
      "lastName": "Lopez",
      "card": 41853111,
      "phone": 303870039,
      "city": "Yolombo",
      "email": "Aguapachero@hotmail.com",
      "birthdate": "1985-02-08",
      "source": "LinkedIn",
      "skills": "Java, MySQL, C+",
      "yearsExperience": "4",
      "workExperience": "developer",
      "seniority": "senior",
      "salaryAspiration": 1500000,
      "level": 13,
      "datePresentation": "2025-02-22",
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
      "name": "Sara",
    "lastName": "Cifuentes",
    "card": 1000085233,
    "phone": 3045275455,
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
    And match response == { "Message": "There is already a id card with that number" }

  Scenario: actualizacion de un candidato correctamente
    Given url 'http://localhost:8080/api/candidate/3'
    And request
  """
  {
    "name": "Daniel",
    "lastName": "Peña Jimenez",
    "card": 1037873787,
    "phone": 3193961767,
    "city": "Copacabana",
    "email": "Dany2pac@gmail.com",
    "birthdate": "1992-12-02",
    "source": "Computrabajo",
    "skills": "screenplay, java, cucumber, karate, azure",
    "yearsExperience": "4",
    "workExperience": "QC Automation",
    "seniority": "junior",
    "salaryAspiration": 5400000,
    "level": 10,
    "datePresentation": "2025-01-22",
    "origin": 1,
    "jobProfile": 1
  }
  """
    When method PUT
    Then status 200