<#import "parts/common.ftlh" as c>
<#import "parts/pager.ftlh" as p>
<@c.page>
    <h2>Игры:</h2>
    <@p.pager url games/>
    <div class="row card-deck">
        <#list games.content as game>
            <#if game.getQuantity() != 0>
                <div class="col-sm-3" style="height: 710px">
                    <div class="card mb-4 ">
                        <#if game.filename??>
                            <img height="350px" class="card-img-top" src="../img/${game.filename}"
                                 alt="Card image cap">
                        </#if>
                        <form method="post" action="/cart/addToCart" enctype="multipart/form-data">
                            <div class="card-body" style="height: 330px">
                                <h5 class="card-title">${game.name}</h5>
                                <p class="card-text">Жанр: ${game.genre}</p>
                                Цена: ${game.getPriceToString()}
                                <p>Количество:
                                    <input class="form-control col-md-8" type="number" name="quantity" min="1"
                                           max="${game.quantity}" value="1"/>
                                </p>
                                <p class="text-center">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                    <input type="hidden" name="id" value="${game.getID()}">
                                    <button type="submit" class="btn btn-primary mt-3">Добавить в корзину</button>
                                </p>
                            </div>
                        </form>
                    </div>
                </div>
            </#if>
        <#else>
            No games
        </#list>
    </div>
    <@p.pager url games/>
</@c.page>