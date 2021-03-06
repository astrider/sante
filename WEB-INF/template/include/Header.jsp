<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="keywords" content="健康,食育,レシピ,健康レシピ,レシピ探し,おすすめレシピ,栄養,三色食品群,健康管理,食事管理,栄養管理">
    <meta name="description" content="santé(サンテ)は貴方の調理履歴を管理してくれるWebレシピ検索サービスです。食事履歴を参考に、あなたの体に合わせたおすすめレシピを毎日簡単に知ることができます。">
    <title><% v.getTitle(); %></title>
    <link href="<%v.getPath("/asset/css/normalize.css");%>" rel="stylesheet" type="text/css">
    <link href="<%v.getCssPath();%>" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="<% v.getPath("/asset/js/jquery-1.9.1.min.js"); %>"></script>
    <c:if test="${ isLoggedIn }" >
    <script type="text/javascript" src="<% v.getPath("/asset/js/santePieGraph.js"); %>"></script>
    <script type="text/javascript" src="<% v.getPath("/asset/js/santeUserStats.js"); %>"></script>
    <script type="text/javascript" src="<% v.getPath("/asset/js/santeUserNutrients.js"); %>"></script>
    <script type="text/javascript" src="<% v.getPath("/asset/js/santeFillMaterials.js"); %>"></script>
    <script type="text/javascript">
      $(document).ready(function() {
        // prepare for pieGraph
        var params = ["乳", "卵", "肉", "豆", "菜", "果", "藻", "米", "芋", "油", "糖"];
        santePieGraph.interface.init(".pie-graph", params);
        santePieGraph.interface.setSize($('.pie-graph').width(), $('.pie-graph').height());
        santePieGraph.interface.setAuxlineNum(10);
        santePieGraph.interface.draw();
        // exec usernutrients
        santeUserNutrients.interface.update();
      });
    </script>
    </c:if>
  </head>

  <body>
    <% v.showBackgroundImage(); %>
    <header>
      <div id="header">
        <c:if test="${ isLoggedIn }" >
        <section id="header-upper">
          <div class="header-inner">
            <div class ="header-userinfo">
              <% pageContext.setAttribute("SESSION_USER", SESSION_USER); %>
              <c:set var="loginUser" value="${sessionScope[SESSION_USER]}" />
              <span>ようこそ、<c:out value="${loginUser.userName}" />さん</span>
            </div>
            <div class ="header-logout">
              <a href="<% v.getPath("/auth/Logout"); %>">ログアウト</a>
              <a href="<% v.getPath("/user/profile/ChangePassword"); %>">設定</a>
            </div>
          </div>
        </section>
        </c:if>
        <section id="header-lower">
          <div class="header-inner">
            <div class="header-logo">
              <a href="<%v.getPath("/Index");%>">santé</a><p>-自炊を楽しむすべての人に、手軽に健康的な料理生活を-</p>
            </div>
            <nav class="header-control">
            <c:if test="${ isLoggedIn }" >
              <ul>
                <li><a href="<% v.getPath("/knowledge/Index"); %>"><i></i>栄養知識</a></li>
              </ul>
            </c:if>
            </nav>
          </div>
        </section>
      </div>
      <c:if test="${ isLoggedIn }" >
      <div id="header-upper-dummy"></div>
      </c:if>
      <div id="header-lower-dummy"></div>
    </header>

    <div id="wrapper">
      <% v.getFlashMessages(); %>