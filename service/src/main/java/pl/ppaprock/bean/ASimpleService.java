package pl.ppaprock.bean;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
public class ASimpleService {

    @PersistenceContext(name = "dbPU")
    private EntityManager em;

    public AEntity get(){
        return em.find(AEntity.class, 1);
    }

    public void save(AEntity entity){
        em.merge(entity);
    }

}
