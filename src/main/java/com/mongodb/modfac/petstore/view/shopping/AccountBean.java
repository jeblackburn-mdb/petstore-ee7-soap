package com.mongodb.modfac.petstore.view.shopping;

import com.mongodb.modfac.petstore.model.Customer;
import com.mongodb.modfac.petstore.service.CustomerService;
import com.mongodb.modfac.petstore.util.Loggable;
import com.mongodb.modfac.petstore.view.AbstractBean;
import com.mongodb.modfac.petstore.view.CatchException;
import com.mongodb.modfac.petstore.view.LoggedIn;

import javax.enterprise.context.Conversation;
import javax.enterprise.context.SessionScoped;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.inject.Named;
import javax.security.auth.login.LoginContext;
import javax.security.auth.login.LoginException;
import java.io.Serializable;

/**
 * @author Antonio Goncalves
 *         http://www.antoniogoncalves.org
 *         --
 */

@Named
@SessionScoped
@Loggable
@CatchException
public class AccountBean extends AbstractBean implements Serializable {

    // ======================================
    // =             Attributes             =
    // ======================================

    @Inject
    private CustomerService customerService;

    @Inject
    private CredentialsBean credentials;

    @Inject
    private Conversation conversation;

    @Produces
    @LoggedIn
    private Customer loggedinCustomer;

    @Inject
    @SessionScoped
    private transient LoginContext loginContext;

    // ======================================
    // =              Public Methods        =
    // ======================================

    public String doLogin() throws LoginException {
        if (credentials.getLogin() == null || "".equals(credentials.getLogin())) {
            addWarningMessage("id_filled");
            return null;
        }
        if (credentials.getPassword() == null || "".equals(credentials.getPassword())) {
            addWarningMessage("pwd_filled");
            return null;
        }

// TODO       loginContext.login();
        loggedinCustomer = customerService.findCustomer(credentials.getLogin());
        return "main.faces";
    }

    public String doCreateNewAccount() {

        // Login has to be unique
        if (customerService.doesLoginAlreadyExist(credentials.getLogin())) {
            addWarningMessage("login_exists");
            return null;
        }

        // Id and password must be filled
        if ("".equals(credentials.getLogin()) || "".equals(credentials.getPassword()) || "".equals(credentials.getPassword2())) {
            addWarningMessage("id_pwd_filled");
            return null;
        } else if (!credentials.getPassword().equals(credentials.getPassword2())) {
            addWarningMessage("both_pwd_same");
            return null;
        }

        // Login and password are ok
        loggedinCustomer = new Customer();
        loggedinCustomer.setLogin(credentials.getLogin());
        loggedinCustomer.setPassword(credentials.getPassword());

        return "createaccount.faces";
    }

    public String doCreateCustomer() {
        loggedinCustomer = customerService.createCustomer(loggedinCustomer);
        return "main.faces";
    }


    public String doLogout() {
        loggedinCustomer = null;
        // Stop conversation
        if (!conversation.isTransient()) {
            conversation.end();
        }
        addInformationMessage("been_loggedout");
        return "main.faces";
    }

    public String doUpdateAccount() {
        loggedinCustomer = customerService.updateCustomer(loggedinCustomer);
        addInformationMessage("account_updated");
        return "showaccount.faces";
    }

    public boolean isLoggedIn() {
        return loggedinCustomer != null;
    }

    public Customer getLoggedinCustomer() {
        return loggedinCustomer;
    }

    public void setLoggedinCustomer(Customer loggedinCustomer) {
        this.loggedinCustomer = loggedinCustomer;
    }
}
