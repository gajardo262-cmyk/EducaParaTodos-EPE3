package cl.educaparatodos.controller;

import cl.educaparatodos.dao.UsuarioDAO;
import cl.educaparatodos.dao.CursoDAO;
import cl.educaparatodos.model.Usuario;
import cl.educaparatodos.model.Curso;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/usuarios")
public class UsuarioController extends HttpServlet {

        private UsuarioDAO usuarioDAO;
        private CursoDAO cursoDAO;

        @Override
        public void init() {
                usuarioDAO = new UsuarioDAO();
                cursoDAO = new CursoDAO();
        }

        @Override
        protected void doGet(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                String accion = request.getParameter("accion");

                if (accion == null) {
                        accion = "listar";
                }

                switch (accion) {

                        case "nuevo":
                                mostrarFormulario(request, response);
                                break;

                        case "editar":
                                mostrarEditar(request, response);
                                break;

                        case "eliminar":
                                eliminarUsuario(request, response);
                                break;

                        case "perfil":
                                mostrarPerfil(request, response);
                                break;

                        default:
                                listarUsuarios(request, response);
                                break;
                }
        }

        @Override
        protected void doPost(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                request.setCharacterEncoding("UTF-8");

                String accion = request.getParameter("accion");

                if (accion == null) {

                        response.sendError(
                                        HttpServletResponse.SC_BAD_REQUEST,
                                        "No se recibió ninguna acción.");

                        return;
                }

                switch (accion) {

                        case "crear":
                                crearUsuario(request, response);
                                break;

                        case "actualizar":
                                actualizarUsuario(request, response);
                                break;

                        case "desactivarAntiguos":
                                desactivarUsuariosAntiguos(request, response);
                                break;

                        case "eliminarInactivos":
                                eliminarUsuariosInactivos(request, response);
                                break;

                        case "inscribir":
                                inscribirEnCurso(request, response);
                                break;

                        default:

                                response.sendError(
                                                HttpServletResponse.SC_BAD_REQUEST,
                                                "Acción no válida: " + accion);

                                break;
                }
        }

        private void listarUsuarios(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                List<Usuario> usuarios = usuarioDAO.listarTodos();

                request.setAttribute("usuarios", usuarios);

                request.getRequestDispatcher(
                                "/WEB-INF/usuarios/lista.jsp")
                                .forward(request, response);
        }

        private void mostrarFormulario(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                request.getRequestDispatcher(
                                "/WEB-INF/usuarios/formulario.jsp")
                                .forward(request, response);
        }

        private void mostrarEditar(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                Long id = Long.parseLong(
                                request.getParameter("id"));

                Usuario usuario = usuarioDAO.buscarPorId(id);

                request.setAttribute("usuario", usuario);

                request.getRequestDispatcher(
                                "/WEB-INF/usuarios/formulario.jsp")
                                .forward(request, response);
        }

        private void crearUsuario(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws IOException {

                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String correo = request.getParameter("correo");
                String password = request.getParameter("password");

                if (nombre == null || nombre.isBlank()
                                || apellido == null || apellido.isBlank()
                                || correo == null || correo.isBlank()
                                || password == null || password.isBlank()) {

                        response.sendError(
                                        HttpServletResponse.SC_BAD_REQUEST,
                                        "Todos los campos son obligatorios.");

                        return;
                }

                Usuario usuario = new Usuario(
                                nombre,
                                apellido,
                                correo,
                                password);

                usuarioDAO.crear(usuario);

                response.sendRedirect(
                                request.getContextPath() + "/usuarios");
        }

        private void actualizarUsuario(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws IOException {

                Long id = Long.parseLong(
                                request.getParameter("id"));

                Usuario usuario = usuarioDAO.buscarPorId(id);

                if (usuario != null) {

                        usuario.setNombre(
                                        request.getParameter("nombre"));

                        usuario.setApellido(
                                        request.getParameter("apellido"));

                        usuario.setCorreo(
                                        request.getParameter("correo"));

                        usuarioDAO.actualizar(usuario);
                }

                response.sendRedirect(
                                request.getContextPath() + "/usuarios");
        }

        private void eliminarUsuario(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws IOException {

                Long id = Long.parseLong(
                                request.getParameter("id"));

                if (usuarioDAO.tieneCursosInscritos(id)) {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/usuarios?mensaje=noSePuedeEliminar");

                        return;
                }

                usuarioDAO.eliminar(id);

                response.sendRedirect(
                                request.getContextPath()
                                                + "/usuarios?mensaje=usuarioEliminado");
        }

        private void desactivarUsuariosAntiguos(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws IOException {

                LocalDate fecha = LocalDate.parse(
                                request.getParameter("fecha"));

                int afectados = usuarioDAO.desactivarUsuariosAntiguos(fecha);

                response.sendRedirect(
                                request.getContextPath()
                                                + "/usuarios?mensaje=desactivados&cantidad="
                                                + afectados);
        }

        private void eliminarUsuariosInactivos(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws IOException {

                LocalDate fecha = LocalDate.parse(
                                request.getParameter("fecha"));

                int afectados = usuarioDAO.eliminarUsuariosInactivos(fecha);

                response.sendRedirect(
                                request.getContextPath()
                                                + "/usuarios?mensaje=eliminados&cantidad="
                                                + afectados);
        }

        private void mostrarPerfil(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws ServletException, IOException {

                Long id = Long.parseLong(
                                request.getParameter("id"));

                Usuario usuario = usuarioDAO.buscarPorIdConCursos(id);

                List<Curso> cursos = cursoDAO.listarTodos();

                request.setAttribute(
                                "usuario", usuario);

                request.setAttribute(
                                "cursos", cursos);

                request.getRequestDispatcher(
                                "/WEB-INF/usuarios/perfil.jsp")
                                .forward(request, response);
        }

        private void inscribirEnCurso(
                        HttpServletRequest request,
                        HttpServletResponse response)
                        throws IOException {

                Long usuarioId = Long.parseLong(
                                request.getParameter("usuarioId"));

                Long cursoId = Long.parseLong(
                                request.getParameter("cursoId"));

                boolean nuevaInscripcion = usuarioDAO.inscribirEnCurso(
                                usuarioId,
                                cursoId);

                if (nuevaInscripcion) {

                        cursoDAO.incrementarPopularidad(cursoId);

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/usuarios?accion=perfil&id="
                                                        + usuarioId
                                                        + "&mensaje=inscrito");

                } else {

                        response.sendRedirect(
                                        request.getContextPath()
                                                        + "/usuarios?accion=perfil&id="
                                                        + usuarioId
                                                        + "&mensaje=yaInscrito");
                }
        }
}