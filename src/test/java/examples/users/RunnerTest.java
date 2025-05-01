package examples.users;

import com.intuit.karate.junit5.Karate;

class RunnerTest {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("busquedacandidato", "creacioncandidato",
                "role.feature", "actualizarcandidato.feature",
                "postulacioncandidato.feature").relativeTo(getClass());
    }

}


