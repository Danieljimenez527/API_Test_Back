package examples.users;

import com.intuit.karate.junit5.Karate;

class RunnerTest {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("busquedacandidato", "creacioncandidato", "vacancycompany.feature", "actualizarcandidato.feature").relativeTo(getClass());
    }

}


