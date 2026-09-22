package cl.educaparatodos.dao;

import cl.educaparatodos.model.Curso;
import cl.educaparatodos.model.Usuario;
import cl.educaparatodos.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.time.LocalDate;
import java.util.List;

public class UsuarioDAO {

    public void crear(Usuario usuario) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(usuario);
            tx.commit();

        } catch (Exception e) {

            if (tx.isActive()) {
                tx.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    public Usuario buscarPorId(Long id) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.find(Usuario.class, id);

        } finally {
            em.close();
        }
    }

    public List<Usuario> listarTodos() {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT u FROM Usuario u ORDER BY u.nombre",
                    Usuario.class).getResultList();

        } finally {
            em.close();
        }
    }

    public void actualizar(Usuario usuario) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();
            em.merge(usuario);
            tx.commit();

        } catch (Exception e) {

            if (tx.isActive()) {
                tx.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    public void eliminar(Long id) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Usuario usuario = em.find(Usuario.class, id);

            if (usuario != null) {
                em.remove(usuario);
            }

            tx.commit();

        } catch (Exception e) {

            if (tx.isActive()) {
                tx.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    public int desactivarUsuariosAntiguos(LocalDate fecha) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            int afectados = em.createQuery(
                    "UPDATE Usuario u " +
                            "SET u.activo = false " +
                            "WHERE u.fechaRegistro < :fecha")
                    .setParameter("fecha", fecha)
                    .executeUpdate();

            tx.commit();

            return afectados;

        } catch (Exception e) {

            if (tx.isActive()) {
                tx.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    public int eliminarUsuariosInactivos(LocalDate fecha) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            int afectados = em.createQuery(
                    "DELETE FROM Usuario u " +
                            "WHERE u.activo = false " +
                            "AND u.fechaRegistro < :fecha")
                    .setParameter("fecha", fecha)
                    .executeUpdate();

            tx.commit();

            return afectados;

        } catch (Exception e) {

            if (tx.isActive()) {
                tx.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    public Usuario buscarPorIdConCursos(Long id) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT DISTINCT u FROM Usuario u " +
                            "LEFT JOIN FETCH u.cursosInscritos " +
                            "WHERE u.id = :id",
                    Usuario.class)
                    .setParameter("id", id)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }

    public boolean inscribirEnCurso(Long usuarioId, Long cursoId) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Usuario usuario = em.find(Usuario.class, usuarioId);
            Curso curso = em.find(Curso.class, cursoId);

            if (usuario == null || curso == null) {
                throw new IllegalArgumentException(
                        "El usuario o el curso no existe");
            }

            // Evita inscribir dos veces al mismo usuario
            if (usuario.getCursosInscritos().contains(curso)) {

                tx.commit();
                return false;
            }

            usuario.getCursosInscritos().add(curso);

            tx.commit();

            return true;

        } catch (Exception e) {

            if (tx.isActive()) {
                tx.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    public boolean tieneCursosInscritos(Long usuarioId) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            Long cantidad = em.createQuery(
                    "SELECT COUNT(c) FROM Usuario u JOIN u.cursosInscritos c WHERE u.id = :usuarioId",
                    Long.class)
                    .setParameter("usuarioId", usuarioId)
                    .getSingleResult();

            return cantidad > 0;

        } finally {
            em.close();
        }
    }
}