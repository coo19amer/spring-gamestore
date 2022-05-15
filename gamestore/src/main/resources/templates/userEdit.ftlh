<#import "parts/common.ftlh" as c>
<@c.page>
    User Editor
    <form action="/user" method="post">
        <input type="text" class="form-control" name="username" value="${user.username}">
        <div class="form-check">
            Аккаунт:
            <div>
                <label>
                    <input type="checkbox" class="form-check-input"
                           name="active" ${user.active?string("checked", "")}>${user.active?string("Активирован", "Неактивирован")}
                </label>
            </div>
        </div>
        <div class="form-check">
            Права:
            <#list roles as role>
                <div>
                    <label><input type="checkbox" class="form-check-input"
                                  name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
                </div>
            </#list>
        </div>

        <input type="hidden" name="userId" value="${user.id}">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit"> Сохранить</button>
    </form>
</@c.page>