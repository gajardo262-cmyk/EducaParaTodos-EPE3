package cl.educaparatodos.controller;

import cl.educaparatodos.dao.LeccionDAO;
import cl.educaparatodos.model.Leccion;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/lecciones")
public class LeccionController extends HttpServlet {

        private LeccionDAO leccionDAO;

        @Override
        public void init() {
                leccionDAO = new LeccionDAO();
        }

        @Override
        protected void doGet(HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                String accion = request.getParameter("accion");

                if (accion == null) {
                        response.sendError(
                                        HttpServletResponse.SC_BAD_REQUEST,
                                        "Acción no especificada");
                        return;
                }

                switch (accion) {

                        case "editar":
                                mostrarEditar(request, response);
                                break;

                        case "eliminar":
                                eliminar(request, response);
                                break;

                        default:
                                response.sendError(
                                                HttpServletResponse.SC_BAD_REQUEST,
                                                "Acción no válida");
                                break;
                }
        }

        @Override
        protected void doPost(HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                request.setCharacterEncoding("UTF-8");

                String accion = request.getParameter("accion");

                if (accion == null || accion.equals("crear")) {
                        crear(request, response);
                        return;
                }

                switch (accion) {

                        case "actualizar":
                                actualizar(request, response);
                                break;

                        default:
                                response.sendError(
                                                HttpServletResponse.SC_BAD_REQUEST,
                                                "Acción no válida");
                                break;
                }
        }

        private void crear(HttpServletRequest request,
                        HttpServletResponse response)
                        throws IOException {

                Long cursoId = Long.parseLong(request.getParameter("cursoId"));

                String titulo = request.getParameter("titulo");

                String contenido = request.getParameter("contenido");

                int orden = Integer.parseInt(request.getParameter("orden"));

                int duracion = Integer.parseInt(request.getParameter("duracion"));

                Leccion leccion = new Leccion();

                leccion.setTitulo(titulo);
                leccion.setContenido(contenido);
                leccion.setOrden(orden);
                leccion.setDuracion(duracion);

                leccionDAO.crear(leccion, cursoId);

                response.sendRedirect(
                                request.getContextPath()
                                                + "/cursos?accion=detalle&id="
                                                + cursoId
                                                + "&mensaje=leccionCreada");
        }

        private void mostrarEditar(HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                Long id = Long.parseLong(request.getParameter("id"));

                Leccion leccion = leccionDAO.buscarPorId(id);

                if (leccion == null) {

                        response.sendError(
                                        HttpServletResponse.SC_NOT_FOUND,
                                        "Lección no encontrada");

                        return;
                }

                request.setAttribute("leccion", leccion);

                request.getRequestDispatcher(
                                "/WEB-INF/lecciones/formulario.jsp").forward(request, response);
        }

        private void actualizar(HttpServletRequest request,
                        HttpServletResponse response)
                        throws IOException {

                Long id = Long.parseLong(request.getParameter("id"));

                Long cursoId = Long.parseLong(request.getParameter("cursoId"));

                String titulo = request.getParameter("titulo");

                String contenido = request.getParameter("contenido");

                int orden = Integer.parseInt(request.getParameter("orden"));

                int duracion = Integer.parseInt(request.getParameter("duracion"));

                Leccion leccion = new Leccion();

                leccion.setId(id);
                leccion.setTitulo(titulo);
                leccion.setContenido(contenido);
                leccion.setOrden(orden);
                leccion.setDuracion(duracion);

                leccionDAO.actualizar(leccion);

                response.sendRedirect(
                                request.getContextPath()
                                                + "/cursos?accion=detalle&id="
                                                + cursoId
                                                + "&mensaje=leccionActualizada");
        }

        private void eliminar(HttpServletRequest request,
                        HttpServletResponse response)
                        throws IOException {

                Long id = Long.parseLong(request.getParameter("id"));

                Long cursoId = leccionDAO.eliminar(id);

                if (cursoId == null) {

                        response.sendError(
                                        HttpServletResponse.SC_NOT_FOUND,
                                        "Lección no encontrada");

                        return;
                }

                response.sendRedirect(
                                request.getContextPath()
                                                + "/cursos?accion=detalle&id="
                                                + cursoId
                                                + "&mensaje=leccionEliminada");
        }
}