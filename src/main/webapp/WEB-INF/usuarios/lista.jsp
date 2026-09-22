<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="cl.educaparatodos.model.Usuario" %>

<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
    String mensaje = request.getParameter("mensaje");
    String cantidad = request.getParameter("cantidad");
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Usuarios - EducaParaTodos</title>

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
                <h1>Usuarios</h1>

                <p class="text-muted">
                    Administración de usuarios registrados.
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/usuarios?accion=nuevo"
               class="btn btn-success">
                + Nuevo usuario
            </a>

        </div>

        <% if ("desactivados".equals(mensaje)) { %>

            <div class="alert alert-success alert-dismissible fade show">

                Se desactivaron
                <strong><%= cantidad %></strong>
                usuario(s) correctamente.

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
                usuario(s) correctamente.

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        <% } %>

        <% if ("noSePuedeEliminar".equals(mensaje)) { %>

            <div class="alert alert-warning alert-dismissible fade show"
                 role="alert">

                <strong>No se puede eliminar el usuario.</strong>
                El usuario se encuentra inscrito en uno o más cursos.

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        <% } %>

        <% if ("usuarioEliminado".equals(mensaje)) { %>

            <div class="alert alert-success alert-dismissible fade show"
                 role="alert">

                Usuario eliminado correctamente.

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        <% } %>

        <div class="card shadow-sm mb-4 border-warning">

            <div class="card-header bg-warning-subtle">

                <h5 class="mb-0">
                    Administración masiva de usuarios
                </h5>

            </div>

            <div class="card-body">

                <div class="row g-4">

                    <div class="col-md-6">

                        <form action="${pageContext.request.contextPath}/usuarios"
                              method="post">

                            <input type="hidden"
                                   name="accion"
                                   value="desactivarAntiguos">

                            <label class="form-label">
                                Desactivar usuarios registrados antes de:
                            </label>

                            <input type="date"
                                   name="fecha"
                                   class="form-control mb-3"
                                   required>

                            <button type="submit"
                                    class="btn btn-warning w-100"
                                    onclick="return confirm('¿Deseas desactivar los usuarios anteriores a esta fecha?');">
                                Desactivar usuarios
                            </button>

                        </form>

                    </div>

                    <div class="col-md-6">

                        <form action="${pageContext.request.contextPath}/usuarios"
                              method="post">

                            <input type="hidden"
                                   name="accion"
                                   value="eliminarInactivos">

                            <label class="form-label">
                                Eliminar usuarios inactivos registrados antes de:
                            </label>

                            <input type="date"
                                   name="fecha"
                                   class="form-control mb-3"
                                   required>

                            <button type="submit"
                                    class="btn btn-danger w-100"
                                    onclick="return confirm('Esta operación eliminará usuarios inactivos que cumplan el criterio. ¿Deseas continuar?');">
                                Eliminar usuarios inactivos
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
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Correo</th>
                                <th>Fecha registro</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>

                        </thead>

                        <tbody>

                            <% if (usuarios != null && !usuarios.isEmpty()) { %>

                                <% for (Usuario usuario : usuarios) { %>

                                    <tr>

                                        <td>
                                            <%= usuario.getId() %>
                                        </td>

                                        <td>
                                            <strong>
                                                <%= usuario.getNombre() %>
                                                <%= usuario.getApellido() %>
                                            </strong>
                                        </td>

                                        <td>
                                            <%= usuario.getCorreo() %>
                                        </td>

                                        <td>
                                            <%= usuario.getFechaRegistro() %>
                                        </td>

                                        <td>

                                            <% if (usuario.isActivo()) { %>

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

                                            <a href="${pageContext.request.contextPath}/usuarios?accion=perfil&id=<%= usuario.getId() %>"
                                               class="btn btn-primary btn-sm">
                                                Ver perfil
                                            </a>

                                            <a href="${pageContext.request.contextPath}/usuarios?accion=editar&id=<%= usuario.getId() %>"
                                               class="btn btn-warning btn-sm">
                                                Editar
                                            </a>

                                            <a href="${pageContext.request.contextPath}/usuarios?accion=eliminar&id=<%= usuario.getId() %>"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('¿Seguro que deseas eliminar este usuario?');">
                                                Eliminar
                                            </a>

                                        </td>

                                    </tr>

                                <% } %>

                            <% } else { %>

                                <tr>

                                    <td colspan="6"
                                        class="text-center text-muted py-4">
                                        No existen usuarios registrados.
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