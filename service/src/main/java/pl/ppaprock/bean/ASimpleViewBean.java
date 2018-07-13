package pl.ppaprock.bean;

import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.view.ViewScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.event.ActionEvent;
import javax.inject.Inject;
import java.io.Serializable;

@ViewScoped
@ManagedBean(name = "mrSimple")
public class ASimpleViewBean implements Serializable {

    @Inject
    ASimpleService service;

    private AEntity entity;

    @PostConstruct
    public void init(){
        entity = service.get();
        data = entity.getData();
    }

    private String data;

    public void saveAction(ActionEvent ae) {
        entity.setData(data);
        service.save(entity);
        FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_INFO, "Saved", data);
        FacesContext.getCurrentInstance().addMessage(null, message);
    }

    public String getData(){ return data; }
    public void setData(String data){
        this.data = data;
    }

}
