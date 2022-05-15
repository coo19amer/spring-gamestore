<#import "parts/common.ftlh" as c>
<#import "parts/pager.ftlh" as p>
<@c.page>
    <div class="form-row">
        <div class="form-group">
            <form method="get" action="/main" class="form-inline">
                <input class="form-control" type="text" name="filter" value="${filter!""}"
                       placeholder="Жанр"/>
                <div class="input-group-append">
                    <button class="btn btn-outline-success ml-2" type="submit">Найти</button>
                </div>
            </form>
        </div>
    </div>
    <a class="btn btn-primary mb-2" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false"
       aria-controls="collapseExample">
        Добавить новую игру
    </a>
    <div class="collapse <#if game??>show</#if>" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input class="form-control mt-2 col-md-6 ${(nameError??)?string('is-invalid', '')}" type="text"
                           value="<#if game??>${game.name}</#if>" name="name" placeholder="Введите название игры"/>
                    <#if nameError??>
                        <div class="invalid-feedback mb-2">
                            ${nameError}
                        </div>
                    </#if>
                </div>
                <div class="form-group">
                    <input class="form-control col-md-6 ${(authorError??)?string('is-invalid', '')}" type="text"
                           value="<#if game??>${game.genre}</#if>" name="genre" placeholder="Жанр"/>
                    <#if genreError??>
                        <div class="invalid-feedback mb-2">
                            ${genreError}
                        </div>
                    </#if>
                </div>
                <div class="form-group">
                    <input class="form-control col-md-6 ${(priceError??)?string('is-invalid', '')}" type="number"
                           value="<#if game??>1</#if>" name="price" placeholder="Цена"/>
                    <#if priceError??>
                        <div class="invalid-feedback mb-2">
                            ${priceError}
                        </div>
                    </#if>
                </div>
                <div class="form-group">
                    <input class="form-control col-md-6 ${(quantityError??)?string('is-invalid', '')}" type="text"
                           value="<#if game??>0</#if>" name="quantity" placeholder="Количество"/>
                    <#if quantityError??>
                        <div class="invalid-feedback mb-2">
                            ${quantityError}
                        </div>
                    </#if>
                </div>
                <div class="form-group">
                    <div class="custom-file col-md-6">
                        <input id="custom-file" type="file" name="file">
                        <label class="custom-file-label" for="custom-file">Выберите картинку</label>
                    </div>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <div class="form-group">
                    <button class="btn btn-primary ml-3" type="submit">Добавить</button>
                </div>
            </form>
        </div>
    </div>
    <@p.pager url games/>
    <table class="table table-borderless table-hover">
        <thead class="thead-light">
        <tr>
            <th>Название игры</th>
            <th>Жанр</th>
            <th>Цена</th>
            <th>Количество</th>
            <th></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <#list games.content as game>
            <tr>
                <td>${game.getName()}</td>
                <td>${game.getGenre()}</td>
                <form method="post" action="/">
                    <td>
                        <input class="form-control col-md-20" type="number" name="price" min="0"
                               value="${game.getPriceToString()}"/>
                    </td>
                    <td>
                        <input class="form-control col-md-15" type="number" name="quantity" min="0" max="40000"
                               value="${game.getQuantity()}"/>
                    </td>
                    <th>
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <input type="hidden" name="gameId" value=${game.getID()}>
                        <button type="submit" class="btn btn-link">Редактировать</button>
                    </th>
                </form>
                <th>
                    <form method="post" action="/remove">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <input type="hidden" name="gameId" value="${game.getId()}">
                        <button type="submit" class="btn btn-link">Удалить</button>
                    </form>
                </th>
            </tr>
        </#list>
        </tbody>
    </table>
    <@p.pager url games/>
</@c.page>