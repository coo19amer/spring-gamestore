<#macro login path>
    <form action="${path}" method="post">
        <div class="form-group col-md-4">
            <label> Имя пользователя: </label>
            <input class="form-control" type="text" name="username"/>
        </div>
        <div class="form-group col-md-4">
            <label> Пароль: </label>
            <input class="form-control" type="password" name="password"/>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <div><input class="btn btn-primary" type="submit" value="Войти"/></div>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <div>
            <input class="btn btn-primary ml-4 mr-4" type="submit" value="Выйти"/>
        </div>
    </form>
</#macro>

<#macro registration path>
    <form action="${path}" method="post">
        <div class="form-row">
            <div class="col">
                <label>Имя:</label>
                <input type="text" class="form-control ${(firstNameError??)?string('is-invalid', '')}"
                       value="<#if user??>${user.firstName}</#if>" placeholder="First name" name="firstName">
                <#if firstNameError??>
                    <div class="invalid-feedback mb-2">
                        ${firstNameError}
                    </div>
                </#if>
            </div>
            <div class="col">
                <label>Фамилия:</label>
                <input type="text" class="form-control ${(lastNameError??)?string('is-invalid', '')}"
                       value="<#if user??>${user.lastName}</#if>" placeholder="Last name" name="lastName">
                <#if lastNameError??>
                    <div class="invalid-feedback mb-2">
                        ${lastNameError}
                    </div>
                </#if>
            </div>
            <div class="form-group col-md-4">
                <label for="inputUsername"> Имя пользователя: </label>
                <input class="form-control ${(usernameError??)?string('is-invalid', '')}" type="text"
                       value="<#if user??>${user.username!""}</#if>" name="username" id="inputUsername"
                       placeholder="noname220"/>
                <#if usernameError??>
                    <div class="invalid-feedback mb-2">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inputEmail4">Email</label>
                <input type="email" class="form-control ${(emailError??)?string('is-invalid', '')}"
                       value="<#if user??>${user.email!""}</#if>" id="inputEmail4" placeholder="Email" name="email">
                <#if emailError??>
                    <div class="invalid-feedback mb-2">
                        ${emailError}
                    </div>
                </#if>
            </div>
            <div class="form-group col-md-6">
                <label for="inputPassword4">Пароль</label>
                <input type="password" class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       id="inputPassword4" placeholder="Password" name="password">
                <#if passwordError??>
                    <div class="invalid-feedback mb-2">
                        ${passwordError}
                    </div>
                </#if>
            </div>
            <div class="form-group col-md-6">
                <label for="inputPassword4">Подтвердите пароль</label>
                <input type="password" class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       id="inputPassword4" placeholder="Retype password" name="password2">
                <#if password2Error??>
                    <div class="invalid-feedback mb-2">
                        ${password2Error}
                    </div>
                </#if>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Зарегистрироваться</button>
    </form>
</#macro>