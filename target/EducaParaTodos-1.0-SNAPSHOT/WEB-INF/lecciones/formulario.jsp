<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cl.educaparatodos.model.Leccion" %>

<%
    Leccion leccion = (Leccion) request.getAttribute("leccion");
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Editar lección - EducaParaTodos</title>

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

        <div class="card shadow-sm">

            <div class="card-header bg-warning">
                <h4 class="mb-0">
                    Editar lección
                </h4>
            </div>

            <div class="card-body">

                <form action="${pageContext.request.contextPath}/lecciones"
                      method="post">

                    <input type="hidden"
                           name="accion"
                           value="actualizar">

                    <input type="hidden"
                           name="id"
                           value="<%= leccion.getId() %>">

                    <input type="hidden"
                           name="cursoId"
                           value="<%= leccion.getCurso().getId() %>">

                    <div class="mb-3">

                        <label class="form-label">
                            Título
                        </label>

                        <input type="text"
                               name="titulo"
                               class="form-control"
                               value="<%= leccion.getTitulo() %>"
                               required>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">
                            Contenido
                        </label>

                        <textarea name="contenido"
                                  class="form-control"
                                  rows="6"
                                  required><%= leccion.getContenido() %></textarea>

                    </div>

                    <div class="row">

                        <div class="col-md-6 mb-3">

                            <label class="form-label">
                                Orden
                            </label>

                            <input type="number"
                                   name="orden"
                                   class="form-control"
                                   value="<%= leccion.getOrden() %>"
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
                                   value="<%= leccion.getDuracion() %>"
                                   min="1"
                                   required>

                        </div>

                    </div>

                    <button type="submit"
                            class="btn btn-success">
                        Guardar cambios
                    </button>

                    <a href="${pageContext.request.contextPath}/cursos?accion=detalle&id=<%= leccion.getCurso().getId() %>"
                       class="btn btn-secondary">
                        Cancelar
                    </a>

                </form>

            </div>

        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
    </script>

</body>

</html>