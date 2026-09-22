<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cl.educaparatodos.model.Curso" %>

<%
    Curso curso = (Curso) request.getAttribute("curso");
    boolean editando = curso != null;
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <%= editando ? "Editar Curso" : "Nuevo Curso" %> - EducaParaTodos
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

            <div class="col-lg-8">

                <div class="card shadow-sm">

                    <div class="card-body p-4">

                        <h2 class="mb-2">
                            <%= editando ? "Editar curso" : "Crear nuevo curso" %>
                        </h2>

                        <p class="text-muted mb-4">
                            Completa la información del curso.
                        </p>

                        <form action="${pageContext.request.contextPath}/cursos"
                              method="post">

                            <% if (editando) { %>

                                <input type="hidden"
                                       name="accion"
                                       value="actualizar">

                                <input type="hidden"
                                       name="id"
                                       value="<%= curso.getId() %>">

                            <% } else { %>

                                <input type="hidden"
                                       name="accion"
                                       value="crear">

                            <% } %>

                            <div class="mb-3">

                                <label class="form-label">
                                    Título del curso
                                </label>

                                <input type="text"
                                       name="titulo"
                                       class="form-control"
                                       required
                                       maxlength="150"
                                       value="<%= editando ? curso.getTitulo() : "" %>">

                            </div>

                            <div class="mb-3">

                                <label class="form-label">
                                    Descripción
                                </label>

                                <textarea name="descripcion"
                                          class="form-control"
                                          rows="4"
                                          maxlength="1000"
                                          required><%= editando ? curso.getDescripcion() : "" %></textarea>

                            </div>

                            <div class="mb-3">

                                <label class="form-label">
                                    Tema
                                </label>

                                <input type="text"
                                       name="tema"
                                       class="form-control"
                                       placeholder="Ej: Programación"
                                       required
                                       value="<%= editando ? curso.getTema() : "" %>">

                            </div>

                            <div class="mb-4">

                                <label class="form-label">
                                    Nivel
                                </label>

                                <select name="nivel"
                                        class="form-select"
                                        required>

                                    <option value="">
                                        Selecciona un nivel
                                    </option>

                                    <option value="Básico"
                                            <%= editando && "Básico".equals(curso.getNivel())
                                                ? "selected" : "" %>>
                                        Básico
                                    </option>

                                    <option value="Intermedio"
                                            <%= editando && "Intermedio".equals(curso.getNivel())
                                                ? "selected" : "" %>>
                                        Intermedio
                                    </option>

                                    <option value="Avanzado"
                                            <%= editando && "Avanzado".equals(curso.getNivel())
                                                ? "selected" : "" %>>
                                        Avanzado
                                    </option>

                                </select>

                            </div>

                            <div class="d-flex justify-content-between">

                                <a href="${pageContext.request.contextPath}/cursos"
                                   class="btn btn-secondary">
                                    Cancelar
                                </a>

                                <button type="submit"
                                        class="btn btn-primary">
                                    <%= editando
                                        ? "Guardar cambios"
                                        : "Crear curso" %>
                                </button>

                            </div>

                        </form>

                    </div>

                </div>

            </div>

        </div>

    </div>

</body>

</html>