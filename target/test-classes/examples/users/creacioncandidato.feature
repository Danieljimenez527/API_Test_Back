Feature: creacion de candidatos

  Background:
    Given url 'http://localhost:8080/api/candidate/'

  Scenario: Registrar un nuevo candidato correctamente
    Given request
    """
    {
      "name": "Daniel",
      "lastName": "Sierra Peña",
      "card": 1112020041,
      "phone": 3170002232,
      "city": "Popayan",
      "email": "maceo@gmail.com",
      "birthdate": "2015-10-30",
      "source": "Computrabajo",
      "skills": "Java, MySQL, C+",
      "yearsExperience": "5",
      "workExperience": "developer",
      "seniority": "senior",
      "salaryAspiration": 4000000,
      "level": 12,
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

  Scenario: actualizacion de un candidato correctamente
    Given url 'http://localhost:8080/api/candidate/1'
    And request
  """
  {
    "name": "Pedro",
    "lastName": "Pineda Duran",
    "card": 1000234523,
    "phone": 6002004050,
    "city": "Manizales",
    "email": "pablito@gmail.com",
    "birthdate": "1999-01-02",
    "source": "Computrabajo",
    "skills": "Java, MySQL, C+",
    "yearsExperience": "2",
    "workExperience": "Developer",
    "seniority": "junior",
    "salaryAspiration": 3000000,
    "level": 13,
    "datePresentation": "2025-03-15",
    "origin": 1,
    "jobProfile": 1
  }
  """
    When method PUT
    Then status 200