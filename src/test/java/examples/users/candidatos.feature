Feature: casos de pruebas de la tabla procesos

  Background:
    * url 'http://localhost:8082/api/process/'

    Scenario: CP16 verificar el proceso activo de un candidato
      Given path 'candidate/1'
      When method get
      Then status 200

      Scenario: CP19 Verificar que un proceso finalice correctamente
        And path '1'
        Given request
        """
        {
        "postulationId": 1,
        "description": "proceso completado",
        "assignedDate": "2025-01-01"
        }
        """
        When method PUT
        Then status 200

        Scenario: CP24 verificar que no se pueda actualizar un proceso inexistente
          And path '999'
          Given request
          """
        {
        "postulationId": 1,
        "description": "proceso completado",
        "assignedDate": "2025-01-01"
        }
        """
          When method PUT
          Then status 404
          And match response == { Message: "There is not entity with that identification"}

          Scenario: CP26 Buscar un candidato sin procesos activos y que muestre mensaje adecuado
            Given path '5'
            When method get
            Then status 404
            And match response == { Message: "The candidate does not exist"}





