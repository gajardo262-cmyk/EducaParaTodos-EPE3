<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>EducaParaTodos</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">

            <a class="navbar-brand fw-bold"
               href="${pageContext.request.contextPath}/">
                EducaParaTodos
            </a>

            <div>
                <a href="${pageContext.request.contextPath}/"
                   class="btn btn-light me-2">
                    Inicio
                </a>

                <a href="${pageContext.request.contextPath}/cursos"
                   class="btn btn-outline-light me-2">
                    Cursos
                </a>

                <a href="${pageContext.request.contextPath}/usuarios"
                   class="btn btn-outline-light">
                    Usuarios
                </a>
            </div>

        </div>
    </nav>

    <section class="bg-primary text-white py-5">

        <div class="container py-5 text-center">

            <h1 class="display-4 fw-bold">
                Educación para todos
            </h1>

            <p class="lead mt-3">
                Aprende nuevas habilidades mediante cursos gratuitos,
                accesibles y pensados para toda la comunidad.
            </p>

            <a href="${pageContext.request.contextPath}/cursos"
               class="btn btn-light btn-lg mt-3">
                Explorar cursos
            </a>

        </div>

    </section>

    <div class="container py-5">

        <div class="text-center mb-5">

            <h2>¿Qué ofrece EducaParaTodos?</h2>

            <p class="text-muted">
                Una plataforma educativa gratuita orientada al aprendizaje
                y al acceso a nuevas oportunidades.
            </p>

        </div>

        <div class="row g-4">

            <div class="col-md-4">

                <div class="card h-100 shadow-sm border-0">

                    <div class="card-body text-center p-4">

                        <div class="display-5 mb-3">
                            📚
                        </div>

                        <h4>Cursos gratuitos</h4>

                        <p class="text-muted">
                            Accede a contenidos educativos de diferentes
                            áreas y niveles sin costo.
                        </p>

                    </div>

                </div>

            </div>

            <div class="col-md-4">

                <div class="card h-100 shadow-sm border-0">

                    <div class="card-body text-center p-4">

                        <div class="display-5 mb-3">
                            🔎
                        </div>

                        <h4>Encuentra lo que necesitas</h4>

                        <p class="text-muted">
                            Busca cursos según su tema, nivel
                            y popularidad.
                        </p>

                    </div>

                </div>

            </div>

            <div class="col-md-4">

                <div class="card h-100 shadow-sm border-0">

                    <div class="card-body text-center p-4">

                        <div class="display-5 mb-3">
                            🎓
                        </div>

                        <h4>Aprende a tu ritmo</h4>

                        <p class="text-muted">
                            Revisa las lecciones de cada curso y avanza
                            según tu propio tiempo.
                        </p>

                    </div>

                </div>

            </div>

        </div>

        <div class="text-center mt-5">

            <h3>Comienza a aprender hoy</h3>

            <p class="text-muted">
                Explora nuestros cursos y encuentra una nueva
                oportunidad para aprender.
            </p>

            <a href="${pageContext.request.contextPath}/cursos"
               class="btn btn-primary btn-lg">
                Ver cursos disponibles
            </a>

        </div>

    </div>

    <footer class="bg-dark text-white text-center py-4 mt-5">

        <div class="container">

            <p class="mb-1 fw-bold">
                EducaParaTodos
            </p>

            <small>
                Plataforma educativa gratuita para la comunidad
            </small>

        </div>

    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
    </script>

</body>

</html>