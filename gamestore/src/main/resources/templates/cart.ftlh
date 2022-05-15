<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>
<@c.page>
    <div class="d-flex justify-content-between">
        <h2>Корзина</h2>
        <a class="btn btn-primary mb-2" href="/cart/clear">Очистить корзину</a>
    </div>
    <#if message??>
        <div>
            <p class="text-warning">${message}</p>
        </div>
    </#if>
    <table class="table">
        <thead>
        <tr>
            <th></th>
            <th>Название игры</th>
            <th>Жанр</th>
            <th>Цена</th>
            <th>Количество</th>
            <th></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <#list cart.getCartLineList() as c>
            <tr>
                <td style="width: 130px">
                    <#if c.game.getFilename()??>
                        <img src="../img/${c.game.getFilename()}" class="img-thumbnail" alt="Image"/>
                    </#if>
                </td>
                <td>${c.game.getName()}</td>
                <td>${c.game.getGenre()}</td>
                <td>
                    ${c.game.getPrice()*c.getQuantity()}
                </td>
                <form method="post" action="/cart/editQuantity">
                    <td>
                        <input type="number" min="1" max="${c.game.getQuantity()}" name="quantity"
                               value="${c.getQuantity()}"></td>
                    <td>
                        <input type="hidden" name="id" value="${c.game.getID()}">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <button class="btn btn-link" type="submit">Редактировать</button>
                    </td>
                </form>
                <td>
                    <form method="post" action="/cart/remove">
                        <input type="hidden" name="id" value="${c.game.getID()}">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <button class="btn btn-link" type="submit">Удалить</button>
                    </form>
                </td>
            </tr>
        </#list>
        </tbody>
        <tr>
            <td>Общая сумма: ${cart.getTotalPrice()!""}</td>
        </tr>
    </table>
    <#if name != "Guest">
        <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button"
           aria-expanded="false"
           aria-controls="collapseExample">
            Оформить заказ
        </a>
        <div class="collapse" id="collapseExample">
            <form method="post" action="/cart/order">
                <div class="col col-md-6 mt-3">
                    <label>Имя:</label>
                    <input type="text" class="form-control"
                           value="<#if user??>${user.firstName!""}</#if>" placeholder="First name" name="firstName">
                    <label>Фамилия:</label>
                    <input type="text" class="form-control"
                           value="<#if user??>${user.lastName!""}</#if>" placeholder="Last name" name="lastName">
                </div>
                <div class="form-group col-md-6">
                    <label for="inputEmail4">Email:</label>
                    <input type="email" class="form-control"
                           value="<#if user??>${user.email!""}</#if>" id="inputEmail4" placeholder="Email"
                           name="email">
                </div>
                <div class="form-check">
                    <div>
                        <label>
                            <input type="checkbox" name="save" class="form-check-input">
                            Сохранить для следующих заказов?
                        </label>
                    </div>
                </div>
                <input type="hidden" name="userId" value="${user.id}"/>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-primary ml-3 mb-3" value="Заказать"> Заказать</button>
            </form>
        </div>
    <#else>
        <h3>Чтобы оформить заказ нужно <a href="login.ftlh"> авторизоваться или зарегистрироваться </a></h3>
    </#if>
</@c.page>
