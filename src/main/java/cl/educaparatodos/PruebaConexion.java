package cl.educaparatodos;

import cl.educaparatodos.util.JPAUtil;
import jakarta.persistence.EntityManager;

public class PruebaConexion {

    public static void main(String[] args) {

        EntityManager em = null;

        try {
            em = JPAUtil.getEntityManager();

            System.out.println("CONEXION EXITOSA CON MYSQL");

        } catch (Exception e) {

            System.out.println("ERROR DE CONEXION");
            e.printStackTrace();

        } finally {

            if (em != null && em.isOpen()) {
                em.close();
            }

            JPAUtil.close();
        }
    }
}