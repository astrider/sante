package com.astrider.sfc.src.command.user.recipe;

import java.io.IOException;

import javax.servlet.ServletException;

import com.astrider.sfc.app.annotation.Title;
import com.astrider.sfc.app.lib.Command;
import com.astrider.sfc.src.model.RecipeModel;

@Title("レシピ検索")
public class SearchCommand extends Command {

	@Override
	public void doGet() throws ServletException, IOException {
		RecipeModel model = new RecipeModel();
		model.searchRecipes(request);
		flashMessage.addMessage(model.getFlashMessage());

		render();
	}

	@Override
	public void doPost() throws ServletException, IOException {
		RecipeModel model = new RecipeModel();
		model.searchRecipes(request);
		flashMessage.addMessage(model.getFlashMessage());

		render();
	}
}
