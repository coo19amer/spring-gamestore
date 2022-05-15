<#import "parts/common.ftlh" as c>
<@c.page>
    <h1>Подтверждение покупки</h1>
    <#if message??>
        <div>
            <h2 class="text-${messageType}">${message}</h2>
        </div>
    </#if>
</@c.page>