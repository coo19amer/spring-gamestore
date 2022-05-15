<#include "security.ftlh">
<table class="table">
    <thead class="thead-light">
    <tr>
        <th>Дата покупки</th>
        <th>Название Игры</th>
        <th>Жанр</th>
        <th>Цена</th>
        <th>Количество</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <#list orders as order>
        <#assign count = 0>
        <#list order.getOrderLines() as o>
            <tr>
                <#if count lt 1>
                    <th scope="row" rowspan="${order.getOrderLines()?size}" class="align-middle">${order.getDate()}
                    </th>
                </#if>
                <#if o.getGame()??>
                    <td>${o.getGame().getName()}</td>
                    <td>${o.getGame().getGenre()}</td>
                    <td>${o.getGame().getPrice()}</td>
                <#else>
                    <td>${o.getName()}</td>
                    <td class="text-center">${o.getPrice()}</td>
                </#if>
                <td class="text-center">${o.getQuantity()}</td>
            </tr>
            <#assign count = count + 1>
        </#list>
        <th>Сумма покупки: ${order.getTotalPrice()!""}</th>
    </#list>
    </tbody>
</table>