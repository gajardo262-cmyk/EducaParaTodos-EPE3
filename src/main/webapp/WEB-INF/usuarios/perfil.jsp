<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cl.educaparatodos.model.Usuario" %>
<%@ page import="cl.educaparatodos.model.Curso" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    List<Curso> cursos = (List<Curso>) request.getAttribute("cursos");
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Perfil - <%= usuario.getNombre() %>
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

            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">
                    Perfil del usuario
                </h4>
            </div>

            <div class="card-body">

                <h2>
                    <%= usuario.getNombre() %>
                    <%= usuario.getApellido() %>
                </h2>

                <hr>

                <p>
                    <strong>Correo:</strong>
                    <%= usuario.getCorreo() %>
                </p>

                <p>
                    <strong>Fecha de registro:</strong>
                    <%= usuario.getFechaRegistro() %>
                </p>

                <p>
                    <strong>Estado:</strong>

                    <% if (usuario.isActivo()) { %>

                        <span class="badge bg-success">
                            Activo
                        </span>

                    <% } else { %>

                        <span class="badge bg-danger">
                            Inactivo
                        </span>

                    <% } %>

                </p>

                <a href="${pageContext.request.contextPath}/usuarios"
                   class="btn btn-outline-primary">
                    ← Volver a usuarios
                </a>

            </div>

        </div>

        <% if ("inscrito".equals(request.getParameter("mensaje"))) { %>

            <div class="alert alert-success">
                Usuario inscrito correctamente en el curso.
            </div>

        <% } %>

        <% if ("yaInscrito".equals(request.getParameter("mensaje"))) { %>

            <div class="alert alert-warning">
                El usuario ya se encuentra inscrito en este curso.
            </div>

        <% } %>

        <div class="card shadow-sm mb-4">

            <div class="card-header bg-success text-white">
                <h4 class="mb-0">
                    Inscribir en un curso
                </h4>
            </div>

            <div class="card-body">

                <% if (cursos != null && !cursos.isEmpty()) { %>

                    <form action="${pageContext.request.contextPath}/usuarios"
                          method="post">

                        <input type="hidden"
                               name="accion"
                               value="inscribir">

                        <input type="hidden"
                               name="usuarioId"
                               value="<%= usuario.getId() %>">

                        <div class="row align-items-end">

                            <div class="col-md-9">

                                <label class="form-label">
                                    Seleccione un curso
                                </label>

                                <select name="cursoId"
                                        class="form-select"
                                        required>

                                    <option value="">
                                        Seleccione...
                                    </option>

                                    <% for (Curso curso : cursos) { %>

                                        <option value="<%= curso.getId() %>">
                                            <%= curso.getTitulo() %>
                                            - <%= curso.getNivel() %>
                                        </option>

                                    <% } %>

                                </select>

                            </div>

                            <div class="col-md-3 mt-3 mt-md-0">

                                <button type="submit"
                                        class="btn btn-success w-100">
                                    Inscribir
                                </button>

                            </div>

                        </div>

                    </form>

                <% } else { %>

                    <div class="alert alert-warning mb-0">
                        No existen cursos disponibles para realizar una inscripción.
                    </div>

                <% } %>

            </div>

        </div>

        <div class="card shadow-sm">

            <div class="card-header bg-dark text-white">
                <h4 class="mb-0">
                    Cursos inscritos
                </h4>
            </div>

            <div class="card-body">

                <% if (usuario.getCursosInscritos() != null
                        && !usuario.getCursosInscritos().isEmpty()) { %>

                    <div class="row">

                        <% for (Curso curso : usuario.getCursosInscritos()) { %>

                            <div class="col-md-6 col-lg-4 mb-3">

                                <div class="card h-100">

                                    <div class="card-body">

                                        <span class="badge bg-primary">
                                            <%= curso.getTema() %>
                                        </span>

                                        <span class="badge bg-secondary">
                                            <%= curso.getNivel() %>
                                        </span>

                                        <h5 class="card-title mt-3">
                                            <%= curso.getTitulo() %>
                                        </h5>

                                        <p class="card-text text-muted">
                                            <%= curso.getDescripcion() %>
                                        </p>

                                    </div>

                                    <div class="card-footer bg-white">

                                        <a href="${pageContext.request.contextPath}/cursos?accion=detalle&id=<%= curso.getId() %>"
                                           class="btn btn-primary btn-sm">
                                            Ver curso
                                        </a>

                                    </div>

                                </div>

                            </div>

                        <% } %>

                    </div>

                <% } else { %>

                    <div class="text-center py-5">

                        <h5 class="text-muted">
                            Este usuario todavía no está inscrito en ningún curso.
                        </h5>

                        <p class="text-muted">
                            Los cursos en los que se inscriba aparecerán aquí.
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