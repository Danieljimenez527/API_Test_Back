function fn() {
  var env = karate.env; // Obtener la variable de entorno 'karate.env'
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'dev';
  }

  var config = {
    env: env,
    baseUrl: 'http://localhost:8082/api/candidate/' // Base URL de la API
  };

  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);

  return config;
}