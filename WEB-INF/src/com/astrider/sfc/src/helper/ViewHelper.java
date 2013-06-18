package com.astrider.sfc.src.helper;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import com.astrider.sfc.app.lib.helper.FlashMessage;
import com.astrider.sfc.app.lib.helper.StringUtils;
import com.astrider.sfc.src.model.vo.db.UserVo;

/**
 * ViewHelper.
 * 
 * @author astrider
 *         <p>
 *         jsp内にて利用するヘルパークラス
 *         </p>
 * 
 */
public class ViewHelper {
	private PageContext context;
	private HttpSession session;
	private HttpServletRequest request;

	public ViewHelper(PageContext context, HttpSession session, HttpServletRequest request) {
		this.context = context;
		this.session = session;
		this.request = request;
	}

	/**
	 * ログイン状態取得.
	 * 
	 * @return ログイン成否
	 */
	public boolean isLoggedIn() {
		UserVo user = (UserVo) session.getAttribute("loginUser");
		return user != null;
	}

	/**
	 * 相対パスを出力(contextPathを先頭に付加).
	 * 
	 * @param 対象URL
	 */
	public void getPath(String target) {
		StringBuilder sb = new StringBuilder();
		sb.append(request.getContextPath());
		sb.append(target);
		print(sb.toString());
	}

	/**
	 * urlに対応したcssファイルのURLを出力.
	 * <p>
	 * frontControllerでinvalidがコールされていた場合はUnknown.cssをロード
	 * </p>
	 */
	public void getCssPath() {
		StringBuilder sb = new StringBuilder();
		sb.append("/asset/css");
		String replaced = request.getServletPath().replace("/WEB-INF/template/view", "").replace(".jsp", "");
		String[] splitted = replaced.split("/");
		for (int i = 0; i < splitted.length; i++) {
			String item = splitted[i].toLowerCase();
			sb.append(item);
			if (i != splitted.length - 1) {
				sb.append("/");
			}
		}
		sb.append(".css");

		getPath(sb.toString());
	}

	/**
	 * ページタイトルを出力.
	 */
	public void getTitle() {
		StringBuilder sb = new StringBuilder();
		sb.append(context.getServletContext().getServletContextName());
		String pageTitle = (String) request.getAttribute("pageTitle");
		if (StringUtils.isNotEmpty(pageTitle)) {
			sb.append(" | ");
			sb.append(pageTitle);
		}

		String title = sb.toString();
		print(title);
	}

	/**
	 * /indexの場合のみ背景画像を表示.
	 */
	public void showBackgroundImage() {
		String replaced = request.getServletPath().replace("/WEB-INF/template/view/", "").replace(".jsp", "");
		if (replaced.equals("Index")) {
			print("<img alt=\"背景画像\" src=");
			getPath("/asset/img/topimage.jpg");
			print(" class=\"background-image\">");
		}
	}

	/**
	 * FlashMessageとして表示.
	 */
	public void getFlashMessages() {
		FlashMessage flashMessage = (FlashMessage) session.getAttribute("flashMessage");
		if (flashMessage != null && flashMessage.hasMessage()) {
			print("<div id='flash-messages' class='" + flashMessage.getMessageType().toString().toLowerCase() + "'>");
			print("<ul>");
			for (String message : flashMessage.getMessages()) {
				print("<li>" + message + "</li>");
			}
			print("</ul>");
			print("<a href='#' onClick='$(\"#flash-messages\").hide()'>x</a>");
			print("</div>");
			session.removeAttribute("flashMessage");
		}
	}

	/**
	 * printを簡易化.
	 * 
	 * @param 文字列
	 */
	private void print(String arg) {
		try {
			context.getOut().print(arg);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
