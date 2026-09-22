<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cl.educaparatodos.model.Usuario" %>

<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    boolean editando = usuario != null;
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <%= editando ? "Editar usuario" : "Nuevo usuario" %> - EducaParaTodos
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

        <div class="row justify-content-center">

            <div class="col-lg-7">

                <div class="card shadow-sm">

                    <div class="card-body p-4">

                        <h2 class="mb-4">
                            <%= editando
                                    ? "Editar usuario"
                                    : "Registrar nuevo usuario" %>
                        </h2>

                        <form action="${pageContext.request.contextPath}/usuarios"
                              method="post">

                            <% if (editando) { %>

                                <input type="hidden"
                                       name="accion"
                                       value="actualizar">

                                <input type="hidden"
                                       name="id"
                                       value="<%= usuario.getId() %>">

                            <% } else { %>

                                <input type="hidden"
                                       name="accion"
                                       value="crear">

                            <% } %>

                            <div class="mb-3">

                                <label class="form-label">
                                    Nombre
                                </label>

                                <input type="text"
                                       name="nombre"
                                       class="form-control"
                                       value="<%= editando ? usuario.getNombre() : "" %>"
                                       maxlength="100"
                                       required>

                            </div>

                            <div class="mb-3">

                                <label class="form-label">
                                    Apellido
                                </label>

                                <input type="text"
                                       name="apellido"
                                       class="form-control"
                                       value="<%= editando ? usuario.getApellido() : "" %>"
                                       maxlength="100"
                                       required>

                            </div>

                            <div class="mb-3">

                                <label class="form-label">
                                    Correo electrónico
                                </label>

                                <input type="email"
                                       name="correo"
                                       class="form-control"
                                       value="<%= editando ? usuario.getCorreo() : "" %>"
                                       maxlength="150"
                                       placeholder="ejemplo@correo.cl"
                                       required>

                            </div>

                            <% if (!editando) { %>

                                <div class="mb-4">

                                    <label class="form-label">
                                        Contraseña
                                    </label>

                                    <input type="password"
                                           name="password"
                                           class="form-control"
                                           minlength="6"
                                           required>

                                    <div class="form-text">
                                        Mínimo 6 caracteres.
                                    </div>

                                </div>

                            <% } %>

                            <div class="d-flex gap-2">

                                <button type="submit"
                                        class="btn btn-success">
                                    <%= editando
                                            ? "Guardar cambios"
                                            : "Registrar usuario" %>
                                </button>

                                <a href="${pageContext.request.contextPath}/usuarios"
                                   class="btn btn-secondary">
                                    Cancelar
                                </a>

                            </div>

                        </form>

                    </div>

                </div>

            </div>

        </div>

    </div>

</body>

</html>