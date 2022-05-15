<#macro pager url page>
    <#if page.getTotalPages() gt 3>
        <#assign
        totalPages = page.getTotalPages()
        pageNumber = page.getNumber() + 1

        head = (pageNumber > 3)?then([1, -1], [1, 2])
        tail = (pageNumber < totalPages - 2)?then([-1, totalPages], [totalPages - 1, totalPages])
        bodyBefore = (pageNumber > 4 && pageNumber < totalPages - 1)?then([pageNumber - 2, pageNumber - 1], [])
        bodyAfter = (pageNumber > 1 && pageNumber < totalPages - 2)?then([pageNumber + 1], [])

        body = head + bodyBefore + (pageNumber > 2 && pageNumber < totalPages - 1)?then([pageNumber], []) + bodyAfter + tail
        >
    <#else>
        <#assign body = 1..page.getTotalPages()>
    </#if>
    <div class="mt-2">
        <ul class="pagination">
            <#if page.getTotalPages() != 0>
                <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">Страницы</a></li>
                <#list body as p>
                    <#if p - 1 == page.getNumber()>
                        <li class="page-item active"><a class="page-link" href="#" tabindex="-1">${p}</a></li>
                    <#elseif p == -1>
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">...</a>
                        </li>
                    <#else>
                        <li class="page-item"><a class="page-link" href="${url}?page=${p - 1}" tabindex="-1">${p}</a>
                        </li>
                    </#if>
                </#list>
            </#if>
        </ul>
    </div>
</#macro>