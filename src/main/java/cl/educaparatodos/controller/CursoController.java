package cl.educaparatodos.controller;

import cl.educaparatodos.dao.CursoDAO;
import cl.educaparatodos.model.Curso;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/cursos")
public class CursoController extends HttpServlet {

    private CursoDAO cursoDAO;

    @Override
    public void init() {
        cursoDAO = new CursoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
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
                eliminarCurso(request, response);
                break;

            case "buscar":
                buscarCursos(request, response);
                break;
            case "detalle":
                mostrarDetalle(request, response);
                break;

            default:
                listarCursos(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("actualizar".equals(accion)) {

            actualizarCurso(request, response);

        } else if ("desactivarMasivo".equals(accion)) {

            desactivarCursosMasivo(request, response);

        } else if ("eliminarInactivos".equals(accion)) {

            eliminarCursosInactivos(request, response);

        } else {

            crearCurso(request, response);
        }
    }

    private void listarCursos(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Curso> cursos = cursoDAO.listarTodos();

        request.setAttribute("cursos", cursos);

        request.getRequestDispatcher("/WEB-INF/cursos/lista.jsp")
                .forward(request, response);
    }

    private void mostrarFormulario(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/cursos/formulario.jsp")
                .forward(request, response);
    }

    private void mostrarEditar(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Long id = Long.parseLong(request.getParameter("id"));

        Curso curso = cursoDAO.buscarPorId(id);

        request.setAttribute("curso", curso);

        request.getRequestDispatcher("/WEB-INF/cursos/formulario.jsp")
                .forward(request, response);
    }

    private void crearCurso(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String tema = request.getParameter("tema");
        String nivel = request.getParameter("nivel");

        Curso curso = new Curso(
                titulo,
                descripcion,
                tema,
                nivel);

        cursoDAO.crear(curso);

        response.sendRedirect(
                request.getContextPath() + "/cursos");
    }

    private void actualizarCurso(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        Long id = Long.parseLong(request.getParameter("id"));

        Curso curso = cursoDAO.buscarPorId(id);

        if (curso != null) {

            curso.setTitulo(request.getParameter("titulo"));
            curso.setDescripcion(request.getParameter("descripcion"));
            curso.setTema(request.getParameter("tema"));
            curso.setNivel(request.getParameter("nivel"));

            cursoDAO.actualizar(curso);
        }

        response.sendRedirect(
                request.getContextPath() + "/cursos");
    }

    private void eliminarCurso(
            HttpServletRequest request,
            HttpServletResponse response) throws IOException {

        Long id = Long.parseLong(request.getParameter("id"));

        if (cursoDAO.tieneUsuariosInscritos(id)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/cursos?mensaje=noSePuedeEliminar");

            return;
        }

        cursoDAO.eliminar(id);

        response.sendRedirect(
                request.getContextPath()
                        + "/cursos?mensaje=cursoEliminado");
    }

    private void buscarCursos(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String tema = request.getParameter("tema");
        String nivel = request.getParameter("nivel");

        List<Curso> cursos;

        if (tema != null && !tema.isBlank()
                && nivel != null && !nivel.isBlank()) {

            cursos = cursoDAO.buscarPorTemaYNivel(tema, nivel);

        } else if (tema != null && !tema.isBlank()) {

            cursos = cursoDAO.buscarPorTema(tema);

        } else if (nivel != null && !nivel.isBlank()) {

            cursos = cursoDAO.buscarPorNivel(nivel);

        } else {

            cursos = cursoDAO.listarPorPopularidad();
        }

        request.setAttribute("cursos", cursos);

        request.getRequestDispatcher("/WEB-INF/cursos/lista.jsp")
                .forward(request, response);
    }

    private void desactivarCursosMasivo(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        int minimo = Integer.parseInt(
                request.getParameter("minimo"));

        int afectados = cursoDAO.desactivarCursosPocoPopulares(minimo);

        response.sendRedirect(
                request.getContextPath()
                        + "/cursos?mensaje=desactivados&cantidad="
                        + afectados);
    }

    private void eliminarCursosInactivos(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        int afectados = cursoDAO.eliminarCursosInactivos();

        response.sendRedirect(
                request.getContextPath()
                        + "/cursos?mensaje=eliminados&cantidad="
                        + afectados);
    }

    private void mostrarDetalle(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Long id = Long.parseLong(
                request.getParameter("id"));

        Curso curso = cursoDAO.buscarPorIdConLecciones(id);

        request.setAttribute("curso", curso);

        request.getRequestDispatcher(
                "/WEB-INF/cursos/detalle.jsp").forward(request, response);
    }
}