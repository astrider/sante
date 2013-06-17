package com.astrider.sfc.src.command.register;

import java.io.IOException;

import javax.servlet.ServletException;

import com.astrider.sfc.app.lib.Command;
import com.astrider.sfc.app.lib.helper.FlashMessage.Type;
import com.astrider.sfc.src.model.RegisterModel;

public class ConfirmEmailCommand extends Command {
    @Override
    public void doGet() throws ServletException, IOException {
        RegisterModel model = new RegisterModel();
        boolean succeed = model.confirmMail(request);
        if (succeed) {
            redirect("/register/Success");
        } else {
            flashMessage.addMessage(model.getFlashMessage());
            flashMessage.setMessageType(Type.WARNING);
            redirect("/register/Fail");
        }
    }
}
