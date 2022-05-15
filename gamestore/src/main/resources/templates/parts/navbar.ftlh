<#include "security.ftlh">
<#import  "login.ftlh" as l>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">Games4All</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/">Игры</a>
            </li>
            <#if isAdmin = true>
                <li class="nav-item active">
                    <a class="nav-link" href="/main">Добавить игры</a>
                </li>
            </#if>
            <#if isAdmin = true>
                <li class="nav-item active">
                    <a class="nav-link" href="/user">Список пользователей</a>
                </li>
            </#if>
            <#if isAdmin = true || isManager = true>
                <li class="nav-item active">
                    <a class="nav-link" href="/orderList">Список заказов</a>
                </li>
            </#if>
            <li class="nav-item active">
                <a class="nav-link" href="/cart">Корзина</a>
            </li>
        </ul>
        <form method="get" action="/search" class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" name="filter" placeholder="Поиск" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Поиск</button>
        </form>
        <#if user??>
            <div class="navbar-text ml-3"><a class="nav-link" href="/user/profile">${name}</a></div>
        </#if>
        <#if name=="Гость">
            <form action="/login">
                <div><input class="btn btn-primary ml-3" type="submit" value="Войти"/></div>
            </form>
        <#else>
            <@l.logout/>
        </#if>
    </div>
</nav>