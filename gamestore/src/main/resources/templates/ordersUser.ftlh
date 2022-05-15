<#import "parts/common.ftlh" as c>
<@c.page>
    <h2>Список покупок пользователя ${user.getUsername()}</h2>
    <a href="/orderList">К списку покупок</a>
    <#include "parts/order.ftlh">
</@c.page>