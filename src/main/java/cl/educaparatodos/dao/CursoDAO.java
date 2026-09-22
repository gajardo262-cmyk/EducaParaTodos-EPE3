package cl.educaparatodos.dao;

import cl.educaparatodos.model.Curso;
import cl.educaparatodos.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class CursoDAO {

    public void crear(Curso curso) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(curso);
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

    public Curso buscarPorId(Long id) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.find(Curso.class, id);
        } finally {
            em.close();
        }
    }

    public List<Curso> listarTodos() {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                    "SELECT c FROM Curso c ORDER BY c.titulo",
                    Curso.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void actualizar(Curso curso) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.merge(curso);
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

            Curso curso = em.find(Curso.class, id);

            if (curso != null) {
                em.remove(curso);
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

    public List<Curso> buscarPorTema(String tema) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                    "SELECT c FROM Curso c " +
                            "WHERE LOWER(c.tema) = LOWER(:tema) " +
                            "AND c.activo = true",
                    Curso.class)
                    .setParameter("tema", tema)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    public List<Curso> buscarPorNivel(String nivel) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                    "SELECT c FROM Curso c " +
                            "WHERE LOWER(c.nivel) = LOWER(:nivel) " +
                            "AND c.activo = true",
                    Curso.class)
                    .setParameter("nivel", nivel)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    public List<Curso> listarPorPopularidad() {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                    "SELECT c FROM Curso c " +
                            "WHERE c.activo = true " +
                            "ORDER BY c.popularidad DESC",
                    Curso.class).getResultList();

        } finally {
            em.close();
        }
    }

    public List<Curso> buscarPorTemaYNivel(String tema, String nivel) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                    "SELECT c FROM Curso c " +
                            "WHERE LOWER(c.tema) = LOWER(:tema) " +
                            "AND LOWER(c.nivel) = LOWER(:nivel) " +
                            "AND c.activo = true " +
                            "ORDER BY c.popularidad DESC",
                    Curso.class)
                    .setParameter("tema", tema)
                    .setParameter("nivel", nivel)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    public int desactivarCursosPocoPopulares(int minimo) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            int afectados = em.createQuery(
                    "UPDATE Curso c " +
                            "SET c.activo = false " +
                            "WHERE c.popularidad < :minimo")
                    .setParameter("minimo", minimo)
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

    public int eliminarCursosInactivos() {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            int afectados = em.createQuery(
                    "DELETE FROM Curso c " +
                            "WHERE c.activo = false " +
                            "AND NOT EXISTS (" +
                            "   SELECT l.id FROM Leccion l " +
                            "   WHERE l.curso = c" +
                            ")")
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

    public Curso buscarPorIdConLecciones(Long id) {

        EntityManager em = JPAUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT DISTINCT c FROM Curso c " +
                            "LEFT JOIN FETCH c.lecciones " +
                            "WHERE c.id = :id",
                    Curso.class)
                    .setParameter("id", id)
                    .getSingleResult();

        } finally {

            em.close();
        }
    }

    public int incrementarPopularidad(Long cursoId) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            int afectados = em.createQuery(
                    "UPDATE Curso c " +
                            "SET c.popularidad = c.popularidad + 1 " +
                            "WHERE c.id = :id")
                    .setParameter("id", cursoId)
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

    public boolean tieneUsuariosInscritos(Long cursoId) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            Long cantidad = em.createQuery(
                    "SELECT COUNT(u) FROM Usuario u JOIN u.cursosInscritos c WHERE c.id = :cursoId",
                    Long.class)
                    .setParameter("cursoId", cursoId)
                    .getSingleResult();

            return cantidad > 0;

        } finally {
            em.close();
        }
    }
}