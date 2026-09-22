<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cl.educaparatodos.model.Curso" %>
<%@ page import="cl.educaparatodos.model.Leccion" %>

<%
    Curso curso = (Curso) request.getAttribute("curso");
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <%= curso.getTitulo() %> - EducaParaTodos
    </title>

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
                   class="btn btn-outline-light me-2">
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

    <div class="container py-5">
        <div class="card shadow-sm mb-4">
            <div class="card-body p-4">

                <div class="d-flex justify-content-between align-items-start flex-wrap">

                    <div>
                        <span class="badge bg-primary mb-2">
                            <%= curso.getTema() %>
                        </span>

                        <span class="badge bg-secondary mb-2">
                            <%= curso.getNivel() %>
                        </span>

                        <h1 class="mt-2">
                            <%= curso.getTitulo() %>
                        </h1>
                    </div>

                    <div class="text-end">
                        <small class="text-muted">
                            Popularidad
                        </small>

                        <h4>
                            <%= curso.getPopularidad() %>
                        </h4>
                    </div>

                </div>

                <hr>

                <h5>Descripción</h5>

                <p class="text-muted">
                    <%= curso.getDescripcion() %>
                </p>

                <a href="${pageContext.request.contextPath}/cursos"
                   class="btn btn-outline-primary">
                    ← Volver a cursos
                </a>

            </div>
        </div>

        <% if ("leccionCreada".equals(request.getParameter("mensaje"))) { %>
            <div class="alert alert-success">
                Lección agregada correctamente.
            </div>
        <% } %>

        <% if ("leccionActualizada".equals(request.getParameter("mensaje"))) { %>
            <div class="alert alert-success">
                Lección actualizada correctamente.
            </div>
        <% } %>

        <% if ("leccionEliminada".equals(request.getParameter("mensaje"))) { %>
            <div class="alert alert-success">
                Lección eliminada correctamente.
            </div>
        <% } %>

        <div class="card shadow-sm mb-4">

            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">
                    Agregar nueva lección
                </h4>
            </div>

            <div class="card-body">

                <form action="${pageContext.request.contextPath}/lecciones"
                      method="post">

                    <input type="hidden"
                           name="cursoId"
                           value="<%= curso.getId() %>">

                    <div class="mb-3">
                        <label class="form-label">
                            Título de la lección
                        </label>

                        <input type="text"
                               name="titulo"
                               class="form-control"
                               required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            Contenido
                        </label>

                        <textarea name="contenido"
                                  class="form-control"
                                  rows="5"
                                  required></textarea>
                    </div>

                    <div class="row">

                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                Orden
                            </label>

                            <input type="number"
                                   name="orden"
                                   class="form-control"
                                   min="1"
                                   required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                Duración (minutos)
                            </label>

                            <input type="number"
                                   name="duracion"
                                   class="form-control"
                                   min="1"
                                   required>
                        </div>

                    </div>

                    <button type="submit"
                            class="btn btn-success">
                        Agregar lección
                    </button>

                </form>

            </div>
        </div>

        <div class="card shadow-sm">

            <div class="card-header bg-dark text-white">
                <h4 class="mb-0">
                    Lecciones del curso
                </h4>
            </div>

            <div class="card-body">

                <% if (curso.getLecciones() != null
                        && !curso.getLecciones().isEmpty()) { %>

                    <div class="accordion"
                         id="accordionLecciones">

                        <% for (Leccion leccion : curso.getLecciones()) { %>

                            <div class="accordion-item">

                                <h2 class="accordion-header">

                                    <button class="accordion-button collapsed"
                                            type="button"
                                            data-bs-toggle="collapse"
                                            data-bs-target="#leccion<%= leccion.getId() %>">

                                        Lección <%= leccion.getOrden() %>:
                                        &nbsp;
                                        <%= leccion.getTitulo() %>

                                    </button>

                                </h2>

                                <div id="leccion<%= leccion.getId() %>"
                                     class="accordion-collapse collapse"
                                     data-bs-parent="#accordionLecciones">

                                    <div class="accordion-body">

                                        <p>
                                            <%= leccion.getContenido() %>
                                        </p>

                                        <hr>

                                        <small class="text-muted">
                                            Duración aproximada:
                                            <strong>
                                                <%= leccion.getDuracion() %> minutos
                                            </strong>
                                        </small>

                                        <div class="mt-3">

                                            <a href="${pageContext.request.contextPath}/lecciones?accion=editar&id=<%= leccion.getId() %>"
                                               class="btn btn-warning btn-sm">
                                                Editar
                                            </a>

                                            <a href="${pageContext.request.contextPath}/lecciones?accion=eliminar&id=<%= leccion.getId() %>"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('¿Está seguro de eliminar esta lección?');">
                                                Eliminar
                                            </a>

                                        </div>

                                    </div>
                                </div>

                            </div>

                        <% } %>

                    </div>

                <% } else { %>

                    <div class="text-center py-5">

                        <h5 class="text-muted">
                            Este curso todavía no tiene lecciones.
                        </h5>

                        <p class="text-muted">
                            Próximamente se agregarán nuevos contenidos.
                        </p>

                    </div>

                <% } %>

            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
    </script>

</body>
</html>