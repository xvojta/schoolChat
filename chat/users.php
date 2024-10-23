<?php
require_once("layout/header.php")
?>

<h1>Uzivatele</h1>

<?php
    $host="localhost";
    $port=3306;
    $socket="";
    $user="root";
    $password="root";
    $dbname="chat";
    
    $con = new mysqli($host, $user, $password, $dbname, $port, $socket)
        or die ('Could not connect to the database server' . mysqli_connect_error());
    
    //$con->close();
    $query = "SELECT id, username, role FROM users";

    if ($stmt = $con->prepare($query)) {
        $stmt->execute();
        $stmt->bind_result($field1, $field2, $field3);
        while ($stmt->fetch()) {
            echo "<p>" . $field1 . " " . $field2 . " " . $field3 . "</p>";
            //printf("%s, %s\n", $field1, $field2);
        }
        $stmt->close();
    }        
?>

<?php
require_once("layout/footer.php")
?>