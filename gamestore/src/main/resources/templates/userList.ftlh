<#import "parts/common.ftlh" as c>

<@c.page>
    <h2>Список пользователей</h2>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Active</th>
            <th>Логин</th>
            <th>Имя</th>
            <th>Фамилия</th>
            <th>Почта</th>
            <th>Роль</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td>${user.getId()}</td>
                <td>
                    <#if user.isActive()>
                        Да
                        <#else>
                        Нет
                    </#if>
                </td>
                <td>${user.username!"не найдено"}</td>
                <td>${user.firstName!"не найдено"}</td>
                <td>${user.lastName!"не найдено"}</td>
                <td>${user.email!"не найдено"}</td>
                <td>
                    <#list user.roles as role>
                        ${role} <#sep>,
                    </#list>
                </td>
                <td>
                    <a href="/user/${user.id}">Редактировать</a>
                    <a href="/user/delete/${user.id}">Удалить</a>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>
</@c.page>