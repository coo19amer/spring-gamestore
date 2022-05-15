<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<@c.page>
   <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
       <div class="alert alert-danger" role="alert">
           ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
       </div>
   </#if>
    <#if message??>
        <div class="alert alert-${messageType}" role="alert">
            ${message}
        </div>
    </#if>
    <h2>Вход</h2>
    <@l.login "/login" />
    <a href="/forgot_password">Забыли пароль?</a>
    <a href="/registration">Зарегистрироваться</a>
    </@c.page>