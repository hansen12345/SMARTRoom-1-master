<?php
    $host = "SMARTRoom.czjl1dned5qh.us-west-2.rds.amazonaws.com";
    $db = "SMARTRoom";
    $user = "front5";
    $pass = "fronttoback";
    
    $connection = mysql_connect($host, $user, $pass);
    
    if(!$connection)
    {
        die("Database server connection failed.");
    }
    $sql = 'SELECT username, pw FROM Customer';
    mysql_select_db('SMARTRoom');
    
    $retreval = mysql_query( $sql, $connection );
    
    if (! $retreval) {
        die( 'could not get data: ' . mysql_error());
    }
    $temploginmysql = array();
    $login = "login";
    $inside = array();
    
    while ($row = mysql_fetch_array($retreval, MYSQL_ASSOC)) {
        $count++;
        $login = "login$count";
        $inside = array($row_array[$login] ['username'] = $row['username'], $row_array[$login]['password'] = $row['pw']);
    
    }
        array_push ($temploginmysql, $row_array);
                        
        echo json_encode($temploginmysql);
        json_encode($temploginmysql);
        $fp =fopen('loginUser.json', 'w');
        fwrite($fp, json_encode($temploginmysql));
        echo "fetched data sucessfully\n";
        mysql_close($connection);
?>
