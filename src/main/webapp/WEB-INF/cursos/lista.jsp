<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="cl.educaparatodos.model.Curso" %>

<%
    List<Curso> cursos = (List<Curso>) request.getAttribute("cursos");
    String mensaje = request.getParameter("mensaje");
    String cantidad = request.getParameter("cantidad");
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Cursos - EducaParaTodos</title>

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

        <div class="d-flex justify-content-between align-items-center mb-4">

            <div>
                <h1>Cursos disponibles</h1>
            </div>

            <a href="${pageContext.request.contextPath}/cursos?accion=nuevo"
               class="btn btn-success">
                + Nuevo curso
            </a>

        </div>

        <% if ("desactivados".equals(mensaje)) { %>

            <div class="alert alert-success alert-dismissible fade show">

                Se desactivaron
                <strong><%= cantidad %></strong>
                curso(s) correctamente.

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        <% } %>

        <% if ("eliminados".equals(mensaje)) { %>

            <div class="alert alert-success alert-dismissible fade show">

                Se eliminaron
                <strong><%= cantidad %></strong>
                curso(s) inactivos correctamente.

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        <% } %>

        <% if ("noSePuedeEliminar".equals(mensaje)) { %>

            <div class="alert alert-warning alert-dismissible fade show"
                 role="alert">

                <strong>No se puede eliminar el curso.</strong>
                Existen usuarios inscritos en este curso.

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        <% } %>

        <% if ("cursoEliminado".equals(mensaje)) { %>

            <div class="alert alert-success alert-dismissible fade show"
                 role="alert">

                Curso eliminado correctamente.

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        <% } %>

        <div class="card shadow-sm mb-4">

            <div class="card-body">

                <h5 class="card-title">
                    Buscar cursos
                </h5>

                <form action="${pageContext.request.contextPath}/cursos"
                      method="get"
                      class="row g-3">

                    <input type="hidden"
                           name="accion"
                           value="buscar">

                    <div class="col-md-5">

                        <label class="form-label">
                            Tema
                        </label>

                        <input type="text"
                               name="tema"
                               class="form-control"
                               placeholder="Ej: Programación">

                    </div>

                    <div class="col-md-5">

                        <label class="form-label">
                            Nivel
                        </label>

                        <select name="nivel"
                                class="form-select">

                            <option value="">
                                Todos
                            </option>

                            <option value="Básico">
                                Básico
                            </option>

                            <option value="Intermedio">
                                Intermedio
                            </option>

                            <option value="Avanzado">
                                Avanzado
                            </option>

                        </select>

                    </div>

                    <div class="col-md-2 d-flex align-items-end">

                        <button type="submit"
                                class="btn btn-primary w-100">
                            Buscar
                        </button>

                    </div>

                </form>

            </div>

        </div>

        <div class="card shadow-sm mb-4 border-warning">

            <div class="card-header bg-warning-subtle">

                <h5 class="mb-0">
                    Administración masiva de cursos
                </h5>

            </div>

            <div class="card-body">

                <div class="row g-4">

                    <div class="col-md-7">

                        <form action="${pageContext.request.contextPath}/cursos"
                              method="post">

                            <input type="hidden"
                                   name="accion"
                                   value="desactivarMasivo">

                            <label class="form-label">
                                Desactivar cursos con popularidad menor a:
                            </label>

                            <div class="input-group">

                                <input type="number"
                                       name="minimo"
                                       class="form-control"
                                       min="0"
                                       required
                                       placeholder="Ej: 10">

                                <button type="submit"
                                        class="btn btn-warning"
                                        onclick="return confirm('¿Deseas desactivar los cursos que cumplan este criterio?');">
                                    Desactivar cursos
                                </button>

                            </div>

                        </form>

                    </div>

                    <div class="col-md-5">

                        <form action="${pageContext.request.contextPath}/cursos"
                              method="post">

                            <input type="hidden"
                                   name="accion"
                                   value="eliminarInactivos">

                            <button type="submit"
                                    class="btn btn-danger w-100"
                                    style="margin-top: 34px;"
                                    onclick="return confirm('Esta operación eliminará los cursos inactivos sin usuarios ni lecciones. ¿Deseas continuar?');">
                                Eliminar cursos inactivos
                            </button>

                        </form>

                    </div>

                </div>

            </div>

        </div>

        <div class="card shadow-sm">

            <div class="card-body">

                <div class="table-responsive">

                    <table class="table table-hover align-middle">

                        <thead class="table-dark">

                            <tr>
                                <th>Título</th>
                                <th>Tema</th>
                                <th>Nivel</th>
                                <th>Popularidad</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>

                        </thead>

                        <tbody>

                            <% if (cursos != null && !cursos.isEmpty()) { %>

                                <% for (Curso curso : cursos) { %>

                                    <tr>

                                        <td>
                                            <strong>
                                                <%= curso.getTitulo() %>
                                            </strong>
                                        </td>

                                        <td>
                                            <%= curso.getTema() %>
                                        </td>

                                        <td>
                                            <%= curso.getNivel() %>
                                        </td>

                                        <td>
                                            <%= curso.getPopularidad() %>
                                        </td>

                                        <td>

                                            <% if (curso.isActivo()) { %>

                                                <span class="badge bg-success">
                                                    Activo
                                                </span>

                                            <% } else { %>

                                                <span class="badge bg-secondary">
                                                    Inactivo
                                                </span>

                                            <% } %>

                                        </td>

                                        <td>

                                            <a href="${pageContext.request.contextPath}/cursos?accion=detalle&id=<%= curso.getId() %>"
                                               class="btn btn-primary btn-sm">
                                                Ver curso
                                            </a>

                                            <a href="${pageContext.request.contextPath}/cursos?accion=editar&id=<%= curso.getId() %>"
                                               class="btn btn-warning btn-sm">
                                                Editar
                                            </a>

                                            <a href="${pageContext.request.contextPath}/cursos?accion=eliminar&id=<%= curso.getId() %>"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('¿Seguro que deseas eliminar este curso?');">
                                                Eliminar
                                            </a>

                                        </td>

                                    </tr>

                                <% } %>

                            <% } else { %>

                                <tr>

                                    <td colspan="6"
                                        class="text-center text-muted py-4">
                                        No se encontraron cursos.
                                    </td>

                                </tr>

                            <% } %>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
    </script>

</body>

</html>