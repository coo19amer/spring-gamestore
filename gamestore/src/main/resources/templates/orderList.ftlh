<#import "parts/common.ftlh" as c>
<@c.page>
    <table class="table">
        <thead>
        <tr>
            <th>Дата заказа</th>
            <th>Номер заказа</th>
            <th>Пользователь</th>
            <th>Сумма заказа</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <#list ordersList as order>
            <tr>
                <th>${order.getDate()}</th>
                <th><a href="/orderList/${order.getID()}">${order.getID()}</a></th>
                <th>ID пользователя - ${order.getUser().getId()}
                    <br>Логин - ${order.getUser().getUsername()}
                    <br>ФИ - ${order.getUser().getLastName()} ${order.getUser().getFirstName()}
                </th>
                <th>${order.getTotalPrice()}</th>
            </tr>
        </#list>
        </tbody>
    </table>
</@c.page>