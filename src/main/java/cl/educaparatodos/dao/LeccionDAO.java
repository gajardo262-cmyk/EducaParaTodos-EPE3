package cl.educaparatodos.dao;

import cl.educaparatodos.model.Curso;
import cl.educaparatodos.model.Leccion;
import cl.educaparatodos.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class LeccionDAO {

    public void crear(Leccion leccion, Long cursoId) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            Curso curso = em.find(Curso.class, cursoId);

            if (curso == null) {
                throw new IllegalArgumentException("El curso no existe");
            }

            leccion.setCurso(curso);

            em.persist(leccion);

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

    public Leccion buscarPorId(Long id) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.find(Leccion.class, id);

        } finally {
            em.close();
        }
    }

    public void actualizar(Leccion leccion) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Leccion existente = em.find(Leccion.class, leccion.getId());

            if (existente != null) {

                existente.setTitulo(leccion.getTitulo());
                existente.setContenido(leccion.getContenido());
                existente.setOrden(leccion.getOrden());
                existente.setDuracion(leccion.getDuracion());
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

    public Long eliminar(Long id) {

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {

            tx.begin();

            Leccion leccion = em.find(Leccion.class, id);

            if (leccion == null) {
                tx.commit();
                return null;
            }

            Long cursoId = leccion.getCurso().getId();

            em.remove(leccion);

            tx.commit();

            return cursoId;

        } catch (Exception e) {

            if (tx.isActive()) {
                tx.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }
}