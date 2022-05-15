<#import "parts/common.ftlh" as c>
<@c.page>
    <h3>${username}</h3>
    ${message!" "}
    <form method="post">
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inputEmail4">Email</label>
                <input type="email" class="form-control" id="inputEmail4" placeholder="Email" name="email"
                       value="${email!""}">
            </div>

            <div class="form-group col-md-6">
                <label for="inputPassword4">Пароль</label>
                <input type="password" class="form-control" id="inputPassword4" placeholder="Password" name="password">
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <div><input class="btn btn-primary" type="submit" value="Сохранить"/></div>
    </form>
    <h2>Список заказов</h2>
    <#include "parts/order.ftlh">
</@c.page>