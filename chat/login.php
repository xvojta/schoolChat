<?php
require_once("layout/header.php")
?>

<h2>Login</h2>
<form onsubmit="return login(this);">
    Email <br>
    <input type="email" name="email" id=""> <br>
    Password <br>
    <input type="password" name="password" id=""> <br>
    <button type="submit">Log in</button>
</form>

<script>
    function login(event)
    {
        $email = (event.email.value);
        $password = (event.password.value);
        //document.getElementById()
    }
</script>

<?php
require_once("layout/footer.php")
?>